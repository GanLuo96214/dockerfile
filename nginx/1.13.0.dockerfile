FROM centos
LABEL maintainer="ganluo960214@outlook.com"
ENV NGINX_HOME /usr/local/nginx/1.13.0
ENV NGINX_BIN ${NGINX_HOME}/sbin
ENV PATH ${PATH}:${NGINX_BIN}
RUN \
yum install gcc gcc-c++ make openssl openssl-devel pcre-devel zlib-devel -y && yum clean all;

# nginx compile start
WORKDIR /tmp
RUN \
curl -LO http://nginx.org/download/nginx-1.13.0.tar.gz;\
tar -xf nginx-1.13.0.tar.gz;
WORKDIR /tmp/nginx-1.13.0
RUN \
./configure --prefix=/usr/local/nginx/1.13.0 --conf-path=/etc/nginx/nginx.conf --with-http_ssl_module --with-http_v2_module && make install

EXPOSE 80
EXPOSE 443
