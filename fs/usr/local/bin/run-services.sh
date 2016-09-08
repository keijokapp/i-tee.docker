#!/bin/bash


set -e

cd /var/www/i-tee

exec /usr/local/bundle/bin/passenger start -p 80 -e production


