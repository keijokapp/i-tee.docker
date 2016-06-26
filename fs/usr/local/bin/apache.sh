#!/bin/sh

. /etc/apache2/envvars

exec /usr/bin/apache2 -DFOREGROUND
