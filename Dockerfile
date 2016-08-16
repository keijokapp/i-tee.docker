FROM ruby:2.2.5
MAINTAINER keijo.kapp@rangeforce.com

COPY fs/ /

RUN /var/www/i-tee/utils/install.sh

RUN apt-get clean autoclean && apt-get autoremove -y

EXPOSE 80
EXPOSE 443
EXPOSE 4433

ENTRYPOINT [ "/usr/local/bin/init" ]

