#!/bin/bash

# Start KDE Plasma 6 install
echo "Starting KDE Plasma 6 install"
sleep 5s
# This install command claims to be installing kde5, but if you check the packages in the Void repos, the name for the Plasma 6 meta package is kde5.
xbps-install -y kde5 xorg elogind dbus pulseaudio alsa-plugins-pulseaudio cronie bluez xdg-desktop-portal kdegraphics-thumbnailers chrony libavdevice libavcodec xorg-server-xwayland ffmpegthumbs xdg-desktop-portal-kde sddm firefox flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#if [[ "${1,,}" == *"extra"* ]]; then
#    chmod u+x extra.sh
#    ./extra.sh
#    xbps-install -y kde5-apps
#fi

# Install fonts
chmod u+x extra/fonts.sh
./extra/fonts.sh

# Disable WPA_Supplicant and DHCPCD, and enable NetworkManager
chmod u+x extra/NetworkManager.sh
./extra/NetworkManager.sh

# Enabling important services not started elsewhere
ln -s /etc/sv/dbus /var/service/
ln -s /etc/sv/elogind /var/service/
ln -s /etc/sv/bluetoothd /var/service/
ln -s /etc/sv/cronie /var/service/
ln -s /etc/sv/chronyd /var/service/

# Start SDDM service and reboot
echo "Enabling display manager and rebooting"
ln -s /etc/sv/sddm /var/service/
