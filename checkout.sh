
cd /var/www/i-tee

set -e

git checkout ${ITEE_BRANCH:="docker"}

if [ -z "$ITEE_BRANCH_NORESET" ]
then

	git fetch origin "$ITEE_BRANCH"

	git reset --hard "origin/$ITEE_BRANCH"

	cp /var/www/i-tee/config/environments/production_sample.rb \
	  /var/www/i-tee/config/environments/production.rb

fi

echo "Using i-tee branch $ITEE_BRANCH"
