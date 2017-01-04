FROM ruby:2.2.5
MAINTAINER keijo.kapp@rangeforce.com

RUN apt-get update && \
	apt-get install -y --no-install-recommends sudo openssh-client libyaml-0-2 libgmp-dev libmysqlclient-dev libsqlite3-dev && \
	gem install bundler
COPY fs/ /
COPY application.rb /var/www/i-tee/config/application.rb
COPY devise.rb /var/www/i-tee/config/initializers/devise.rb
COPY i-tee-config.rb /var/www/i-tee/config/environments/production.rb
RUN cd /var/www/i-tee && bundle install

RUN groupadd -og 0 vboxusers && useradd -Md /root -g vboxusers -ou 0 vbox

WORKDIR /var/www/i-tee

EXPOSE 80

ENTRYPOINT [ "/usr/local/bin/init" ]

