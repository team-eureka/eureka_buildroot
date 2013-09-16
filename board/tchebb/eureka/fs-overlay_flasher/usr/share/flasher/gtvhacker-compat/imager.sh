#!/bin/sh

if ! test -f './system.img' ; then
	fatal "Missing system.img"
fi

flash_mtd_partition rootfs './system.img'
clear_data
