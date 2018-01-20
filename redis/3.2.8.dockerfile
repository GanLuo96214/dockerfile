FROM centos
LABEL maintainer="ganluo960214@outlook.com"

ENV REDIS_HOME /usr/local/redis/3.2.8
ENV REDIS_BIN ${REDIS_HOME}/bin
ENV PATH ${PATH}:${REDIS_BIN}
RUN \
yum install gcc gcc-c++ make -y;

WORKDIR /usr/local/src/redis
RUN \
curl -LO http://download.redis.io/releases/redis-3.2.8.tar.gz && tar -xf redis-3.2.8.tar.gz;

WORKDIR /usr/local/src/redis/redis-3.2.8
RUN \
make PREFIX=/usr/local/redis/3.2.8/ install;

WORKDIR /etc/redis/
RUN \
cp /usr/local/src/redis/redis-3.2.8/redis.conf /etc/redis/;

# clear src
WORKDIR /usr/local/src/
RUN \
rm -rf ./*

EXPOSE 6379
