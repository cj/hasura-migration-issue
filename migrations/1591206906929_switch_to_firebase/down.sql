

alter table "public"."users" drop constraint "users_firebase_id_key";
alter table "public"."users" add constraint "users_firebase_id_key" unique ("firebase_id");

alter table "public"."users" rename column "firebase_user" to "auth0_user";

alter table "public"."users" rename column "firebase_id" to "auth0_id";

alter table "public"."users" drop constraint "users_firebase_id_key";
alter table "public"."users" add constraint "users_firebase_id_key" unique ("firebase_id");

alter table "public"."users" rename column "firebase_user" to "auth0_user";

alter table "public"."users" rename column "firebase_id" to "auth0_id";
