FROM alpine
LABEL maintainer="ganluo960214@outlook.com"
ENV NGINX_HOME /usr/local/nginx/1.13.0
ENV NGINX_BIN ${NGINX_HOME}/sbin
ENV PATH ${PATH}:${NGINX_BIN}
RUN \
apk update && apk add g++ pcre pcre-dev zlib-dev openssl openssl-dev curl make &&\
mkdir -p /usr/local/src && cd /usr/local/src &&\
curl -LO http://nginx.org/download/nginx-1.13.0.tar.gz && tar -xf nginx-1.13.0.tar.gz &&\
cd /usr/local/src/nginx-1.13.0 &&\
./configure --prefix=/usr/local/nginx/1.13.0 --conf-path=/etc/nginx/nginx.conf --with-http_ssl_module --with-http_v2_module --with-pcre-jit && make install &&\
apk del g++ pcre-dev zlib-dev openssl-dev make &&\
rm -rf /usr/local/src

EXPOSE 80
EXPOSE 443
