#!/bin/bash

echo "Installing fonts"
sleep 5s
xbps-install -y noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra
echo "Finished installing fonts"