FROM alpine
LABEL maintainer="ganluo960214@outlook.com"

ENV PGDATA /var/lib/postgresql/data
ENV POSTGRESQL_HOME /usr/local/postgresql/10.0
ENV POSTGRESQL_BIN ${POSTGRESQL_HOME}/bin
ENV PATH ${PATH}:${POSTGRESQL_BIN}

RUN \
apk update && apk add g++ make readline readline-dev zlib-dev openssl openssl-dev curl bison flex perl &&\
mkdir -p /usr/local/src && cd /usr/local/src &&\
curl -LO https://ftp.postgresql.org/pub/source/v10.0/postgresql-10.0.tar.gz &&\
tar -xf postgresql-10.0.tar.gz &&\
cd /usr/local/src/postgresql-10.0 &&\
./configure --prefix=/usr/local/postgresql/10.0 --with-openssl &&\
make world && make install-world &&\
rm -rf /usr/local/src &&\
apk del g++ make readline-dev zlib-dev openssl-dev curl bison flex &&\
mkdir -p /var/lib/postgresql && chown postgres:postgres /var/lib/postgresql

USER postgres
WORKDIR  /var/lib/postgresql

EXPOSE 5432
