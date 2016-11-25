FROM debian:jessie

MAINTAINER Andrew Tan<andrew@switch168.com>

RUN sed -i 's/httpredir/ftp.us/g' /etc/apt/sources.list

RUN rm -rf /var/lib/apt/lists/* && apt-get update
RUN apt-get install --assume-yes  clang-3.5 pbuilder git bison flex libjansson-dev

RUN git clone https://github.com/kamailio/kamailio.git && cd kamailio && git checkout 51e1581 && \
    make include_modules="jansson evapi db_mysql json evapi auth_ephemeral websocket tls" cfg && \
    make all && \
    make install 

CMD /bin/sh -c "while true; do echo hello world; sleep 1; done"
