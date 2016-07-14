#!/bin/sh

cd /var/www/i-tee

set -e

if [ -z "$ITEE_BRANCH" ]
then
	echo "i-tee branch not specified. Skipping checkout" >2
else

	git fetch -a

	git checkout "$ITEE_BRANCH"

	git reset --hard "origin/$ITEE_BRANCH"

	cp /var/www/i-tee/config/environments/production_sample.rb \
	   /var/www/i-tee/config/environments/production.rb

fi

echo "i-tee branch: $(git rev-parse --abbrev-ref HEAD)"
echo "i-tee revision: $(git log --pretty=format:'%h %cd' -n 1)"
