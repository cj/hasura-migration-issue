
CREATE TABLE "public"."logins"("id" bigserial NOT NULL, "data" jsonb NOT NULL DEFAULT jsonb_build_object(), "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), "ip" inet NOT NULL, PRIMARY KEY ("id") , UNIQUE ("id"));

CREATE EXTENSION IF NOT EXISTS pgcrypto;
ALTER TABLE "public"."logins" ADD COLUMN "uuid" uuid NOT NULL UNIQUE DEFAULT gen_random_uuid();

CREATE TABLE "public"."users"("id" bigserial NOT NULL, "name" text NOT NULL, "email" text NOT NULL, "email_verified" boolean NOT NULL, "auth0_id" text NOT NULL, "auth0_data" jsonb NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , UNIQUE ("email"), UNIQUE ("auth0_id"), CONSTRAINT "valid email" CHECK (email ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'));
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_users_updated_at"
BEFORE UPDATE ON "public"."users"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_users_updated_at" ON "public"."users" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

ALTER TABLE "public"."logins" DROP COLUMN "created_at" CASCADE;

ALTER TABLE "public"."logins" DROP COLUMN "updated_at" CASCADE;

ALTER TABLE "public"."logins" ADD COLUMN "created_at" timestamptz NULL DEFAULT now();

ALTER TABLE "public"."logins" ADD COLUMN "updated_at" timestamptz NULL DEFAULT now();

CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_logins_updated_at"
BEFORE UPDATE ON "public"."logins"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_logins_updated_at" ON "public"."logins" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

ALTER TABLE ONLY "public"."users" ALTER COLUMN "auth0_data" SET DEFAULT jsonb_build_object();
alter table "public"."users" rename column "auth0_data" to "auth0_user";
