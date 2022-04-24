#!/bin/bash

# Let's make the setup into a file with functions, and then call the functions from the bashrc script. 
# -yetanotherdrrate, probably having a terrible idea doing this in 2022.

function systemsetup
{
    echo "Generating a hostname [how pcs know other pcs names]."
    sleep 2
    genrandom=$(tr -dc 'A-Z0-9a-z' < /dev/urandom | fold -w 12 | head -n 1)
    echo "Hostname generated (USB-$genrandom). Check in support discord to change it."
    sleep 2
    sudo hostnamectl set-hostname USB-"$genrandom"
}
function usersetup
{
    echo "Now we meed to set up a new user, as this is a temporary one."
    set=0
    while [ $set -eq 0 ] 
    do
        echo "What do you want the new username to be? (Type the username, and then press [ENTER])"
        echo -ne "Username>"
        read -r user
        if [ -z "$user" ]
        then
        clear
        else
        set=1
        fi
    done
    set=0
    while [ $set -eq 0 ] 
    do
        echo "What do you want the new password to be? (Type the password, and then press [ENTER])"
        echo -ne "password>"
        read -r pass
        if [ -z "$pass" ]
        then
        clear
        else
        set=1
        clear
        fi
    done
    for group in cdrom wheel plugdev
    do
    groupadd $group
    usermod -aG $group "$user"
    done
    echo -e "$pass\n$pass" | passwd "$user" &>/dev/null
    echo -e "$pass\n$pass" | passwd root &>/dev/null
}
function workspacesetup
{
set=0
while [ "$set" -eq 0 ]
do
    echo "We should install the desktop now."
    echo "Press 1 for KDE [YOU NEED A BIG DRIVE, AT LEAST 4GB!], 2 for XFCE4, or 3 for LXQT, then press [Enter]"
    echo -ne "?>"
    read -r gui
    if [ "$gui" -eq "1" ]; then
        set=1
        sudo pacman -S plasma-meta kde-applications sddm xorg-server --noconfirm
        sudo systemctl enable sddm
    fi
    if [ "$gui" -eq "2" ]; then
        set=1
        sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter xorg-server --noconfirm
        sudo systemctl enable lightdm
    fi
    if [ "$gui" -eq "3" ]; then
        set=1
        sudo pacman -S lxqt breeze-icons sddm xscreensaver xorg-server --noconfirm
        sudo systemctl enable sddm
    fi
    if [ -z "$set" ]; then
        echo "Please choose a desktop to install. Press [ENTER] to continue."
        read -r
    fi
    clear
    echo "Now we need to install the browser."
    echo -ne "Press 1 for Firefox, or 2 for Chromium (Generic Google Chrome).\n"
    echo -ne "?>"
    read -r -r browserchoice
    if [ "$browserchoice" -eq "1" ]; then
        set=1
        sudo pacman -S firefox --noconfirm
    fi
    if [ "$browserchoice" -eq "2" ]; then
        set=1
        sudo pacman -S chromium --noconfirm
    fi
    if [ -z $set ]; then
        echo "Please choose a browser to install. Press [ENTER] to continue."
        read -r
    fi
done
}
function oobefinish
{
    sudo mkdir -p "/home/$1/.config/autostart"
    echo "H4sICNfYZWIAA2ZpbmlzaHNldHVwLmRlc2t0b3AAFcmxDoIwEIDh/Z6CFxB0c+mg
sU7GmAAuxqHUEy7CtblrE3h7YfiX739dUH8pxMJykuUNln34EPemba67IzxRlAKb
Q7mHZoloTjGO5F1aERqUidiNJklGsDN6U2WVaqRujfOctau+xKSDYsqx1AHubkJz
22Zbn4t64+IhoRc3wR++sdG/jAAAAA==" | base64 --decode | gzip -d | sudo tee "/home/$1/.config/autostart/desktemp.desktop"
    sudo chsh "$1" -s /bin/bash
    sudo chmod +x "/home/$1/.config/autostart/desktemp.desktop"
    echo "H4sICOPKZWIAA2ZpbmlzaHNldHVwLnNoAI2Sy0oEMRBF9/MV5QPRxXTApaALwZ2o
oH5AOqlMQiepJqnM6N9bnVHRhQ8IJCGnLpV76+hAjSGrUVe/QuMJDp98qCCLPYIL
WUeYdWEgBxW5zQPc5/gKGhzuhAl5UyGiY2ACS8Phu8od7cBiRBagS/ViaBUL6GxF
OWIVukbEGc5Xy0PWCS+PT3eedApnq9os9QLRgXXZK3SBkytlcatyi3FPlSSA24Ly
lFD9As7aJJ1h/WgMrNeZDGUXpPorKNe9zvFHU2ro3EbpxlRZ7BC6ToxpHvqB5j8V
FoeL+Yal7U+YbNO/JD7sMxF1ebf+ZovltScjlmGqSzIjSjgZB3gQsCIUdGKPPHjm
uV4otQns2yj/TMqWohnVbcjt5fnxWo2RRmXJVNXHYZ/5kCyciitcKIKJwUxn4KiA
a0XSLhCy3JLmQPlzJp68zlPtWNLT0p/8bRksXkZuLmSbYaHfAJq+9auUAgAA" | base64 --decode | gzip -d | sudo tee "/usr/lib/linuxusb/finishsetup.sh"
    sudo chmod +x /usr/lib/linuxusb/finishsetup.sh
}