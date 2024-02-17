## Void Linux Desktop Environment Installer

<b>NOT AFFILIATED WITH THE VOID LINUX PROJECT.</b>\
An install script for Void Linux that installs GNOME, and sets it up for day-to-day use.

### Installation Instructions:

NOTE: The script only installs Intel graphics drivers by default at the moment. If you have a different GPU, replace the packages installed in line 19 with the recommended packages for your GPU, which can be found in the [Void Linux Documentation](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/index.html).
1. Install Void Linux using the `void-installer` script included in the ISO. Install from network source, or else you will have to run a few extra commands on some occasions.
2. Boot into Void Linux and sign in as any user.
3. Run `xbps-install -S git` as root.\
    NOTE: If you have an issue running this command, try updating XBPS by running `xbps-install -u xbps` as root.
4. Download and run the installer by running the following commands:\
    ```sh
    git clone --depth=1 https://github.com/Rockpods/void-de-installer
    cd void-de-installer
    chmod u+x install.sh
    sudo ./install.sh
    ```
    If you want to view the script before running, run the following command: `cat install.sh | less`. Press q to exit less.\
    <b>OPTIONS:</b>\
    Non-free software: You will be prompted if you want to enable nonfree repos to enable nonfree softare. If you do not know what this is, I suggest pressing pressing `Y` when prompted to enable this. Press `N` to keep nonfree repos disabled.