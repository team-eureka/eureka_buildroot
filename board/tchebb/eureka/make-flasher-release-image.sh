#!/bin/sh
set -e

if test "$#" -lt 1 ; then
	echo "Usage: $0 IMAGES_DIR"
	exit 1
fi

cd "$1"

# Remove existing squashfs image.
rm -f init_partitions.sqfs

# Create a new squashfs image with an init_partitions flag file.
touch init_partitions
mksquashfs init_partitions init_partitions.sqfs -all-root
rm init_partitions

sectors() {
	echo "$((($1 + 511) / 512))"
}

MBR_SIZE="$((0x1000))"
BOOTIMG_SIZE="$((1024*1024 * 20))"
SQFS_SIZE="$(stat -c '%s' init_partitions.sqfs)"
SQFS_START="$((MBR_SIZE + BOOTIMG_SIZE))"

# Put it all together.
rm -f eureka_release.bin

fallocate -l "$((SQFS_START / 1024))KiB" eureka_release.bin
cat init_partitions.sqfs >> eureka_release.bin
dd if='eureka_boot.img' of='eureka_release.bin' conv=notrunc

sfdisk -Lf eureka_release.bin <<EOF
# partition table of eureka_release.bin
unit: sectors

eureka_release.bin1 : start=$(sectors "$SQFS_START"), size=   $(sectors "$SQFS_SIZE"), Id=83
eureka_release.bin2 : start=  $(sectors "$MBR_SIZE"), size=$(sectors "$BOOTIMG_SIZE"), Id=da
eureka_release.bin3 : start=                       0, size=                         0, Id= 0
eureka_release.bin4 : start=                       0, size=                         0, Id= 0
EOF

zip eureka_release.zip eureka_release.bin
