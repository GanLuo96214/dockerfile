FROM centos
LABEL maintainer="ganluo960214@outlook.com"

ENV RABBITMQ_HOME /usr/local/rabbitmq/3.7.2
ENV RABBITMQ_SBIN ${RABBITMQ_HOME}/sbin
ENV ERLANG_HOME /usr/local/erlang/20.1
ENV ERLANG_BIN ${ERLANG_HOME}/bin
ENV PATH ${PATH}:${ERLANG_BIN}:${RABBITMQ_SBIN}

RUN \
yum install gcc gcc-c++ make perl openssl-devel libxslt xmlto zip unzip git elixir python2-simplejson ncurses-devel -y && yum clean all;

WORKDIR /usr/local/src/
RUN \
curl -L -O  http://erlang.org/download/otp_src_20.2.tar.gz -O https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.2/rabbitmq-server-generic-unix-3.7.2.tar.xz && \
tar -xf otp_src_20.2.tar.gz && tar -xf rabbitmq-server-generic-unix-3.7.2.tar.xz -C /usr/local/;

WORKDIR /usr/local/src/otp_src_20.2
RUN ./configure --prefix=/usr/local/erlang/20.2 && make -j8 && make install && make clean ;

WORKDIR /usr/local/rabbitmq
WORKDIR /usr/local
RUN \
mv rabbitmq_server-3.7.2 rabbitmq/3.7.2

WORKDIR /etc/rabbitmq
RUN \
mv /usr/local/rabbitmq/3.7.2/etc/rabbitmq /etc/rabbitmq && ln -s /etc/rabbitmq /usr/local/rabbitmq/3.7.2/etc/rabbitmq

#clear
WORKDIR /usr/local/src
RUN \
rm -rf *;

EXPOSE 4369
EXPOSE 5672
EXPOSE 5671
EXPOSE 25672
EXPOSE 61613
EXPOSE 61614
EXPOSE 1883
EXPOSE 8883
EXPOSE 15674
EXPOSE 15675
