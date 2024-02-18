#!/bin/bash

echo "DO NOT USE THIS. RUN THE OFFICIAL INSTALLER. THIS IS ME TESTING IF I CAN ADJUST 'install-void-xchroot-scripted.sh' TO TAKE USER INPUT."
echo "WARNING: THIS IS AN UNOFFICAL SCRIPT. DO NOY REPORT ANY ISSUES TO THE VOID LINUX TEAM! void-installer is the official script. Report any issues at https://github.com/Rockpods/void-de-installer"
sleep 15s

read -p "What shall be the hostname of the system? " thehostname
ls /usr/share/kbd/keymaps/i386/qwerty
read -p "What keymap should be installed?(ex: us) " thekeymap
echo $thehostname >> /etc/rc.conf
echo $thekeymap >> /etc/rc.conf
xbps-reconfigure -f glibc-locales
echo "Setting root password"
passwd
echo "Creating non-root user"
read -p "What username do you want to use? " username
useradd $username
cp /proc/mounts /etc/fstab
vi cp /proc/mounts /etc/fstab
xbps-install grub-x86_64-efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Void"
xbps-reconfigure -fa
./install.sh
exit