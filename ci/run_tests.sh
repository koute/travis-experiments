#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

cargo test
