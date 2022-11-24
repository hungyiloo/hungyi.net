#!/usr/bin/env bash
set -euo pipefail

rm -rf output
PRODUCTION="t" doomscript ./build.el
