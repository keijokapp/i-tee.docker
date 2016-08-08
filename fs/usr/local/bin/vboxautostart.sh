#!/bin/sh

set -e

exec su - vbox -c '/usr/bin/vboxautostart -c /etc/vbox/autostart.conf --start'


