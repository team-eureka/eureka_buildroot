#!/bin/sh
set -e

if test "$#" -lt 1 ; then
	echo "Usage: $0 BUILD_DIR"
	exit 1
fi

cd "$1"

sed -ri -e 's|^(root:.*:)/bin/sh$|\1/bin/bash|' etc/passwd
