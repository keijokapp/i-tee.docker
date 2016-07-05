
cd /var/www/i-tee

set -e

git checkout ${ITEE_BRANCH:="docker"}

if [ -z "$ITEE_BRANCH_NORESET" ]
then

	git fetch origin "$ITEE_BRANCH"

	git reset --hard "origin/$ITEE_BRANCH"

fi

echo "Using i-tee branch $ITEE_BRANCH"
