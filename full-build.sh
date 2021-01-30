#!/usr/bin/env bash

set -v -x

cd "$(dirname "$0")"

pacman -S --noconfirm --needed mingw-w64-{i686,x86_64}-gcc
pacman -S --noconfirm --needed msys/{curl,perl,git,flex,bison,make}

# ANDRE --nocheck
#
# Users who do not need it . . . call makepkg with --nocheck flag
# https://wiki.archlinux.org/index.php/Creating_packages#check()
#
# Build package (only once)
set -o pipefail
MINGW_INSTALLS="mingw64" makepkg-mingw --nocheck 2>&1 | tee full-build.sh.log

set +v +x