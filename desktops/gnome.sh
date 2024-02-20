#!/bin/bash

# Install GNOME. Flathub is enabled for GNOME Software.
echo "Starting GNOME install"
sleep 5s
xbps-install -y dbus gnome elogind gdm gnome-software firefox pulseaudio alsa-plugins-pulseaudio cronie bluez xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk chrony xorg libavdevice libavcodec xorg-server-xwayland
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

if [[ "${1,,}" == *"extra"* ]]; then
    chmod u+x extra.sh
    ./extra.sh
    xbps-install -y gnome-apps
fi

# Install fonts
chmod u+x ../extra/fonts.sh
../extra/fonts.sh

# Disable WPA_Supplicant and DHCPCD, and enable NetworkManager
chmod u+x ../extra/NetworkManager.sh
../extra/NetworkManager.sh

# Enabling important services not started elsewhere
echo "Enabling other services"
ln -s /etc/sv/dbus /var/service/
ln -s /etc/sv/elogind /var/service/
ln -s /etc/sv/bluetoothd /var/service/
ln -s /etc/sv/cronie /var/service/
ln -s /etc/sv/chronyd /var/service/

# Start GDM service and reboot
echo "Enabling display manager and rebooting"
ln -s /etc/sv/gdm /var/service/