#!/bin/bash

set -e

CERT_DIR="/etc/nginx/ssl"
DOMAIN_NAME="rbarkhud.42.fr"

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout "$CERT_DIR/nginx.key" \
			-out "$CERT_DIR/nginx.crt" \
			-subj "/C=AM/ST=Armenia/L=Yerevan/O=42/OU=Inception/CN=${DOMAIN_NAME}"

exec "$@"