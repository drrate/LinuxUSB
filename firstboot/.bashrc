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
    sudo pacman -Syu --noconfirm wget 
    sleep 2
    clear
    echo -ne "Downloading setup files.\r"
    sudo mkdir /usr/lib/linuxusb
    for url in $(curl https://raw.githubusercontent.com/drrate/LinuxUSB/main/firstboot/urllist)
    do
    cd /usr/lib/linuxusb
    sudo wget -q $url
    done
} 
echo -ne "Welcome to LinuxUSB, a simple project aimed towards making Linux more user friendly, and computers better. \nThis is the setup program, which might be alarming, but don't worry, it'll tell you what to press.\nPress [ENTER] to continue.\n\n"
echo "This QR code contains a URL to the documentation. You will probably want to scan this before you continue.\n"
cat qr_code
read
clear
echo -ne "The installation needs a valid internet connection. On the next screen, just set up an internet connection, and then exit. \nConsult the documentation if you do not know how to use the menu. .\nPress [ENTER] to continue."
echo -ne "\n\nIf you still need the documentation, the code is right below.\n"
cat qr_code
read
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
     read
     nmtui
    fi
done
clear