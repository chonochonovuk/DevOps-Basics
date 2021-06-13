FROM mariadb:10.5.8

# env
ENV MYSQL_DATABASE=bulgaria \
    MYSQL_USER=web_user \
    MYSQL_PASSWORD=Password1 \
    MYSQL_ROOT_PASSWORD=nE5kMc7JCGNqwDQN

ADD db_setup.sql /docker-entrypoint-initdb.d/db_setup.sql
