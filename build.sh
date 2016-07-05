#!/bin/bash

ITEE_REPOSITORY="https://github.com/magavdraakon/i-tee.git"
ITEE_BRANCH="docker"
PHPVIRTUALBOX_VERSION="5.0-5"
RUBY_VERSION="2.2.5"

DIR=$(pwd)/$(dirname $0)
TMP=$(mktemp -d)

function cleanup {
	rm "$TMP" -rf
#	rm "$DIR/i-tee" "$DIR/phpvirtualbox" "$DIR/ruby" -rf
	exit 0
}

trap cleanup 0
set -e
trap "exit 1" INT
shopt -s dotglob


# make privitive check that docker is installed
# so we do not try to build ruby just to fail
# later and discard all the hard work
if ! hash docker; then
	echo "error: Docker is not installed" >&2
	exit 1
fi


# Download latest i-tee revision from git $TMP/i-tee

git clone --single-branch --branch="$ITEE_BRANCH" --depth=1 "$ITEE_REPOSITORY" "$TMP/i-tee"
GIT_REVISION=$(git log --pretty=format:'%h %cd' -n 1)
sed "s@GIT_REVISION = \`git log --pretty=format:'%h %cd' -n 1\`@GIT_REVISION = '$GIT_REVISION'@" -i \
  "$TMP/i-tee/config/initializers/version_info.rb"
git -C "$TMP/i-tee" commit -am "Hard code revision into initializer"
git archive --remote="$TMP/i-tee" "$ITEE_BRANCH" > "$TMP/i-tee.tar"
rm "$TMP/i-tee"/* -rf # FIXME: does it remove hidden files?
tar -xf "$TMP/i-tee.tar" -C "$TMP/i-tee"


# Download phpVirtualbox to $TMP/phpvirtualbox

curl -Lo "$TMP/phpvirtualbox.tar.gz" \
	"https://github.com/imoore76/phpvirtualbox/archive/$PHPVIRTUALBOX_VERSION.tar.gz"

tar -xf "$TMP/phpvirtualbox.tar.gz" -C "$TMP"
mv "$TMP/phpvirtualbox-$PHPVIRTUALBOX_VERSION" "$TMP/phpvirtualbox"


# Download and build needed ruby version to $TMP/ruby

cd "$TMP"
curl "https://cache.ruby-lang.org/pub/ruby/$(grep -Po '[0-9]+\.[0-9]+' < $RUBY_VERSION)/ruby-$RUBY_VERSION.tar.gz" -oruby-source.tar.gz
tar -xf ruby-source.tar.gz
cd "ruby-$RUBY_VERSION"
# https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
./configure
make
make install DESTDIR="$TMP/ruby"


# Copy stuff to docker context

rm "$DIR/i-tee" "$DIR/phpvirtualbox" "$DIR/ruby" -rf
mv "$TMP/i-tee" "$DIR/i-tee"
mv "$TMP/phpvirtualbox" "$DIR/phpvirtualbox"
mv "$TMP/ruby" "$DIR/ruby"


# Build image

docker build -t i-tee "$DIR"
