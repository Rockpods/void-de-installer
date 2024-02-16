#!/bin/sh

# Add audio and optional nice-to-have apps. Also, remove the default video app and replace it with MPV.
# Also, install fonts and shit. After I get GNOME working good with some good options and defaults, I will start working on a lightweight DE(enlightenment is what I am most considering at the moment).
# I might attempt a TUI package manager at one point just to see if I can do it

echo "WARNING: This is an unofficial script that is in development. If you have any issues, please report it at https://github.com/Rockpods/void-installer/tree/main"
#echo "If you are running this script, you should already have an internet connection and already have Void Linux installed."
#echo "This has only been tested by installing from the the 2023-06-28 glibc live image with void-installer on the LCD Steam Deck. Please be more verbose if reporting issues using a different version of Void."
echo "ENSURE THE GRAPHICS DRIVERS PART OF THE SCRIPT IS SET FOR YOUR SYSTEM. You will have to manually configure internet using nmtui, which will not automatically open. Press ctrl+c now if you disagree with anything."
sleep 8s

# Update XBPS & void to continue installation if someone installed from an old ISO without downloading packages from the internet.
sudo xbps-install -u xbps
sudo xbps-install -Syu

# Replace this part with the graphics drivers install process for what you are using. Better solution is planned, but I just want something that works at the moment.
xbps-install linux-firmware-intel mesa-dri vulkan-loader mesa-vulkan-intel intel-video-accel

xbps-install dbus gnome elogind gdm NetworkManager
rm /var/service/dhcpcd
rm /var/service/wpa_supplicant
ln -s /etc/sv/dbus /var/service/
ln -s /etc/sv/elogind /var/service/
ln -s /etc/sv/NetworkManager /var/service
ln -s /etc/sv/gdm /var/service/
sleep 15s
reboot