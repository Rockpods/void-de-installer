#!/bin/bash

xbps-install -y connman

echo "Removing DHCPCD and WPA_Supplicant services"
rm /var/service/dhcpcd
rm /var/service/wpa_supplicant
rm /var/service/NetworkManager
rm /var/service/wicd

echo "Enabling NetworkManager service"
ln -s /etc/sv/connmand /var/service/