#!/usr/bin/env bash

set -v -x

cd "$(dirname "$0")"

# ANDRE --nocheck
#
# Users who do not need it . . . call makepkg with --nocheck flag
# https://wiki.archlinux.org/index.php/Creating_packages#check()
#
# Build package (only once)
set -o pipefail
MINGW_INSTALLS="mingw64" makepkg-mingw --nocheck 2>&1 | tee full-build.sh.log

set +v +x