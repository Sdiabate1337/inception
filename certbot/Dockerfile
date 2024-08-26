# Base image
FROM debian:bullseye

# Install dependencies
RUN apt-get update && apt-get install -y \
    php-cli \
    php-curl \
    curl \
    git \
    unzip

# Install lescript
RUN curl -s https://getcomposer.org/installer | php && \
    php composer.phar require analogic/lescript

# Copy the script to manage certificates
COPY ./manage-certs.sh /manage-certs.sh
RUN chmod +x /manage-certs.sh

# Define the entrypoint command
CMD ["/manage-certs.sh"]
