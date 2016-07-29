#!/bin/sh

chown vbox:vbox /tmp/.vbox-vbox-ipc 2>/dev/null

exec su - vbox -c '/usr/bin/vboxwebsrv'


