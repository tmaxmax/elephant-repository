--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2 (Debian 15.2-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: document_schema; Type: TABLE DATA; Schema: public; Owner: repository
--

INSERT INTO public.document_schema (name, version, spec) VALUES ('tt', 'v1.0.0', '{"name": "TT", "version": 1, "documents": [{"meta": [{"data": {"initials": {"optional": true}, "signature": {"optional": true}}, "name": "TT contact extensions", "match": {"type": {"const": "core/contact-info"}}, "description": "TODO: why the duplicate signature/initials/short desc?"}], "links": [{"name": "Same as TT Author", "declares": {"rel": "same-as", "type": "tt/author"}, "attributes": {"uri": {"glob": ["tt://author/*"]}, "title": {}}, "description": "Marks the author as a special TT author"}], "match": {"type": {"const": "core/author"}}}, {"links": [{"name": "TT Organiser", "declares": {"rel": "organiser", "type": "tt/organiser"}, "attributes": {"uri": {}, "title": {}}, "description": "TODO: is this good data, or just noise?"}, {"name": "TT Participant", "declares": {"rel": "participant", "type": "tt/participant"}, "attributes": {"uri": {}, "title": {}}, "description": "TODO: is this good data, or just noise?"}], "match": {"type": {"const": "core/event"}}}, {"links": [{"data": {"id": {"format": "int"}}, "declares": {"rel": "same-as", "type": "iptc/mediatopic"}, "attributes": {"uri": {"glob": ["iptc://mediatopic/*"]}}}], "match": {"type": {"const": "core/category"}}, "attributes": {"uri": {"glob": ["iptc://mediatopic/*"]}}}, {"meta": [{"declares": {"type": "tt/type"}, "attributes": {"value": {}}}], "match": {"type": {"const": "core/organisation"}}}, {"meta": [{"declares": {"type": "tt/slugline"}, "attributes": {"value": {}}}, {"name": "Sector", "declares": {"type": "tt/sector"}, "attributes": {"value": {}}, "description": "TODO: what is sector?"}], "links": [{"data": {"id": {}}, "name": "Same as TT event", "declares": {"rel": "same-as", "type": "tt/event"}, "attributes": {"uri": {"glob": ["tt://event/*"]}}, "description": "TODO: what is this? Maybe a one-off, was in 69da3ef5-f1b0-5caf-b846-ca5682b9adf9"}, {"name": "Content size", "match": {"type": {"const": "core/content-size"}}, "attributes": {"uri": {"enum": ["core://content-size/article/medium"]}}, "description": "Specifies the content sizes we can use"}, {"name": "Alternate ID", "declares": {"rel": "alternate", "type": "tt/alt-id"}, "attributes": {"uri": {}}, "description": "TODO: is this actually used for live data? See stage/df6ebaba-b3fc-40ff-9ad2-19f953eb0c6a"}], "match": {"type": {"const": "core/article"}}, "content": [{"data": {"text": {"allowEmpty": true}}, "name": "Dateline", "declares": {"type": "tt/dateline"}, "description": "TODO: there MUST be a better name for this!"}, {"data": {"text": {"format": "html", "allowEmpty": true}}, "name": "Question", "declares": {"type": "tt/question"}}, {"data": {"caption": {"allowEmpty": true}}, "name": "TT visual element", "links": [{"data": {"width": {"format": "int"}, "credit": {}, "height": {"format": "int"}, "hiresScale": {"format": "float"}}, "declares": {"rel": "self"}, "attributes": {"uri": {}, "url": {}, "type": {"enum": ["tt/picture", "tt/graphic"]}}}], "declares": {"type": "tt/visual"}, "description": "This can be either a picture or a graphic"}]}]}');
INSERT INTO public.document_schema (name, version, spec) VALUES ('core', 'v1.0.0', '{"meta": [{"data": {"text": {"allowEmpty": true}}, "declares": {"type": "core/note"}, "attributes": {"role": {"enum": ["public", "internal"]}}}, {"data": {"text": {"allowEmpty": true}}, "name": "Description", "declares": {"type": "core/description"}, "attributes": {"role": {"enum": ["public", "internal"]}}, "description": "A public or internal description of the entity"}, {"data": {"text": {"allowEmpty": true}}, "declares": {"type": "core/definition"}, "attributes": {"role": {"enum": ["short", "long"]}}}], "name": "Core", "version": 1, "documents": [{"meta": [{"data": {"geometry": {"description": "TODO: add a WKT format?"}}, "declares": {"type": "core/position"}}], "name": "Place", "declares": "core/place", "description": "A geographical location"}, {"name": "Section", "declares": "core/section", "description": "An section for content"}, {"name": "Topic", "declares": "core/topic", "description": "An topic for content"}, {"name": "Story", "declares": "core/story", "description": "An ongoing story that gets reported on"}, {"meta": [{"declares": {"type": "core/contact-info"}}], "name": "Person", "declares": "core/person", "description": "Used to describe people"}, {"meta": [{"data": {"city": {"optional": true, "description": "TODO: only in 83d072c8-fb07-47e2-9c5b-85f4453835f6?"}, "name": {"optional": true}, "email": {"optional": true}, "phone": {"optional": true}, "mobile": {"optional": true}, "country": {"optional": true, "description": "TODO: only in 83d072c8-fb07-47e2-9c5b-85f4453835f6?"}, "lastName": {"optional": true}, "firstName": {"optional": true}, "postalCode": {"optional": true, "description": "TODO: only in 83d072c8-fb07-47e2-9c5b-85f4453835f6?"}, "streetAddress": {"optional": true, "description": "TODO: only in 83d072c8-fb07-47e2-9c5b-85f4453835f6?"}}, "declares": {"type": "core/contact-info"}}], "name": "Author", "links": [{"name": "Association with NavigaID user account", "declares": {"rel": "same-as", "type": "x-imid/user"}, "attributes": {"uri": {"glob": ["imid://user/sub/*"]}}}], "declares": "core/author", "description": "An author document used for f.ex. bylines"}, {"name": "Category", "links": [{"declares": {"rel": "broader"}, "attributes": {"uri": {"optional": true}, "type": {}, "uuid": {"optional": true}}}], "declares": "core/category", "description": "A category for content"}, {"name": "Channel", "declares": "core/channel", "description": "A publication channel"}, {"meta": [{"data": {"end": {"format": "RFC3339", "optional": true}, "score": {"format": "int"}, "duration": {"format": "int", "optional": true}}, "declares": {"type": "core/newsvalue"}}], "name": "Article", "links": [{"data": {"email": {"optional": true}, "phone": {"optional": true}, "lastName": {"optional": true}, "firstName": {"optional": true}, "longDescription": {"optional": true}, "shortDescription": {"optional": true}}, "name": "Author byline", "declares": {"rel": "author", "type": "core/author"}, "attributes": {"uuid": {"optional": true}, "title": {}}}, {"name": "Section", "declares": {"rel": "subject", "type": "core/section"}, "attributes": {"uuid": {}, "title": {}}}, {"name": "Story", "declares": {"rel": "subject", "type": "core/story"}, "attributes": {"uuid": {}, "title": {}}}, {"declares": {"rel": "channel", "type": "core/channel"}, "attributes": {"uuid": {}, "title": {}}}, {"name": "Premium", "declares": {"rel": "premium", "type": "core/premium"}, "attributes": {"uri": {"glob": ["core://premium/*"]}, "title": {}}}, {"data": {"email": {"optional": true}, "phone": {"optional": true}, "lastName": {"optional": true}, "firstName": {"optional": true}}, "name": "Person", "declares": {"rel": "subject", "type": "core/person"}, "attributes": {"uuid": {}, "title": {}}, "description": "A person that is a subject of the article"}, {"name": "Category", "declares": {"rel": "subject", "type": "core/category"}, "attributes": {"uri": {"optional": true}, "uuid": {}, "title": {}}}, {"name": "Content size", "declares": {"rel": "content-size", "type": "core/content-size"}, "attributes": {"uri": {}, "title": {}}, "description": "Content size classification, described by URI"}, {"name": "Content source", "declares": {"rel": "source", "type": "core/content-source"}, "attributes": {"uri": {}}, "description": "The organisation that is the source of the content"}, {"name": "Article source", "declares": {"rel": "source", "type": "core/article"}, "attributes": {"uuid": {}}, "description": "Points to the original article if this one is a copy"}, {"name": "Assignment", "declares": {"rel": "assignment", "type": "core/assignment"}, "attributes": {"uuid": {}}, "description": "A link to the assignment that the article was produced for"}], "content": [{"data": {"text": {"format": "html", "allowEmpty": true}}, "declares": {"type": "core/heading-1"}}, {"data": {"text": {"format": "html", "allowEmpty": true}}, "declares": {"type": "core/heading-2"}}, {"data": {"text": {"format": "html", "allowEmpty": true}}, "declares": {"type": "core/heading-3"}}, {"data": {"text": {"format": "html", "allowEmpty": true}}, "declares": {"type": "core/heading-4"}}, {"data": {"text": {"format": "html", "allowEmpty": true}}, "declares": {"type": "core/paragraph"}}, {"data": {"text": {"format": "html", "allowEmpty": true}}, "declares": {"type": "core/preamble"}}, {"name": "Core image block", "links": [{"data": {"text": {"optional": true, "allowEmpty": true}, "width": {"format": "int"}, "height": {"format": "int"}, "alttext": {"optional": true, "allowEmpty": true}}, "links": [{"declares": {"rel": "author", "type": "core/author"}, "attributes": {"uuid": {}, "title": {}}}], "declares": {"rel": "self", "type": "core/image"}, "attributes": {"uri": {"glob": ["core://image/*"]}, "uuid": {}}}], "declares": {"type": "core/image"}, "attributes": {"uuid": {}}}, {"data": {"start": {"format": "int"}}, "links": [{"declares": {"rel": "alternate", "type": "text/html"}, "attributes": {"url": {"glob": ["https://www.youtube.com/**"]}, "title": {}}}, {"data": {"width": {"format": "int"}, "height": {"format": "int"}}, "declares": {"rel": "alternate", "type": "image/jpg"}, "attributes": {"url": {}}}], "declares": {"type": "core/youtube"}, "attributes": {"uri": {"glob": ["https://www.youtube.com/**"]}, "url": {"glob": ["https://www.youtube.com/**"]}}}, {"data": {"text": {"format": "html", "allowEmpty": true}}, "declares": {"type": "core/blockquote"}}, {"data": {"text": {"allowEmpty": true, "description": "TODO: add ''anything goes'' policy to revisor to be able to use the html format validation for free-form html"}}, "declares": {"type": "core/htmlembed"}}, {"content": [{"data": {"text": {"format": "html", "allowEmpty": true}}, "declares": {"type": "core/paragraph"}}], "declares": {"type": "core/unordered-list"}}, {"content": [{"data": {"text": {"format": "html", "allowEmpty": true}}, "declares": {"type": "core/paragraph"}}], "declares": {"type": "core/ordered-list"}}, {"data": {"byline": {}}, "declares": {"type": "core/factbox"}, "attributes": {"title": {}}, "blocksFrom": [{"kind": "content", "global": true, "docType": "core/article"}]}, {"data": {"meta": {"allowEmpty": true}, "tbody": {"format": "html", "htmlPolicy": "table"}, "tfoot": {"format": "html", "optional": true, "htmlPolicy": "table"}, "thead": {"format": "html", "optional": true, "htmlPolicy": "table"}, "caption": {"optional": true, "allowEmpty": true}}, "name": "Table", "declares": {"type": "core/table"}}, {"name": "Social embed", "links": [{"name": "Twitter embed link", "declares": {"rel": "self", "type": "core/tweet"}, "attributes": {"uri": {"glob": ["core://tweet/*"]}, "url": {"glob": ["https://twitter.com/**"]}}}, {"name": "Instagram embed link", "declares": {"rel": "self", "type": "core/instagram"}, "attributes": {"uri": {"glob": ["core://instagram/*"]}, "url": {"glob": ["https://www.instagram.com/**"]}}}, {"data": {"context": {}, "provider": {}}, "name": "Embed location link", "declares": {"rel": "alternate", "type": "text/html"}, "attributes": {"url": {}, "title": {}}}, {"data": {"width": {"format": "int"}, "height": {"format": "int"}}, "name": "Embed image", "declares": {"rel": "alternate", "type": "image/jpg"}, "attributes": {"url": {}}}], "declares": {"type": "core/socialembed"}}], "declares": "core/article", "description": "An editorial article"}, {"meta": [{"data": {"kontid": {"description": "TODO: this might be a reference to an ID in a old system, in that case, move to link."}}, "name": "Main metadata block", "count": 1, "declares": {"type": "core/group"}}], "name": "Contacts group", "declares": "core/group", "description": "A group used to categorise contacts"}, {"meta": [{"data": {"title": {"optional": true}, "kontid": {"optional": true, "description": "TODO: this might be a reference to an ID in a old system, in that case, move to link."}, "employer": {"optional": true}, "lastName": {"optional": true}, "firstName": {"optional": true}}, "name": "Main metadata block", "count": 1, "declares": {"type": "core/contact"}}, {"data": {"name": {"optional": true}, "email": {"optional": true}, "phone": {"optional": true}, "mobile": {"optional": true}, "address": {"optional": true}, "country": {"optional": true}, "locality": {"optional": true}}, "links": [{"name": "Webpage", "declares": {"rel": "see-also", "type": "text/html"}, "attributes": {"url": {"glob": ["http://**", "https://**"]}}}], "declares": {"type": "core/contact-info"}, "attributes": {"role": {"enum": ["home", "office"]}}}], "name": "Contact information", "links": [{"name": "Groups", "declares": {"rel": "group", "type": "core/group"}, "attributes": {"uuid": {}, "title": {}}, "description": "The groups that the contact is assigned to"}], "declares": "core/contact", "description": "A useful contact"}, {"meta": [{"data": {"end": {"format": "RFC3339"}, "start": {"format": "RFC3339"}, "endDate": {"time": "2006-01-02"}, "startDate": {"time": "2006-01-02"}, "dateGranularity": {"enum": ["date", "datetime"]}}, "name": "Main metadata block", "count": 1, "declares": {"type": "core/assignment"}}, {"name": "Assignment type", "declares": {"type": "core/assignment-type"}, "minCount": 1, "attributes": {"value": {"enum": ["text", "picture", "video", "graphic"]}}}], "name": "Assignment", "links": [{"data": {"email": {"optional": true}, "shortDescription": {"optional": true}}, "name": "Assigned person", "declares": {"rel": "assigned-to", "type": "core/author"}, "attributes": {"uuid": {}, "title": {}}}], "declares": "core/assignment", "description": "A work assignment"}, {"meta": [{"data": {"end": {"format": "RFC3339"}, "start": {"format": "RFC3339"}, "priority": {"format": "int"}, "registration": {"allowEmpty": true}, "dateGranularity": {"enum": ["date", "datetime"]}}, "name": "Main metadata block", "count": 1, "declares": {"type": "core/event"}}], "name": "Calendar event", "links": [{"name": "Section", "declares": {"rel": "section", "type": "core/section"}, "attributes": {"uri": {}, "title": {}, "value": {}}}, {"name": "Organiser", "declares": {"rel": "organiser", "type": "core/organisation"}, "attributes": {"uuid": {}, "title": {}}}, {"name": "Participant", "declares": {"rel": "participant", "type": "core/author"}, "attributes": {"uuid": {}, "title": {}}}, {"name": "Place", "declares": {"rel": "place", "type": "core/place"}, "attributes": {"uuid": {}, "title": {}}}, {"name": "Story", "declares": {"rel": "story", "type": "core/story"}, "attributes": {"uuid": {}, "title": {}}}, {"name": "Category", "declares": {"rel": "category", "type": "core/category"}, "attributes": {"uri": {"optional": true}, "uuid": {}, "title": {}}}, {"name": "Topic", "declares": {"rel": "subject", "type": "core/topic"}, "attributes": {"uuid": {}, "title": {}}}, {"data": {"name": {}, "country": {}, "geometry": {}, "locality": {}, "extraInfo": {"allowEmpty": true}}, "name": "Geo position", "declares": {"rel": "location", "type": "core/geo-point"}, "attributes": {"uri": {"glob": ["geo://point/*"]}, "title": {}}}, {"name": "Copyright holder", "declares": {"rel": "copyrightholder"}, "attributes": {"title": {}}, "description": "TODO: do we really need this?"}], "declares": "core/event", "description": "A calendar event"}, {"meta": [{"data": {"city": {"optional": true}, "email": {"optional": true}, "phone": {"optional": true}, "country": {"optional": true}, "streetAddress": {"optional": true}}, "name": "Organisation contact information", "count": 1, "declares": {"type": "core/contact-info"}}], "name": "Organisation", "links": [{"name": "Browseable link for the organisation", "declares": {"rel": "see-also", "type": "text/html"}, "attributes": {"url": {}}, "description": "Usually the homepage or other resources that describe the organisation"}, {"name": "Facebook page for the organisation", "declares": {"rel": "see-also", "type": "x-im/social+facebook"}, "attributes": {"url": {}}}], "declares": "core/organisation", "description": "A document describing an organisation"}, {"meta": [{"data": {"end": {"format": "RFC3339"}, "slug": {"allowEmpty": true}, "start": {"format": "RFC3339"}, "endDate": {"time": "2006-01-02"}, "priority": {"format": "int"}, "startDate": {"time": "2006-01-02"}, "description": {"allowEmpty": true}, "dateGranularity": {"enum": ["date", "datetime"]}, "publicDescription": {"allowEmpty": true}}, "name": "Main metadata block", "count": 1, "declares": {"type": "core/newscoverage"}}], "name": "Planning item", "links": [{"declares": {"rel": "section", "type": "core/section"}, "attributes": {"uuid": {}, "title": {}}}, {"declares": {"rel": "event", "type": "core/event"}, "attributes": {"uuid": {}, "title": {}}}, {"declares": {"rel": "category", "type": "core/category"}, "attributes": {"uri": {"optional": true}, "uuid": {}, "title": {}}}, {"declares": {"rel": "story", "type": "core/story"}, "attributes": {"uuid": {}, "title": {}}}, {"declares": {"rel": "channel", "type": "core/channel"}, "attributes": {"uuid": {}, "title": {}}}, {"declares": {"rel": "place", "type": "core/place"}, "attributes": {"uuid": {}, "title": {}}}, {"declares": {"rel": "content-profile", "type": "core/content-profile"}, "attributes": {"uuid": {}, "title": {}}}, {"name": "Assignments", "declares": {"rel": "assignment", "type": "core/assignment"}, "attributes": {"uuid": {}}, "description": "The assignments that are part of covering this story"}, {"declares": {"rel": "copyrightholder"}, "attributes": {"title": {}}, "description": "TODO: Is this really necessary for a planning item?"}, {"declares": {"rel": "sector"}, "attributes": {"title": {}, "value": {}}}], "declares": "core/newscoverage", "description": "Planned news coverage"}], "htmlPolicies": [{"name": "default", "elements": {"a": {"attributes": {"id": {"optional": true}, "href": {"optional": true}}}, "em": {"attributes": {"id": {"optional": true}}}, "strong": {"attributes": {"id": {"optional": true}}}}}, {"name": "table", "uses": "default", "elements": {"td": {"attributes": {"id": {"optional": true}, "colspan": {"format": "int", "optional": true}}}, "th": {"attributes": {"id": {"optional": true}, "colspan": {"format": "int", "optional": true}}}, "tr": {"attributes": {"id": {"optional": true}}}}}]}');


--
-- Data for Name: active_schemas; Type: TABLE DATA; Schema: public; Owner: repository
--

INSERT INTO public.active_schemas (name, version) VALUES ('tt', 'v1.0.0');
INSERT INTO public.active_schemas (name, version) VALUES ('core', 'v1.0.0');


--
-- PostgreSQL database dump complete
--

