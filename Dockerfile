FROM ruby:2.2.5
MAINTAINER keijo.kapp@rangeforce.com

RUN apt-get update && \
	apt-get install -y --no-install-recommends sudo openssh-client libyaml-0-2 libgmp-dev libmysqlclient-dev libsqlite3-dev && \
	gem install bundler

WORKDIR /var/www/i-tee
COPY i-tee/Gemfile /var/www/i-tee/Gemfile
COPY i-tee/Gemfile.lock /var/www/i-tee/Gemfile.lock
RUN bundle install

COPY fs/ /
COPY i-tee/version.txt /var/www/i-tee/version.txt
COPY i-tee/Rakefile /var/www/i-tee/Rakefile
COPY i-tee/config.ru /var/www/i-tee/config.ru
COPY i-tee/public/ /var/www/i-tee/public/
COPY i-tee/app/ /var/www/i-tee/app/
COPY i-tee/config/ /var/www/i-tee/config/
COPY i-tee/db/ /var/www/i-tee/db/
COPY i-tee/lib/ /var/www/i-tee/lib/
COPY i-tee/script/ /var/www/i-tee/script/
COPY i-tee/test/ /var/www/i-tee/test/
COPY i-tee/utils/ /var/www/i-tee/utils/
COPY application.rb /var/www/i-tee/config/application.rb
COPY devise.rb /var/www/i-tee/config/initializers/devise.rb
COPY i-tee-config.rb /var/www/i-tee/config/environments/production.rb

RUN groupadd -og 0 vboxusers && useradd -Md /root -g vboxusers -ou 0 vbox

EXPOSE 80

ENTRYPOINT [ "/usr/local/bundle/bin/passenger", "start", "-p", "80", "-e", "production", "--log-file", "/dev/stderr" ]

