clear
echo -ne "Welcome to LinuxUSB, a simple project aimed towards killing Windows usage. \nThis is the setup program, which might be alarming, but don't worry, it'll tell you what to press.\nPress [ENTER] to continue.\n\n"
echo "This QR code contains a URL to the documentation. You will probably want to scan this before you continue."
cat qr_code
read
clear
echo -ne "The installation needs a valid internet connection. On the next screen, just set up an internet connection, and then exit. \nConsult the documentation if you do not know how to use the menu. .\nPress [ENTER] to continue."
echo -ne "\n\nIf you still need the documentation, the code is right below."
cat qr_code
read
clear
sudo nmtui
tempvar=0
while [ $tempvar -le 0 ]
do
    echo "Testing if the internet works..."
    #sleep 3
    wget -q --spider http://duckduckgo.com
    if [ $? -eq 0 ]; then
     clear
     echo "The internet seems to be working, continuing."
     tempvar=1
     #sleep 1
    else
     echo "It seems that the connection has failed. Please connect to a working internet connection."
     echo "Press enter to continue..."
     echo -ne "\nIf you still need the documentation, the code is right below.\n"
     cat qr_code
     read
     nmtui
    fi
done
wget https://raw.githubusercontent.com/ycdhleslkrlkyeft253/linusb/main/startup/dl.sh
chmod +x dl.sh
clear
bash dl.sh