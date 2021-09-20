#!/usr/bin/env bash
set -euo pipefail

emacs --script build.el && serve public
