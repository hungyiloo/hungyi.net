#!/usr/bin/env bash
set -euo pipefail

rm -rf public
BASE_URL="https://hungyi.net" emacs --script build.el
cp -r public/* ~/sites/hungyi.net/
