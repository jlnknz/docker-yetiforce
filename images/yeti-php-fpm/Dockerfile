FROM php:8-fpm-alpine
# FIXME Imagick not supported by php 8 on fpm, yet?
# FIXME  https://github.com/Imagick/imagick/issues/358
# FIXME  When ok, add:
# FIXME     pecl install imagick-3.4.4;
# FIXME     docker-php-ext-enable imagick;

LABEL maintainer="Julien Künzi <julien.kuenzi@22trustventure.com>"

RUN set -eux -o pipefail; \
    TO_INSTALL="\
        autoconf \
        freetype-dev \
        gcc \
        icu-dev \
        imagemagick-dev \
        imap-dev \
        jpeg-dev \
        krb5-dev \
        libpng-dev \
        libwebp-dev \
        libxml2-dev \
        libxpm-dev \
        libzip-dev \
        make \
        musl-dev \
        openldap-dev \
        openssl-dev \
        shadow \
        zlib-dev \
        "; \
    TO_UNINSTALL="\
        autoconf \
        gcc make \
        musl-dev \
        shadow \
        "; \
    apk -U upgrade; \
    apk add ${TO_INSTALL}; \
    groupadd -g 31415 abc; \
    useradd -l -s /bin/false -g abc -u 31415 -M -d /non-existent abc; \
    mkdir /run/php; \
    chown abc:abc /var/www /run/php; \
    chmod 755 /var/www /run/php; \
    docker-php-ext-configure gd --with-jpeg --with-xpm --with-webp --with-freetype; \
    docker-php-ext-configure imap --with-imap-ssl --with-kerberos; \
    docker-php-ext-configure intl; \
    docker-php-ext-configure exif; \
    docker-php-ext-configure zip; \
    docker-php-ext-configure soap; \
    docker-php-ext-configure bcmath; \
    docker-php-ext-configure opcache; \
    docker-php-ext-configure ldap; \
    docker-php-ext-configure pdo_mysql; \
    docker-php-ext-install -j $(nproc) gd imap intl exif zip soap bcmath opcache ldap pdo_mysql; \
    pecl install apcu-5.1.19; \
    docker-php-ext-enable apcu; \
    apk del ${TO_UNINSTALL};

# copy the restrictive configuration files after we have built and installed all extensions
# otherwise we won't be able to use some dangerous PHP functions such as popen() when building
COPY --chown=abc:abc php.ini /usr/local/etc/php/php.ini
COPY --chown=abc:abc www.conf /usr/local/etc/php-fpm.d/www.conf

# cron script
COPY --chown=abc:abc yeti-cron.sh /yeti-cron.sh

USER abc

VOLUME ["/var/www/html"]

EXPOSE 9000
