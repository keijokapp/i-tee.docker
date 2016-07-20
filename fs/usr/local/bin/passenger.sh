#!/bin/sh

set -e

cd /var/www/i-tee

exec /usr/local/bin/passenger start -p 80 -e production
