
alter table "public"."users" rename column "auth0_id" to "firebase_id";

alter table "public"."users" rename column "auth0_user" to "firebase_user";

alter table "public"."users" drop constraint "users_auth0_id_key";
alter table "public"."users" add constraint "users_firebase_id_key" unique ("firebase_id");


alter table "public"."users" rename column "auth0_id" to "firebase_id";

alter table "public"."users" rename column "auth0_user" to "firebase_user";

alter table "public"."users" drop constraint "users_auth0_id_key";
alter table "public"."users" add constraint "users_firebase_id_key" unique ("firebase_id");
