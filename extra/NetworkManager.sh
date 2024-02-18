# !/bin/bash

rm /var/service/dhcpcd
rm /var/service/wpa_supplicant
ln -s /etc/sv/NetworkManager /var/service/