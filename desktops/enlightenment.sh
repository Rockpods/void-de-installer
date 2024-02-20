#!/bin/bash

echo "Starting Enlightenment install"
sleep 5s
xbps-install -y xorg elogind dbus pulseaudio alsa-plugins-pulseaudio cronie chrony libavdevice libavcodec firefox flatpak terminology rage-player
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo