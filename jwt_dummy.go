package docformat

import (
	"context"
	"crypto/ecdsa"
	"errors"
	"fmt"
	"strings"

	"github.com/golang-jwt/jwt/v4"
)

type JWTClaims struct {
	jwt.RegisteredClaims

	Name  string `json:"sub_name"`
	Scope string `json:"scope"`
}

func (c JWTClaims) HasScope(s string) bool {
	set := strings.Split(s, " ")

	for i := range set {
		if set[i] == s {
			return true
		}
	}

	return false
}

func (c JWTClaims) Valid() error {
	return c.RegisteredClaims.Valid()
}

type ctxKey int

const authInfoCtxKey ctxKey = 1

type AuthInfo struct {
	Claims JWTClaims
}

var ErrNoAuthorization = errors.New("no authorization provided")

func AuthInfoFromHeader(key *ecdsa.PublicKey, authorization string) (*AuthInfo, error) {
	if authorization == "" {
		return nil, nil
	}

	tokenType, token, _ := strings.Cut(authorization, " ")

	tokenType = strings.ToLower(tokenType)
	if tokenType != "bearer" {
		return nil, errors.New("only bearer tokens are supported")
	}

	var claims JWTClaims

	_, err := jwt.ParseWithClaims(token, &claims,
		func(t *jwt.Token) (interface{}, error) {
			return key, nil
		},
		jwt.WithValidMethods([]string{jwt.SigningMethodES384.Name}))
	if err != nil {
		return nil, fmt.Errorf("invalid token: %w", err)
	}

	if claims.Issuer != "test" {
		return nil, fmt.Errorf("invalid issuer %q", claims.Issuer)
	}

	return &AuthInfo{
		Claims: claims,
	}, nil
}

func SetAuthInfo(ctx context.Context, info *AuthInfo) context.Context {
	return context.WithValue(ctx, authInfoCtxKey, info)
}

func GetAuthInfo(ctx context.Context) (*AuthInfo, bool) {
	info, ok := ctx.Value(authInfoCtxKey).(*AuthInfo)
	return info, ok && info != nil
}

type TokenResponse struct {
	AccessToken string `json:"access_token"`
	TokenType   string `json:"token_type"`
	ExpiresIn   int    `json:"expires_in"`
}