#!/bin/bash
clear
echo -ne "Now attempting to update the system.\n"
sleep 2
# yes i know this is a bad idea, i'll fix it later
sudo pacman -Sy --noconfirm
sleep 2
clear
sleep 1
echo -ne "Downloading required files.   \r"
sleep 1
sudo mkdir /usr/lib/linuxusb
sudo bash -c "curl https://raw.githubusercontent.com/ycdhleslkrlkyeft253/linusb/main/laststeps/finishsetup.sh &>/usr/lib/linuxusb/finishsetup" &>/dev/null
sudo chmod +x /usr/lib/linuxusb/finishsetup
echo -ne "Downloading required files..   \r"
sleep 1
sudo chmod +x /usr/lib/linuxusb
wget https://raw.githubusercontent.com/ycdhleslkrlkyeft253/linusb/main/setup/root.sh &>/dev/null
echo -ne "Downloading required files...   \r"
sleep 1
wget https://raw.githubusercontent.com/ycdhleslkrlkyeft253/linusb/main/setup/setup.sh &>/dev/null
chmod +x ./* &>/dev/null
echo -ne "Downloading required files.   \r"
sleep 1
echo -ne "Downloading required files..   \r"
sleep 1
echo -ne "Downloading required files... \r"
sleep 2
clear
echo -ne "Downloaded!\n"
sleep 3
chmod +x root.sh >/dev/null
chmod +x setup.sh >/dev/null
bash setup.sh