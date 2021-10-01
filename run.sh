#!/usr/bin/env bash
set -euo pipefail

fd | BASE_URL="http://localhost:5000" entr emacs --script build.el &
python -m http.server --directory public 5000
