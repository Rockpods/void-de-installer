#!/bin/bash

# TO-DO: Start work on KDE(and install OctoXBPS if using the KDE install) and Enlightenment. Automated install to be worked on.
# Last tested on the x86-64 2024-03-14 base glibc install

echo "This script is not endorsed by the Void Linux project. If you have any issues, please report them at https://github.com/Rockpods/void-de-installer/."
echo "You will have to reconfigure your WiFi after boot."
echo "If you are running this script, you should already have an internet connection and already have Void Linux installed."
echo "IMPORTANT: NVIDIA grapics drivers may not work correctly."
read -p "Do you want to continue with the installation?(yes/no) " gpu
if [[ "${gpu,,}" == *"n"* ]];then
   echo "exiting installer"
   exit
fi

read -p "What desktop environment do you want to install(kde or gnome): " de
read -p "What GPU are you using(AMD, Intel, or NVIDIA): " gpu
#read -p "Do you want to install extra apps like LibreOffice(yes or no): " extra
# Install printer drivers
chmod u+x extra/printer.sh
./extra/printer.sh

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
    if [[ "${extra,,}" == *"yes"* ]]; then
        ./desktops/gnome.sh extra
    else
        ./desktops/gnome.sh; fi
else
    chmod u+x desktops/kde.sh
    if [[ "${extra,,}" == *"yes"* ]]; then
        ./desktops/kde.sh
    else
        ./desktops/kde.sh
    fi
fi

read -p "Do you want to reboot(yes or no): " reboot
if [[ "${reboot,,}" == *"y"* ]];then
   reboot
fi
