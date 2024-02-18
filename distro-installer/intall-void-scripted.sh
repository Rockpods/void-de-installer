#!/bin/bash

echo "DO NOT USE THIS UNLESS YOU KNOW WHAT YOU ARE DOING"
sleep 15s

mkfs.btrfs -f /dev/sda3
mkfs.vfat /dev/sda1
mount /dev/sda3 /mnt/
mkdir -p /mnt/boot/efi/
mount /dev/sda3 /mnt/boot/efi/
mkswap /dev/sda2
REPO=https://repo-default.voidlinux.org/current
ARCH=x86_64
mkdir -p /mnt/var/db/xbps/keys
cp /var/db/xbps/keys/* /mnt/var/db/xbps/keys/
wpa_cli -i wlo1
XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system
xchroot /mnt /bin/bash
# cd ../
# ./install.sh