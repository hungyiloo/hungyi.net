#!/usr/bin/env bash
set -euo pipefail

rm -rf public
hugo
cp -r public/* /mnt/c/Users/hungy/Sync/hungyi.net/
