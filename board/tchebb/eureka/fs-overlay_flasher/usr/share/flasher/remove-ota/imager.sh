#!/bin/sh
set -e

CACHE="$(mount_mtd_partition cache)"
log "Removing temp-ota.zip and ota.zip from cache partition (${CACHE})"
rm -f "${CACHE}/temp-ota.zip" "${CACHE}/ota.zip"
cleanup_mount "$CACHE"
