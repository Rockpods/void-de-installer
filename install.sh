#!/bin/sh

# I am considering replacing the default video app with MPV.
# TO-DO: Work on automatically detecting GPU or promping user about what GPU to use so the graphics driver part actually works. Start work on KDE(and install OctoXBPS if using the KDE install) and Enlightenment.

echo "This is an unofficial script that is in development. If you have any issues, please report it at https://github.com/Rockpods/void-de-installer/"
echo "If you are running this script, you should already have an internet connection and already have Void Linux installed."
echo "This has only been tested by installing from the the 2023-06-28 glibc live image with void-installer on the LCD Steam Deck and an HP laptop. Please be more verbose if reporting issues using a different version of Void."
echo "You will have to reconfigure your WiFi when you boot into GNOME."
echo "IMPORTANT: ENSURE THE GRAPHICS DRIVERS PART OF THE SCRIPT IS SET FOR YOUR SYSTEM. Press ctrl+c now if you must stop the install."
sleep 10s

# Update XBPS and Void packages to continue installation if someone installed from an old ISO without downloading packages from the internet, and enable extra repositories you will probably want to use at some point.
xbps-install -u xbps
xbps-install -Syu
xbps-install void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree

# Replace this part with the graphics drivers install process for what you are using.
xbps-install -y linux-firmware-intel mesa-dri vulkan-loader mesa-vulkan-intel intel-video-accel

# Install GNOME and important software. Flathub is enabled for GNOME-Software
xbps-install -y dbus gnome elogind gdm NetworkManager pipewire gnome-software firefox vlc libreoffice pulseaudio
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Disable the network management services used in the installer. I have refrained from removing these, at least until I do more testing, to ensure you can still disable NetworkManager and return to WPA_Supplicant or DHCPCD if something goes wrong.
rm /var/service/dhcpcd
rm /var/service/wpa_supplicant

# Enabling services required for GNOME to work
ln -s /etc/sv/dbus /var/service/
ln -s /etc/sv/elogind /var/service/
ln -s /etc/sv/NetworkManager /var/service

# Enabling audio with Pipewire and Pipewire-Pulse. Pipewire is very annoying to setup on Void so I will work on this once I remember how to set up Pipewire on Void in general. Feel free to add to this yourself if you so desire.
# mkdir -p /etc/pipewire/pipewire.conf.d
# ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
# ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

# Add directories found in Windows user folder to make it easier to move from Windows or easy to use distros
mkdir ~/Documents ~/Downloads ~/Music ~/Videos ~/Desktop ~/Pictures

# Start GDM service and reboot
ln -s /etc/sv/gdm /var/service/ && reboot