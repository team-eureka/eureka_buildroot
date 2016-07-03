#!/bin/sh
set -e

if test "$#" -lt 1 ; then
	echo "Usage: $0 IMAGES_DIR"
	exit 1
fi

IMAGES_DIR="$1"

write_bootimg() {
	if test -f "${IMAGES_DIR}/rootfs.cpio.gz" ; then
		cc-make-bootimg "$1" "$2" "$3" "${IMAGES_DIR}/rootfs.cpio.gz"
	else
		cc-make-bootimg "$1" "$2" "$3"
	fi
}

ZIMAGE_PATH="$(ls -q1t "${IMAGES_DIR}/zImage"* | head -n 1)"
echo "Selected zImage $ZIMAGE_PATH"

write_bootimg usb "${IMAGES_DIR}/eureka_boot.img" "$ZIMAGE_PATH"
write_bootimg nand "${IMAGES_DIR}/eureka_recovery.img" "$ZIMAGE_PATH"
