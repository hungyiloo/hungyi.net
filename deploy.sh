#!/usr/bin/env bash
set -euo pipefail

rm -rf public
hugo
cp -r public/* ~/sites/hungyi.net/
