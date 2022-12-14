#!/bin/bash

# テナント毎にRLSで制限されたアクセスをするためのPOSTGRES_USER(root権限なので、ポリシー無用でアクセスできる)ではないユーザを作成
set -e

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
  CREATE USER ${POSTGRES_DB_USER} WITH ENCRYPTED PASSWORD '${POSTGRES_DB_USER_PASSWORD}';
  ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO ${POSTGRES_DB_USER};
  ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO ${POSTGRES_DB_USER};
EOSQL
