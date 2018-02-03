#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

if [ -z "${DEPLOY_TARGETS-}" ]; then
    exit 1
fi

echo "Building artifacts for deployment..."

for TARGET in $DEPLOY_TARGETS do
    rustup target add $TARGET
    cargo build --release --target=$TARGET
    cat target/$TARGET/release/$PROJECT_NAME | gzip > $PROJECT_NAME-$TARGET.gz
done
