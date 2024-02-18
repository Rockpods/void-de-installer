#!/bin/bash

# Install printer drivers (I fucking hate printers so much. Why does not a single good printer exist.)
chmod u+x extra/printer.sh
../extra/printer.sh

# Start KDE Plasma 5 install
echo "Starting KDE Plasma 5 install"
sleep 5s
xbps-insatll -y kde5 kde5-baseapps xorg NetworkManager octoxbps elogind dbus pulseaudio alsa-plugins-pulseaudio timeshift cronie bluez xdg-desktop-portal kdegraphics-thumbnailers chrony libavdevice libavcodec xorg-server-xwayland ffthumbs xdg-desktop-portal-kde sddm flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Install fonts
chmod u+x ../extra/fonts.sh
../extra/fonts.sh

# Disable WPA_Supplicant and DHCPCD, and enable NetworkManager
chmod u+x ../extra/NetworkManager.sh
../extra/NetworkManager.sh

# Enabling important services not started elsewhere
ln -s /etc/sv/dbus /var/service/
ln -s /etc/sv/elogind /var/service/
ln -s /etc/sv/bluetoothd /var/service/
ln -s /etc/sv/cronie /var/service/
ln -s /etc/sv/chronyd /var/service/

# Start SDDM service and reboot
ln -s /etc/sv/sddm /var/service/