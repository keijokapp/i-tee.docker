ITEE_REPOSITORY="https://github.com/keijokapp/i-tee.git"
ITEE_BRANCH="install-script"
PHPVIRTUALBOX_VERSION="5.0-5"



DIR=$(pwd)/$(dirname $0)
TMP=$(mktemp -d)

function cleanup {
	rm "$TMP" -rf
	rm "$DIR/i-tee" "$DIR/phpvirtualbox" -rf
}

trap cleanup 0
set -e
trap "exit 1" INT

git clone --single-branch --branch="$ITEE_BRANCH" --depth=1 "$ITEE_REPOSITORY" "$TMP/i-tee"
git archive --remote="$TMP/i-tee" "$ITEE_BRANCH" > "$TMP/i-tee.tar.gz"

curl -Lo "$TMP/phpvirtualbox.tar.gz" \
	"https://github.com/imoore76/phpvirtualbox/archive/$PHPVIRTUALBOX_VERSION.tar.gz"

tar -xf "$TMP/phpvirtualbox.tar.gz" -C "$TMP"
mv "$TMP/phpvirtualbox-$PHPVIRTUALBOX_VERSION" "$DIR/phpvirtualbox"
mkdir -p "$DIR/i-tee"
tar -xf "$TMP/i-tee.tar.gz" -C "$DIR/i-tee"

cd "$DIR"
docker build .
