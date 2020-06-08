
ALTER TABLE ONLY "public"."users" ALTER COLUMN "auth0_data" DROP DEFAULT;
alter table "public"."users" rename column "auth0_user" to "auth0_data";

DROP TRIGGER IF EXISTS "set_public_logins_updated_at" ON "public"."logins";
ALTER TABLE "public"."logins" DROP COLUMN "updated_at";

ALTER TABLE "public"."logins" DROP COLUMN "created_at";

ALTER TABLE "public"."logins" ADD COLUMN "updated_at" timestamptz;
ALTER TABLE "public"."logins" ALTER COLUMN "updated_at" DROP NOT NULL;
ALTER TABLE "public"."logins" ALTER COLUMN "updated_at" SET DEFAULT now();

ALTER TABLE "public"."logins" ADD COLUMN "created_at" timestamptz;
ALTER TABLE "public"."logins" ALTER COLUMN "created_at" DROP NOT NULL;
ALTER TABLE "public"."logins" ALTER COLUMN "created_at" SET DEFAULT now();

DROP TABLE "public"."users";

ALTER TABLE "public"."logins" DROP COLUMN "uuid";

DROP TABLE "public"."logins";
