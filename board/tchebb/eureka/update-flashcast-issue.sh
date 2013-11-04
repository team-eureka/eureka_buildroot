#!/bin/sh
set -e

if test "$#" -lt 1 ; then
	echo "Usage: $0 BUILD_DIR"
	exit 1
fi

cd "$1"

echo "Welcome to FlashCast version $(cat etc/flasher-version)!" >etc/issue
