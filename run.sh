#!/usr/bin/env bash
set -euo pipefail

fd | entr emacs --script build.el &
python -m http.server --directory public 5000
