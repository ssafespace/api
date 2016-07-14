--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    phone text NOT NULL,
    secret text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: histories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE histories (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    topic_id uuid NOT NULL,
    host_id uuid NOT NULL,
    guest_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE locations (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    latitude text NOT NULL,
    longitude text NOT NULL,
    history_id uuid NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE messages (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    body text NOT NULL,
    history_id uuid NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: receipts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE receipts (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    history_id uuid NOT NULL,
    message_id uuid NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: topics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE topics (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY histories
    ADD CONSTRAINT histories_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipts
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: index_accounts_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_created_at ON accounts USING btree (created_at);


--
-- Name: index_accounts_on_phone; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_phone ON accounts USING btree (phone);


--
-- Name: index_accounts_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_updated_at ON accounts USING btree (updated_at);


--
-- Name: index_histories_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_histories_on_created_at ON histories USING btree (created_at);


--
-- Name: index_histories_on_guest_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_histories_on_guest_id ON histories USING btree (guest_id);


--
-- Name: index_histories_on_host_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_histories_on_host_id ON histories USING btree (host_id);


--
-- Name: index_histories_on_topic_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_histories_on_topic_id ON histories USING btree (topic_id);


--
-- Name: index_histories_on_topic_id_and_host_id_and_guest_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_histories_on_topic_id_and_host_id_and_guest_id ON histories USING btree (topic_id, host_id, guest_id);


--
-- Name: index_histories_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_histories_on_updated_at ON histories USING btree (updated_at);


--
-- Name: index_locations_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locations_on_account_id ON locations USING btree (account_id);


--
-- Name: index_locations_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locations_on_created_at ON locations USING btree (created_at);


--
-- Name: index_locations_on_history_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locations_on_history_id ON locations USING btree (history_id);


--
-- Name: index_locations_on_latitude; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locations_on_latitude ON locations USING btree (latitude);


--
-- Name: index_locations_on_longitude; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locations_on_longitude ON locations USING btree (longitude);


--
-- Name: index_locations_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_locations_on_updated_at ON locations USING btree (updated_at);


--
-- Name: index_messages_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_account_id ON messages USING btree (account_id);


--
-- Name: index_messages_on_body; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_body ON messages USING btree (body);


--
-- Name: index_messages_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_created_at ON messages USING btree (created_at);


--
-- Name: index_messages_on_history_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_history_id ON messages USING btree (history_id);


--
-- Name: index_messages_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_messages_on_updated_at ON messages USING btree (updated_at);


--
-- Name: index_receipts_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipts_on_account_id ON receipts USING btree (account_id);


--
-- Name: index_receipts_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipts_on_created_at ON receipts USING btree (created_at);


--
-- Name: index_receipts_on_history_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipts_on_history_id ON receipts USING btree (history_id);


--
-- Name: index_receipts_on_history_id_and_message_id_and_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_receipts_on_history_id_and_message_id_and_account_id ON receipts USING btree (history_id, message_id, account_id);


--
-- Name: index_receipts_on_message_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_receipts_on_message_id ON receipts USING btree (message_id);


--
-- Name: index_receipts_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_receipts_on_updated_at ON receipts USING btree (updated_at);


--
-- Name: index_topics_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topics_on_created_at ON topics USING btree (created_at);


--
-- Name: index_topics_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_topics_on_name ON topics USING btree (name);


--
-- Name: index_topics_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_topics_on_updated_at ON topics USING btree (updated_at);


--
-- Name: fk_rails_0724528f4e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT fk_rails_0724528f4e FOREIGN KEY (history_id) REFERENCES histories(id);


--
-- Name: fk_rails_092259ded3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipts
    ADD CONSTRAINT fk_rails_092259ded3 FOREIGN KEY (message_id) REFERENCES messages(id);


--
-- Name: fk_rails_333a62ca91; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipts
    ADD CONSTRAINT fk_rails_333a62ca91 FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: fk_rails_347aa279b5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY histories
    ADD CONSTRAINT fk_rails_347aa279b5 FOREIGN KEY (host_id) REFERENCES accounts(id);


--
-- Name: fk_rails_58a5437d5d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT fk_rails_58a5437d5d FOREIGN KEY (history_id) REFERENCES histories(id);


--
-- Name: fk_rails_73e40680ca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY receipts
    ADD CONSTRAINT fk_rails_73e40680ca FOREIGN KEY (history_id) REFERENCES histories(id);


--
-- Name: fk_rails_a231e55201; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT fk_rails_a231e55201 FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: fk_rails_b6e485ebb7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT fk_rails_b6e485ebb7 FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: fk_rails_c4c7a7c565; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY histories
    ADD CONSTRAINT fk_rails_c4c7a7c565 FOREIGN KEY (topic_id) REFERENCES topics(id);


--
-- Name: fk_rails_d59dc178c2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY histories
    ADD CONSTRAINT fk_rails_d59dc178c2 FOREIGN KEY (guest_id) REFERENCES accounts(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20160518004513'), ('20160518004514'), ('20160714062348'), ('20160714062358'), ('20160714062420'), ('20160714062431'), ('20160714062440'), ('20160714063728');


