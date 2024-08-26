#!/bin/bash

# Load environment variables
export $(grep -v '^#' .env | xargs)

# Install dependencies
composer install --no-dev --optimize-autoloader

# Paths for the SSL certificates
SSL_CERT_PATH="/etc/nginx/ssl/${DOMAIN_NAME}.crt"
SSL_KEY_PATH="/etc/nginx/ssl/${DOMAIN_NAME}.key"

# Obtain SSL certificates using lescript
php -r "
require 'vendor/autoload.php';
\$le = new Analogic\Lescript\Lescript('/etc/nginx/ssl/', '/var/www/wordpress/');
\$le->initAccount();
\$le->signDomains(['${DOMAIN_NAME}']);
"

# Periodic renewal
while true; do
    sleep 12h
    php -r "
    require 'vendor/autoload.php';
    \$le = new Analogic\Lescript\Lescript('/etc/nginx/ssl/', '/var/www/wordpress/');
    \$le->renewCertificates();
    "
done
