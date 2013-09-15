#!/bin/sh
set -e

if test "$#" -lt 1 ; then
	echo "Usage: $0 IMAGES_DIR"
	exit 1
fi

IMAGES_DIR="$1"

if test -f "${IMAGES_DIR}/rootfs.cpio.gz" ; then
	cc-make-bootimg "${IMAGES_DIR}/eureka_boot.img" "${IMAGES_DIR}/zImage" "${IMAGES_DIR}/rootfs.cpio.gz"
else
	cc-make-bootimg "${IMAGES_DIR}/eureka_boot.img" "${IMAGES_DIR}/zImage"
fi
