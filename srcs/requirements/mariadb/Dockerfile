FROM debian:bullseye

RUN apt-get update && apt-get install -y  mariadb-client mariadb-server


EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

WORKDIR /bin/SQL/
COPY ./tools/script.sh /
RUN  chmod +x /script.sh

ENTRYPOINT [ "/script.sh" ]