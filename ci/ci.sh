#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

cargo init --bin --name foobar .
cargo test
