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
cd /usr/local/src/php/php-7.1.5 && ./configure --prefix=/usr/local/php/7.1.5 --with-config-file-path=/etc/php/ --with-pdo-mysql --with-pdo-pgsql  --with-zlib --with-mhash  --with-gettext --with-pear --with-iconv --with-openssl --with-gd --with-freetype-dir --with-png-dir --with-jpeg-dir --with-mcrypt --with-curl --with-pcre-regex --with-xmlrpc --with-imap-ssl --enable-mbstring --enable-zip --enable-fpm --enable-pcntl --enable-sockets --enable-ftp --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-shmop --enable-opcache --enable-soap --enable-maintainer-zts --enable-xml --disable-rpath --disable-debug --disable-fileinfo --disable-phpdbg && make -j && make install &&\
mkdir -p /usr/local/src/php/extension && cd /usr/local/src/php/extension &&\
curl -L -O http://pecl.php.net/get/msgpack-2.0.2.tgz -O http://pecl.php.net/get/redis-3.1.6.tgz  && for tar in ${PWD}/*;do if [ -f ${tar} ];then tar -xf ${tar}; fi; done && for extension in ${PWD}/*;do if [ -d ${extension} ];then cd ${extension} && phpize && ./configure && make install; fi; done && \
cd /usr/local/src/php/extension && curl -L -O https://github.com/phalcon/cphalcon/archive/v3.1.2.tar.gz && tar -xf v3.1.2.tar.gz && cd cphalcon-3.1.2/build/php7/64bits && phpize; ./configure; make install &&\
mkdir -p /etc/php/ && cd /etc/php/ &&\
cp /usr/local/src/php/php-7.1.5/php.ini-development php.ini &&\
apk del g++ automake make libxml2-dev libjpeg-turbo-dev freetype-dev libpng-dev libressl-dev curl-dev libmcrypt-dev postgresql-dev gettext-dev &&\
rm -rf /usr/local/src

#cp /usr/local/php/7.1.5/etc/php-fpm.conf.default php-fpm.conf && mv /usr/local/php/7.1.5/etc/php-fpm.d .;
#WORKDIR /etc/php/php-fpm.d
#cp www.conf.default www.conf && sed -i  '/127.0.0.1:9000/s/127.0.0.1/0.0.0.0/' www.conf;
# php-fpm end

EXPOSE 9000
