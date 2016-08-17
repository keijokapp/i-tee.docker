#!/bin/sh

HOST="$SSH_ORIGINAL_COMMAND"

if [ -z "$HOST" ]
then
	echo "Host not specified"
	exit 1
fi

echo "Forwarding SSH session to given host ($HOST)"
echo "NOTE: You need -t and probably -A option for this to work. See 'man ssh'"
echo "-----"

exec ssh -tA root@172.18.128.2 -- ssh -tA root@"$HOST" -- 
