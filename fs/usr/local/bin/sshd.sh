#!/bin/bash

rm /etc/ssh/ssh_host_*_key{,.pub}
cp /etc/i-tee/ssh_host_*_key{,.pub} /etc/ssh

mkdir -p /var/run/sshd

exec /usr/sbin/sshd -D
