#!/usr/bin/env bash
set -euo pipefail

fd | entr ./build.el &
python -m http.server --directory output 5000
