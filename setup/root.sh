#!/bin/bash

## This sh just does all the root stuff, as bloat is apparently more preferred than clean.

function hostgen
{
    sleep 2
    genrandom=`cat /dev/urandom | tr -dc 'A-Z0-9a-z' | fold -w 12 | head -n 1`
    echo "Hostname generated (USB-$genrandom). You will need a reboot to use this."
    sleep 2
    echo "USB-$genrandom" > /etc/hostname
}
function usergen
{
    useradd -m $1
    usermod -aG cdrom $1
    usermod -aG floppy $1
    usermod -aG netdev $1
    usermod -aG audio $1
    usermod -aG dip $1
    usermod -aG sudo $1
    groupadd wheel
    echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL"
    usermod -aG wheel $1
    usermod -aG video $1
    usermod -aG plugdev $1
    echo -e "$2\n$2" | passwd $1 &>/dev/null
    passwd --lock root &>/dev/null
    passwd -d root &>/dev/null
}
function finalstupidity
{
    mkdir -p /home/$1/.config/autostart
    cp /home/$1/.bashrc /home/$1/.bashrc.bak
    curl https://raw.githubusercontent.com/ycdhleslkrlkyeft253/linusb/main/laststeps/newuser-bashrc -o /home/$1/.bashrc
    curl https://raw.githubusercontent.com/ycdhleslkrlkyeft253/linusb/main/laststeps/finishsetup.desktop -o /home/$1/.config/autostart/desktemp.desktop
    chsh $1 -s /bin/bash
    chmod +x /home/$1/.config/autostart/desktemp.desktop
}
function delete-the-evidence
{
    userdel -r setup
    rm -rfv /home/setup
    apt autoremove
    apt clean
    rm /home/$1/.config/autostart/desktemp.desktop
    rm /home/$1/.bashrc
    mv /home/$1/.bashrc.bak /home/$1/.bashrc
}
if [ $1 -eq "1" ]; then
    hostgen
fi
if [ $1 -eq "2" ]; then
    usergen $2 $3
fi
if [ $1 -eq "3" ]; then
    apt install -y firefox-esr
fi
if [ $1 -eq "4" ]; then
    apt install -y chromium
fi
if [ $1 -eq "5" ]; then
    sudo apt install -y xfce4 xfce4-goodies 
fi
if [ $1 -eq "6" ]; then
    sudo apt install -y lxqt
fi
if [ $1 -eq "9" ]; then
    finalstupidity $2
fi
if [ $1 -eq "10" ]; then
    delete-the-evidence $2
fi
if [ $1 -eq "11" ]; then
    echo "Unrequired function removed, please ignore this message."
fi