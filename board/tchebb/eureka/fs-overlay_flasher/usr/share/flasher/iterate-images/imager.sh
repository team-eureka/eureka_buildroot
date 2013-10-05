#!/bin/sh

if ! test "$#" -ge 1 -a -d "$1" ; then
	fatal "Invalid argument"
fi

for IMAGE_PATH in "$1"/* ; do
	if ! flash-image "$IMAGE_PATH" ; then
		if test -n "$IGNORE_ERRORS" ; then
			log "${IMAGE_PATH} failed to flash, ignoring error"
		else
			exit 1
		fi
	fi
done

exit 0
