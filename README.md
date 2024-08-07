## Void Linux Desktop Environment Installer

**NOT AFFILIATED WITH THE VOID LINUX PROJECT.**\
An script that installs GNOME or KDE on Void Linux. This project was started so that there would be a somewhat easy way to set up a desktop environment, just as Arch Linux has. If you are looking for the official void-installer, that can be found [here](https://github.com/void-linux/void-mklive).

### Installation Instructions:

**Warning: If you have an NVIDIA GPU, replace the NVIDIA graphics card packages with the recommended packages for your GPU, which can be found in the [Void Linux Documentation](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/index.html).**
1. Install Void Linux using the `void-installer` script included in the ISO. Install from network source, or else you will have to run a few extra commands on some occasions.
2. Boot into Void Linux and sign in as any user.
3. Run `xbps-install -S git` as root.\
    NOTE: If you have an issue running this command, try updating XBPS by running `xbps-install -u xbps` as root.
4. Download and run the installer by running the following commands:
    ```sh
    git clone --depth=1 https://github.com/rockpods/void-de-installer
    cd void-de-installer
    chmod u+x install.sh
    sudo ./install.sh
    ```
    If you want to view the script before running, run the following command: `cat install.sh | less`. Press q to exit less.\
    If you want to not install printer drivers, open `printer.sh` at `desktops/extra/printer.sh` in a text editor and edit line 3 to say `install="n"`.
<!-- 5. If you want to create the same directories in your home folder that would be exist on a Windows machine, run the folllowing command:
    ```sh
    mkdir ~/Documents ~/Downloads ~/Music ~/Videos ~/Desktop ~/Pictures
    ``` -->
6. If you are using an SSD, after log in, check the [Void Linux Documentation](https://docs.voidlinux.org/config/ssd.html) to learn how to enable periodic trim. Cronie should already be installed and enabled.
