# Install GNOME and important software. Flathub is enabled for GNOME Software.
echo "Starting GNOME install"
sleep 5s
xbps-install -y dbus gnome elogind gdm NetworkManager gnome-software firefox vlc libreoffice pulseaudio alsa-plugins-pulseaudio timeshift cronie bluez xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk chrony xorg libavdevice libavcodec xorg-server-xwayland
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo "GNOME install finished"