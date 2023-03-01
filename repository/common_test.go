package repository_test

import (
	"context"
	"crypto/ecdsa"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/julienschmidt/httprouter"
	"github.com/sirupsen/logrus"
	"github.com/ttab/elephant/internal/test"
	"github.com/ttab/elephant/repository"
	rpc "github.com/ttab/elephant/rpc/repository"
	"github.com/twitchtv/twirp"
)

type TestContext struct {
	SigningKey       *ecdsa.PrivateKey
	Server           *httptest.Server
	WorkflowProvider repository.WorkflowProvider
	Documents        rpc.Documents
	Schemas          rpc.Schemas
	Workflows        rpc.Workflows
	Env              test.Environment
}

func (tc *TestContext) DocumentsClient( //nolint:ireturn
	t *testing.T, claims repository.JWTClaims,
) rpc.Documents {
	t.Helper()

	token, err := test.AccessKey(tc.SigningKey, claims)
	test.Must(t, err, "create access key")

	docClient := rpc.NewDocumentsProtobufClient(
		tc.Server.URL, tc.Server.Client(),
		twirp.WithClientHooks(&twirp.ClientHooks{
			RequestPrepared: func(ctx context.Context, r *http.Request) (context.Context, error) {
				r.Header.Set("Authorization", "Bearer "+token)

				return ctx, nil
			}}))

	return docClient
}

func (tc *TestContext) WorkflowsClient( //nolint:ireturn
	t *testing.T, claims repository.JWTClaims,
) rpc.Workflows {
	t.Helper()

	token, err := test.AccessKey(tc.SigningKey, claims)
	test.Must(t, err, "create access key")

	workflowsClient := rpc.NewWorkflowsProtobufClient(
		tc.Server.URL, tc.Server.Client(),
		twirp.WithClientHooks(&twirp.ClientHooks{
			RequestPrepared: func(ctx context.Context, r *http.Request) (context.Context, error) {
				r.Header.Set("Authorization", "Bearer "+token)

				return ctx, nil
			}}))

	return workflowsClient
}

func (tc *TestContext) SchemasClient( //nolint:ireturn
	t *testing.T, claims repository.JWTClaims,
) rpc.Schemas {
	t.Helper()

	token, err := test.AccessKey(tc.SigningKey, claims)
	test.Must(t, err, "create access key")

	schemasClient := rpc.NewSchemasProtobufClient(
		tc.Server.URL, tc.Server.Client(),
		twirp.WithClientHooks(&twirp.ClientHooks{
			RequestPrepared: func(ctx context.Context, r *http.Request) (context.Context, error) {
				r.Header.Set("Authorization", "Bearer "+token)

				return ctx, nil
			}}))

	return schemasClient
}

func testingAPIServer(
	t *testing.T, logger *logrus.Logger, runArchiver bool,
) TestContext {
	t.Helper()

	env := test.SetUpBackingServices(t, false)
	ctx := test.Context(t)

	dbpool, err := pgxpool.New(ctx, env.PostgresURI)
	test.Must(t, err, "create connection pool")

	t.Cleanup(func() {
		// We don't want to block cleanup waiting for pool.
		go dbpool.Close()
	})

	store, err := repository.NewPGDocStore(logger, dbpool)
	test.Must(t, err, "create doc store")

	go store.RunListener(ctx)

	if runArchiver {
		archiver := repository.NewArchiver(repository.ArchiverOptions{
			Logger: logger,
			S3:     env.S3,
			Bucket: env.Bucket,
			DB:     dbpool,
		})

		err = archiver.Run(ctx)
		test.Must(t, err, "run archiver")
	}

	validator, err := repository.NewValidator(
		ctx, logger, store)
	test.Must(t, err, "create validator")

	workflows, err := repository.NewWorkflows(ctx, logger, store)
	test.Must(t, err, "create workflows")

	docService := repository.NewDocumentsService(store, validator, workflows)
	schemaService := repository.NewSchemasService(store)
	workflowService := repository.NewWorkflowsService(store)

	router := httprouter.New()

	jwtKey, err := test.NewSigningKey()
	test.Must(t, err, "create signing key")

	err = repository.SetUpRouter(router,
		repository.WithDocumentsAPI(logger, jwtKey, docService),
		repository.WithSchemasAPI(logger, jwtKey, schemaService),
		repository.WithWorkflowsAPI(logger, jwtKey, workflowService))
	test.Must(t, err, "set up router")

	server := httptest.NewServer(router)

	t.Cleanup(server.Close)

	return TestContext{
		SigningKey:       jwtKey,
		Server:           server,
		Documents:        docService,
		Workflows:        workflowService,
		Schemas:          schemaService,
		WorkflowProvider: workflows,
		Env:              env,
	}
}