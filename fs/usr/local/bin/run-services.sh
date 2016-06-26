#!/bin/sh

set -e

cd /var/www/i-tee
rake db:migrate RAILS_ENV="production"

/bin/sh /usr/local/bin/vboxwebsrv.sh &

/bin/sh /usr/local/bin/apache2.sh & 

wait
