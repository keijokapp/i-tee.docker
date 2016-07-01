#!/bin/sh

set -e

/bin/sh /usr/local/bin/vboxwebsrv.sh &

/bin/sh /usr/local/bin/apache2.sh &

wait
