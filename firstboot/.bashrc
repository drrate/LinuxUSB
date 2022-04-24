#!/bin/bash
# shellcheck source=/dev/null'
clear
# Add functions.
function testnet {
    curl https://raw.githubusercontent.com/drrate/LinuxUSB/main/docs/captivebuster.md | grep "[CaptivePortalSuccess]"
    return $?
}
function downloadfiles {
    # Yes, I am aware this is a suicidal piece of code if a huge update did things.
    echo -ne "Now attempting to update the system.\n"
    sleep 3
    sudo pacman -Syu --noconfirm wget curl
    sleep 2
    clear
    echo -ne "Downloading setup files.\r"
    sudo mkdir /usr/lib/linuxusb
    for url in $(curl https://raw.githubusercontent.com/drrate/LinuxUSB/main/firstboot/urllist)
    do
    cd /usr/lib/linuxusb || return
    sudo wget -q $url
    done
    echo "Setup files done downloading."
} 
echo -ne "Welcome to LinuxUSB, a simple project aimed towards making Linux more user friendly, and computers better. \nThis is the setup program, which might be alarming, but don't worry, it'll tell you what to press.\nPress [ENTER] to continue.\n\n"
echo "This QR code contains a URL to the documentation. You will probably want to scan this before you continue."
cat qr_code
read -r
clear
echo -ne "The installation needs a valid internet connection. On the next screen, just set up an internet connection, and then exit. \nConsult the documentation if you do not know how to use the menu. .\nPress [ENTER] to continue."
echo -ne "\n\nIf you still need the documentation, the code is right below.\n"
cat qr_code
read -r
clear
nmtui
networking=0
while [ $networking -le 0 ]
do
    echo "Testing if the internet works..."
    #sleep 3
    #wget -q --spider http://httpforever.com     old code, not reliable if the school or anywhere else blocks github or anything else, or a captive portal exists
    testnet
    if [ $? -eq 0 ]; then
     clear
     echo "The internet seems to be working, continuing."
     networking=1
     sleep 1
    else
     echo "It seems that the connection has failed. Please connect to a working internet connection."
     echo "Press enter to continue..."
     echo -ne "\nIf you still need the documentation, the code is right below.\n"
     cat qr_code
     read -r
     nmtui
    fi
done
clear
downloadfiles
source <(curl -s https://raw.githubusercontent.com/drrate/LinuxUSB/main/firstboot/webrc)
echo "Starting the setup functions. This is a POINT OF NO RETURN, make sure the pc will stay on until setup finishes [at worst, 2h later]"
systemsetup
usersetup
workspacesetup
clear
echo "It seems the usb stick is almost ready for usage now. Just a few more things are needed."
echo "The PC will reboot, just load back into the USB stick, and log into your new username with your selected username and password."
echo "Once that's done, you'll have to go through one last script to clean up the setup, and get contact information and all. That's it."
echo -ne "\nPress enter to continue..."
read -r
oobefinish
sudo reboot