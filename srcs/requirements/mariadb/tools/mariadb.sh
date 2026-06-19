#!/bin/bash

service mariadb start

sleep 2

MYSQL_DB_USER=${MYSQL_DB_USER:-wordpress}
MYSQL_DB_NAME=${MYSQL_DB_NAME:-wordpress}
MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

echo -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DB_NAME};
CREATE USER IF NOT EXISTS '${MYSQL_DB_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DB_NAME}.* TO '${MYSQL_DB_USER}'@'%';
FLUSH PRIVILEGES;" > db.sql

mysql -u root -p${MYSQL_ROOT_PASSWORD} < db.sql

rm db.sql

service mariadb stop

exec "$@"