# mysql image based on buster-slim
FROM mysql:8

LABEL maintainer="Julien Künzi <julien.kuenzi@22trustventure.com>"

ENV MYSQL_DATABASE yetiforce
ENV MYSQL_USER yeti

# Change config file and init script ownership as the server will run under the `mysql` user
# and not `root`
COPY --chown=mysql:mysql mysql.cnf /etc/mysql/conf.d/50-server.cnf
COPY --chown=mysql:mysql init-custom.sql /docker-entrypoint-initdb.d/10-init-custom.sql

USER mysql

VOLUME ["/var/lib/mysql"]
EXPOSE 3306
