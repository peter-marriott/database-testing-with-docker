export SHELL=/bin/bash

SCRIPT_DIR=$(dirname "$BASH_SOURCE")
echo "SCRIPT_DIR: $SCRIPT_DIR"

echo "Creating admin roles"
psql --username "$POSTGRES_USER" -f $SCRIPT_DIR/db_scripts/admin_roles_public.sql
echo "Creating database"
psql --username "$POSTGRES_USER" -f $SCRIPT_DIR/db_scripts/create_app_db.sql
echo "Creating app roles"
psql --username "$POSTGRES_USER" -f $SCRIPT_DIR/db_scripts/application_roles_public.sql

echo 'Creating reporting schema'
psql --username "app_owner" -d app_db -f $SCRIPT_DIR/db_scripts/db_script_gen_reporting.sql
