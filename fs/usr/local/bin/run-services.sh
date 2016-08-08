#!/bin/bash


set -e

EXIT=

run_sshd() {
	apt-get update
	apt-get install -y ssh curl
	while [ -z "$EXIT" ]
	do
		/usr/local/bin/sshd.sh || true
		sleep 2
	done
}


run_vboxautostart() {
	/usr/local/bin/vboxautostart.sh || true
}

run_vboxwebsrv() {
	while [ -z "$EXIT" ]
	do
		/usr/local/bin/vboxwebsrv.sh || true
		sleep 2
	done
}

run_phpvirtualbox() {
	while [ -z "$EXIT" ]
	do
		/usr/local/bin/phpvirtualbox.sh || true
		sleep 2
	done
}


run_sshd &
run_vboxautostart &
run_vboxwebsrv &
run_phpvirtualbox &

cd /var/www/i-tee

exec /usr/local/bin/passenger start -p 80 -e production


