#!/bin/bash

echo "This script will install Void Linux using xbps, and then run install.sh. DO NOT USE THIS. RUN THE OFFICIAL INSTALLER. THIS IS ME TESTING IF I CAN ADJUST 'install-void-scripted.sh' TO TAKE USER INPUT."
echo "WARNING: THIS IS AN UNOFFICAL SCRIPT. DO NOY REPORT ANY ISSUES TO THE VOID LINUX TEAM! void-installer is the official script. Report any issues at https://github.com/Rockpods/void-de-installer"

read -p "Do you want to continue with the installation?(yes/no) " install
if [[ "${install,,}" == *"yes"* ]];then
    lsblk
    read -p "What disk do you want to install to? DOUBLE CHECK BECAUSE A WRONG INPUT HERE COULD RUIN YOUR INSTALL AND YOUR FLASH DRIVE." install
    cfdisk $install
    read -p "What partition do you want to install /(root directory) to? " rootpartition
    mkfs.btrfs $rootpartition
    read -p "What partition do you want to make your ESP(/boot/efi)? " esppartition
    mkfs.vfat $esppartition
    echo "Mounting created partitions"
    mount $rootpartition /mnt/
    mkdir -p /mnt/boot/efi/
    mount $rootpartition /mnt/boot/efi/
    read -p "Would you like to enable swap? " swapyes
    if [[ "${swapyes,,}" == *"yes"* ]];then
        read -p "What partition would you like to make your swap? " swappartition
        mkswap $swappartition
    fi
    echo "Setting up xbps"
    REPO=https://repo-default.voidlinux.org/current
    ARCH=x86_64
    mkdir -p /mnt/var/db/xbps/keys
    cp /var/db/xbps/keys/* /mnt/var/db/xbps/keys/
    # echo "Network configuration. If you have issues here, refer to the manual, try to connect to a network without a captive portal, or try the offical installer."
    # ip link show
    # read -p "What network device would you like to enable?(ex: eno1) " netdevice
    # read -p "Is this network device used for ethernet or WiFi? " wifiorethernet
    # if [[ "${wifiorethernet,,}" == *"wifi"* ]];then
    #     rfkill unblock all
    #     # { echo "scan"; echo "scan_results"; echo "quit"; } | wpa_cli
    #     wpa_cli -i $netdevice
    #     fi
    # else
    #     ip link set $netdevice up
    # fi
    echo "Start installation"
    sleep 5s
    XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system
    xchroot /mnt /bin/bash << ./install-void-xchroot.sh
    umount -R /mnt
    shutdown -r now
else
    echo "Stopping install"
    exit
fi