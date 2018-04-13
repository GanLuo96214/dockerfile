FROM alpine
LABEL maintainer="ganluo960214@outlook.com"

ENV PHP_HOME /usr/local/php/7.1.5
ENV PHP_BIN ${PHP_HOME}/bin
ENV PHP_SBIN ${PHP_HOME}/sbin
ENV PATH ${PATH}:${PHP_BIN}:${PHP_SBIN}

RUN \
apk update && apk add g++ automake autoconf make libxml2 libxml2-dev libjpeg-turbo libjpeg-turbo-dev freetype freetype-dev libpng libpng-dev libressl libressl-dev curl-dev libmcrypt libmcrypt-dev mariadb-common postgresql-libs postgresql-dev gettext gettext-dev curl &&\
mkdir -p /usr/local/src/php && cd /usr/local/src/php &&\
curl -LO http://cn.php.net/distributions/php-7.1.5.tar.gz && tar -xf php-7.1.5.tar.gz &&\
cd /usr/local/src/php/php-7.1.5 && ./configure --prefix=${PHP_HOME} --with-config-file-path=/etc/php/ --with-pdo-mysql --with-pdo-pgsql  --with-zlib --with-mhash  --with-gettext --with-pear --with-iconv --with-openssl --with-gd --with-freetype-dir --with-png-dir --with-jpeg-dir --with-mcrypt --with-curl --with-pcre-regex --with-xmlrpc --with-imap-ssl --enable-mbstring --enable-zip --enable-fpm --enable-pcntl --enable-sockets --enable-ftp --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-shmop --enable-opcache --enable-soap --enable-maintainer-zts --enable-xml --disable-rpath --disable-debug --disable-fileinfo --disable-phpdbg && make -j && make install &&\
mkdir -p /etc/php/ && cd /etc/php/ &&\
cp /usr/local/src/php/php-7.1.5/php.ini-development php.ini &&\
apk del g++ automake make libxml2-dev libjpeg-turbo-dev freetype-dev libpng-dev libressl-dev curl-dev libmcrypt-dev postgresql-dev gettext-dev &&\
rm -rf /usr/local/src


EXPOSE 9000
