FROM centos
LABEL maintainer="ganluo960214@outlook.com"
ENV MYSQL_HOME /usr/local/mysql/5.7.16
ENV MYSQL_BIN ${MYSQL_HOME}/bin
ENV PATH ${PATH}:${MYSQL_BIN}
RUN \
groupadd mysql && useradd mysql -g mysql;\
yum install gcc gcc-c++ cmake make bison ncurses-devel -y;

WORKDIR /usr/local/src/mysql
RUN \
curl -LO https://cdn.mysql.com//archives/mysql-5.7/mysql-boost-5.7.16.tar.gz && tar -xzf mysql-boost-5.7.16.tar.gz

WORKDIR /usr/local/src/mysql/mysql-5.7.16
RUN \
cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql/5.7.16 -DMYSQL_DATADIR=/data -DWITH_BOOST=boost/boost_1_59_0 -DSYSCONFDIR=/etc/mysql/ -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DENABLED_LOCAL_INFILE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8mb4 -DDEFAULT_COLLATION=utf8mb4_unicode_ci -DMYSQL_UNIX_ADDR=/tmp/mysql.5.7.16.sock -DWITH_UNIT_TESTS=OFF && make install;

# clear src
WORKDIR /usr/local/src/
RUN \
rm -rf ./*

EXPOSE 3306
