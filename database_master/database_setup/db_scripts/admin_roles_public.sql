SET search_path = public;

CREATE ROLE "app_admin" LOGIN PASSWORD 'adminpwd'
SUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION
     VALID UNTIL 'infinity';

CREATE ROLE "app_owner" LOGIN PASSWORD 'ownerpwd'
CREATEDB CREATEROLE
     VALID UNTIL 'infinity';
