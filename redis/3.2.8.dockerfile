FROM alpine
LABEL maintainer="ganluo960214@outlook.com"

ENV REDIS_HOME /usr/local/redis/3.2.8
ENV REDIS_BIN ${REDIS_HOME}/bin
ENV PATH ${PATH}:${REDIS_BIN}
RUN \
apk update && apk add  gcc make curl libc-dev linux-headers ;\
mkdir -p /usr/local/src/redis && cd /usr/local/src/redis ;\
curl -LO http://download.redis.io/releases/redis-3.2.8.tar.gz && tar -xf redis-3.2.8.tar.gz;\
cd /usr/local/src/redis/redis-3.2.8 ;\
make -j PREFIX=${REDIS_HOME} install;\
mkdir /etc/redis/ && cp /usr/local/src/redis/redis-3.2.8/redis.conf /etc/redis/;\
rm -rf /usr/local/src/;\
apk del gcc make curl libc-dev linux-headers;\
cd /;

EXPOSE 6379
