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
echo "Creating a squashfs image with the init_partitions flag file"
touch init_partitions
mksquashfs init_partitions init_partitions.sqfs -all-root -no-progress
rm init_partitions

MBR_SIZE="$((0x1000))"
BOOTIMG_SIZE="$((1024*1024 * 20))"
SQFS_SIZE="$(stat -c '%s' init_partitions.sqfs)"
SQFS_START="$((MBR_SIZE + BOOTIMG_SIZE))"

# Put it all together.
rm -f eureka_release.bin

echo "Allocating space for release image"
fallocate -l "$((SQFS_START / 1024))KiB" eureka_release.bin

echo "Appending squashfs image to release image"
cat init_partitions.sqfs >> eureka_release.bin

echo "Copying boot image to release image"
dd bs="$((0x1000))" conv=notrunc if='eureka_boot.img' of='eureka_release.bin' seek=1

echo "Writing partition table to release image"

sectors() {
	echo "$((($1 + 511) / 512))"
}

sfdisk -Lqf eureka_release.bin 2>/dev/null <<EOF
# partition table of eureka_release.bin
unit: sectors

eureka_release.bin1 : start=$(sectors "$SQFS_START"), size=   $(sectors "$SQFS_SIZE"), Id=83
eureka_release.bin2 : start=  $(sectors "$MBR_SIZE"), size=$(sectors "$BOOTIMG_SIZE"), Id=da
eureka_release.bin3 : start=                       0, size=                         0, Id= 0
eureka_release.bin4 : start=                       0, size=                         0, Id= 0
EOF
