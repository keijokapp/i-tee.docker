#!/bin/bash


set -e

ssh_master_client() {
	while true
	do
		ssh vbox@host.local -N
		sleep 1 # just in case
	done
}

# run master SSH client instance to speed up SSH commands
# using SSH connection multiplexing
ssh_master_client &

cd /var/www/i-tee

exec /usr/local/bundle/bin/passenger start -p 80 -e production


