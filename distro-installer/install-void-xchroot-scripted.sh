#!/bin/bash

echo "DO NOT USE THIS UNLESS YOU KNOW WHAT YOU ARE DOING"
sleep 15s

echo "voidlinuxtesting" >> /etc/hostname
echo 'KEYMAP="us"' >> /etc/rc.conf
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
xbps-reconfigure -f glibc-locales
echo "Setting root password"
passwd
echo "Creating non-root user"
useradd void
cp /proc/mounts /etc/fstab
xbps-install nano
nano /etc/fstab
xbps-install grub-x86_64-efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Void"
xbps-reconfigure -fa
./install.sh
exit