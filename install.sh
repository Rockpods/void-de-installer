#!/bin/bash

# TO-DO: Start work on KDE(and install OctoXBPS if using the KDE install) and Enlightenment.

echo "This script is not endorsed by the Void Linux project. If you have any issues, please report them at https://github.com/Rockpods/void-de-installer/."
echo "This has only been tested by installing from the the 2023-06-28 glibc live image with void-installer on the LCD Steam Deck and an HP Intel laptop. Please be more verbose if reporting issues using something different."
echo "You will have to reconfigure your WiFi after boot."
echo "If you are running this script, you should already have an internet connection and already have Void Linux installed."
echo "IMPORTANT: IF YOU ARE USING AN NVIDIA GPU, DO NOT CONTINUE UNTIL YOU KNOW THAT THE GRAPHICS DRIVERS BEING INSTALLED ARE THE CORRECT ONES FOR YOUR CARD."
read -p "Do you want to continue with the installation?(yes/no) " gpu
if [[ "${gpu,,}" == *"n"* ]];then
   echo "exiting installer"
   exit
fi

read -p "What desktop environment do you want to install(kde or gnome): " de
read -p "What GPU are you using(AMD, Intel, or NVIDIA): " gpu

# Update and enable optional repos
xbps-install -u xbps
xbps-install -Syu
xbps-install -y void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree

# Install graphics drivers and firmware/microcode
xbps-install -y intel-ucode linux-firmware-amd
if [[ "${gpu,,}" == *"amd"* ]]; then
    echo "Installing graphics drivers for an AMD GPU."
    sleep 4s
    xbps-install -y mesa-dri vulkan-loader mesa-vulkan-radeon amdvlk xf86-video-amdgpu xf86-video-ati mesa-vaapi mesa-vdpau
    else if [[ "${gpu,,}" == *"intel"* ]]; then
        echo "Installing graphics drivers for an Intel GPU."
        sleep 4s
        xbps-install -y mesa-vulkan-intel vulkan-loader intel-video-accel mesa-dri linux-firmware-intel
        else if [[ "${gpu,,}" == *"nvidia"* ]]; then
            echo "Installing graphics drivers for an NVIDIA GPU."
            sleep 4s
            xbps-install -y nvidia nvidia-libs-32bit
            else
            echo "Could not find a supported GPU. Press ctrl+c now if you want to stop install."
            sleep 15s
        fi
    fi
fi

# Install desktop environment
if [[ "${de,,}" == *"gnome"* ]]; then
    chmod u+x desktops/gnome.sh
    ./desktops/gnome.sh
else
    chmod u+x desktops/kde.sh
    ./desktops/kde.sh
fi

reboot