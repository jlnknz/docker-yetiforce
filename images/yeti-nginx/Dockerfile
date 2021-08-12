# Note: the container created by this image does not need to write in /var/www/html
# - it will be done by the PHP process
FROM nginx:1.20-alpine

LABEL maintainer="Julien Künzi <julien.kuenzi@22trustventure.com>"

RUN set -eux -o pipefail; \
    TO_INSTALL=shadow; \
    TO_UNINSTALL=${TO_INSTALL}; \
    apk -U upgrade; \
    apk add ${TO_INSTALL}; \
    groupadd -g 31415 abc; \
    useradd -l -s /bin/false -g abc -u 31415 -M -d /non-existent abc; \
    mkdir /var/www; \
    chown abc:abc /var/www; \
    chmod 755 /var/www; \
    apk del ${TO_UNINSTALL}; \
    rm /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh; \
    rm /docker-entrypoint.d/20-envsubst-on-templates.sh;

# We will run the server as the `abc` user, so change config file ownership
COPY --chown=abc:abc nginx.conf /etc/nginx/nginx.conf

USER abc

VOLUME ["/var/www/html"]

# Expose an unprivileged port to avoid issues with docker daemons that do not have
# the proper capabilities to bind to a port < 1024
# FIXME   Not sure this is the correct explanation, but in some cases, nginx cannot bind, in other cases, it can.
# FIXME   To check. Anyway that does not hurt to use 8080 instead of 80.
EXPOSE 8080
