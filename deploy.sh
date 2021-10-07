#!/usr/bin/env bash
set -euo pipefail

rm -rf output
PRODUCTION="t" emacs --script build.el
cp -r output/* ~/sites/hungyi.net/
