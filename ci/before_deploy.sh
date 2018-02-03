#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

for TARGET in $DEPLOY_TARGETS do
    rustup target add $TARGET
    cargo build --release --target=$TARGET
    cat target/$TARGET/release/$PROJECT_NAME | gzip > $PROJECT_NAME-$TARGET.gz
done
