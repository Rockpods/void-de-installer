#!/bin/bash

# read -p "Do you want to install printer drivers?(y/n) "
# if [[ "${install,,}" == *"y"* ]];then
#     echo "Installing printer drivers"
#     sleep 5s
xbps-install -y brother-brlaser epson-inkjet-printer-escpr cnijfilter2 hplip-gui cnijfilter2 cups-filters gutenprint foomatic-db foomatic-db-nonfree avahi nss-mdns
ln -s /etc/sv/avahi-daemon /var/service/
# else
#     echo "Not installing printer drivers."
# fi