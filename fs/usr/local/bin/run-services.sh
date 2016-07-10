#!/bin/sh

# Some shitty process manager
# Vboxwebsrv & phpvirtualbox will probably be
# removed or moved outside this container at
# some point, so we will not need any process
# manager in the future

set -e

terminate() {
	set -e

	echo "Caught SIGTERM. Terminating"

	kill -TERM $VBOXWEBSRV_PID $APACHE2_PID
	wait

}

trap "terminate" TERM

/bin/sh /usr/local/bin/vboxwebsrv.sh &

VBOXWEBSRV_PID=$!

/bin/sh /usr/local/bin/apache2.sh &

APACHE2_PID=$!

set +e

wait
