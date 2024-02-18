#!/bin/bash

echo "Removing DHCPCD and WPA_Supplicant services"
rm /var/service/dhcpcd
rm /var/service/wpa_supplicant

echo "Enabling NetworkManager service"
ln -s /etc/sv/NetworkManager /var/service/