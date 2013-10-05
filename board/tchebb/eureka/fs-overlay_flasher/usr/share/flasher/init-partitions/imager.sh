#!/bin/sh
set -e

# I know this is horribly ugly. Believe me, it's the only way.
fdisk -u '/dev/sda' <<EOF
c
d
1
n
p
1
8


t
1
c
w
EOF

mkfs.fat -n 'FLASHCAST' '/dev/sda1'
