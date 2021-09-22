#!/usr/bin/env bash
set -euo pipefail

fd | entr emacs --script build.el &
serve public
