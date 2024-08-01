#!/bin/bash

xbps-install -y NetworkManager

echo "Removing DHCPCD and WPA_Supplicant services"
rm /var/service/dhcpcd
rm /var/service/wpa_supplicant
rm /var/service/wicd
rm /var/service/connmand

echo "Enabling NetworkManager service"
ln -s /etc/sv/NetworkManager /var/service/
