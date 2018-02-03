#!/bin/bash

set -euo pipefail

if [ -z "${DEPLOY_TARGETS-}" ]; then
    exit 1
fi

echo "Building artifacts for deployment..."

rm -Rf travis-deployment
mkdir -p travis-deployment

for TARGET in $DEPLOY_TARGETS; do
    echo "Target: $TARGET"
    rustup target add $TARGET
    cargo install --root target/travis-deployment/$TARGET

    for FILE in target/travis-deployment/$TARGET/bin/*; do
        cat $FILE | gzip > travis-deployment/$(basename $FILE)-$TARGET.gz
    done
done
