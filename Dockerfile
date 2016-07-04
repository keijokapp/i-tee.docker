FROM ubuntu:xenial
MAINTAINER keijo.kapp@rangeforce.com

COPY fs/ /
COPY ruby/ /
COPY i-tee /var/www/i-tee
COPY phpvirtualbox /var/www/phpvirtualbox

RUN chmod u=rwx,g=rwx,o=rwxt /tmp

RUN /bin/sh /var/www/i-tee/utils/install.sh

RUN rm -rf /tmp/*

EXPOSE 80
EXPOSE 443
EXPOSE 4433

CMD /usr/local/bin/init


