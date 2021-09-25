#!/usr/bin/env bash
set -euo pipefail

rm -rf public
emacs --script build.el
cp -r public/* ~/sites/hungyi.net/
