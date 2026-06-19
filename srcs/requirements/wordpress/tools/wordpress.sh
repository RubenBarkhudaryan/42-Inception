#!/bin/bash
mkdir -p /var/www/html
cd /var/www/html

rm -rf *

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
WORDPRESS_ROOT_PASSWORD=$(cat /run/secrets/wordpress_root_password)
WORDPRESS_USER_PASSWORD=$(cat /run/secrets/wordpress_user_password)

# Download and set up WordPress using WP-CLI
if wp core download --allow-root; then
    echo "WordPress core downloaded successfully."
else
    echo "Failed to download WordPress core."
    exit 1
fi

if wp config create \
    --dbname="$MYSQL_DATABASE" \
    --dbuser="$MYSQL_USER" \
    --dbpass="$MYSQL_PASSWORD" \
    --dbhost="$MYSQL_HOSTNAME" \
    --allow-root \
    --skip-check; then
    echo "wp-config.php created with database credentials."
else
    echo "Failed to create wp-config.php."
    exit 1
fi

for _ in 1 2 3 4 5; do
    if wp db check --allow-root >/dev/null 2>&1; then
        break
    fi

    sleep 2
done

if ! wp db check --allow-root >/dev/null 2>&1; then
    echo "Database is not ready."
    exit 1
fi

if wp core install --url="$DOMAIN_NAME" \
    --title="$WORDPRESS_TITLE" \
    --admin_user="$WORDPRESS_ROOT_USERNAME" \
    --admin_password="$WORDPRESS_ROOT_PASSWORD" \
    --admin_email="$WORDPRESS_ROOT_EMAIL" \
    --skip-email --allow-root; then
    echo "WordPress installed successfully."
else
    echo "Failed to install WordPress."
    exit 1
fi

if wp user create "$WORDPRESS_USER_USERNAME" "$WORDPRESS_USER_EMAIL" \
    --role=subscriber \
    --user_pass="$WORDPRESS_USER_PASSWORD" \
    --allow-root; then
    echo "WordPress user created successfully."
fi

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

if wp core update --allow-root; then
    echo "WordPress core updated successfully."
else
    echo "Failed to update WordPress core."
    exit 1
fi

mkdir -p /run/php
chown -R www-data:www-data /run/php

if wp theme install twentytwentytwo --activate --allow-root; then
    echo "WordPress theme installed and activated successfully."
else
    echo "Failed to install and activate WordPress theme."
    exit 1
fi

exec "$@";