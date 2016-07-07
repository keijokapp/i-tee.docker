FROM ubuntu:xenial
MAINTAINER keijo.kapp@rangeforce.com

COPY fs/ /
COPY ruby/ /

RUN /var/www/i-tee/utils/install.sh

EXPOSE 80
EXPOSE 443
EXPOSE 4433

ENTRYPOINT /usr/local/bin/init


