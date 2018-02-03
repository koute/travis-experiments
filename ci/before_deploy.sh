#!/bin/bash

set -euo pipefail

PROJECT_NAME=$(cat Cargo.toml | ruby -e 'STDIN.read =~ /name *= *"(.+?)"/; puts $1')

if [ -z "${DEPLOY_TARGETS-}" ]; then
    exit 1
fi

echo "Building artifacts for deployment..."

rm -Rf travis-deployment
mkdir -p travis-deployment

for TARGET in $DEPLOY_TARGETS; do
    echo "Target: $TARGET"
    rustup target add $TARGET
    cargo build --release --target=$TARGET

    FILE=target/$TARGET/release/$PROJECT_NAME
    cat $FILE | gzip > travis-deployment/$(basename $FILE)-$TARGET.gz
done
