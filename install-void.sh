#!/bin/bash

echo "This script will install Void Linux using xbps, and then run install.sh. Please ensure you have booted into Void Linux live media. This only works on an EFI system."
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
    mount /dev/sda2 /mnt/
    mkdir -p /mnt/boot/efi/
    mount /dev/sda1 /mnt/boot/efi/
    read -p "Would you like to enable swap?" swapyes
    if [[ "${swapyes,,}" == *"yes"* ]];then
        read -p "What partition would you like to make your swap? " swappartition
        mkswap $swappartition
    fi
    echo "Setting up xbps"
    REPO=https://repo-default.voidlinux.org/current
    ARCH=x86_64
    mkdir -p /mnt/var/db/xbps/keys
    cp /var/db/xbps/keys/* /mnt/var/db/xbps/keys/
    echo "Network configuration. If you have issues here, refer to the manual, try to connect to a network without a captive portal, or try the offical installer."
    ip link show
    read -p "What network device would you like to enable?(ex: eno1) " netdevice
    read -p "Is this network device used for ethernet or WiFi? " wifiorethernet
    if [[ "${wifiorethernet,,}" == *"wifi"* ]];then
        rfkill unblock all
        { echo "scan"; echo "scan_results"; echo "quit"; } | wpa_cli
        read -p "What is the SSID(name) of the network you are connecting to? " MYSSID
        read -p "What type of network are you connecting to?(wpa or wep) " networktype
        if [[ "${networktype,,}" == *"wpa"* ]];then
            read -p "What is the password to the network?" networkpassphrase
            wpa_passphrase $MYSSID $networkpassphrase >> /etc/wpa_supplicant/wpa_supplicant-$netdevice.conf
        else
            echo "I don't know. Figure this out yourself."
            wpa_cli -i $netdevice
        fi
    else
        ip link set $netdevice up
    fi
    sleep 5s
    wpa_cli -i $netdevice
    XBPS_ARCH=$ARCH xbps-install -S -r /mnt -R "$REPO" base-system
    xchroot /mnt /bin/bash
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
    # umount -R /mnt
    # shutdown -r now
else
    echo "Stopping install"
    exit
fi