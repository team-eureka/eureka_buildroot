#!/bin/sh
set -e

if ! test "$#" -ge 1 -a -f "$1" ; then
	fatal "Invalid argument"
fi

flash_mtd_partition rootfs "$1"
clear_data
