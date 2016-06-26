FROM ubuntu:xenial
MAINTAINER keijo.kapp@rangeforce.com

COPY fs/ /
copy phpvirtualbox /var/www/phpvirtualbox
copy i-tee /var/www/i-tee

COPY oracle_vbox_2016.asc /tmp

RUN /bin/sh /var/www/i-tee/utils/install.sh

RUN rm -rf /tmp/*

EXPOSE 80
EXPOSE 443
EXPOSE 4433

CMD /usr/local/bin/init


