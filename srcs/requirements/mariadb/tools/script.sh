#!/bin/bash

service mariadb start

sleep 2

MYSQL_DB_USER=${MYSQL_DB_USER:-wordpress}
MYSQL_DB_NAME=${MYSQL_DB_NAME:-wordpress}
MYSQL_PASSWORD=$(cat ${MYSQL_PASSWORD_FILE})
MYSQL_ROOT_PASSWORD=$(cat ${MYSQL_ROOT_PASSWORD_FILE})

echo -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DB_NAME};
CREATE USER '${MYSQL_DB_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DB_NAME}.* TO '${MYSQL_DB_USER}'@'%';
FLUSH PRIVILEGES;" > db.sql

mysql -u root -p${MYSQL_ROOT_PASSWORD} < db.sql

rm db.sql

service mariadb stop

exec "$@"