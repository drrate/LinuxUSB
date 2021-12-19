clear
echo -ne "Now we need to set up the system.\n"
sleep 3
echo -ne "Generating a hostname, contact the person who gave you the USB if you want to change it.\n"
chmod +x root.sh &>/dev/null
sudo bash ./root.sh 1
sleep 2
clear
echo "Now we meed to set up a new user, as this is a temporary one."
sleep 1
echo "What do you want the new username to be? (Type the username, and then press [ENTER])"
echo -ne "Username>"
read username
echo "Ok. Got $username, now going to use it."
echo "What do you want the new user's password to be? MAKE SURE to write it down. (Type the password, and then press [ENTER])"
echo -ne "Password>"
read password
clear
echo "Got password, now creating the new user."
sudo bash ./root.sh 2 $username $password
sleep 2
echo "User created successfully."
sleep 5
set=0
while [ $set -eq 0 ]
do
    clear
    echo "Now we need to install the browser."
    echo -ne "Press 1 for Firefox ESR, or 2 for Chromium (Generic Google Chrome).\n"
    echo -ne "?>"
    read -r browserchoice
    if [ $browserchoice -eq "1" ]; then
        set=1
        sudo bash ./root.sh 3
    fi
    if [ $browserchoice -eq "2" ]; then
        set=1
        sudo bash ./root.sh 4
    fi
    if [ $set -eq 0 ]; then
        echo "Please choose a browser to install. Press [ENTER] to continue."
        read
    fi
done
sleep 2
set=0
clear
echo "Installing LXQT, later there will be more options, but currently XFCE is broken. [ENTER]"
read
sudo apt install lxqt -y
# Broken (Xfce has a bug.)

# while [ $set -eq 0 ]
# do
#     clear
#     echo "Now we need to install a Desktop Environment."
#     echo -ne "Press 1 for XFCE 4 (macOS friendly, but is highly configurable and can look like Windows), or 2 for LXQt (Windows friendly out of the box).\n"
#     echo -ne "?>"
#     read -r dmchoice
#     if [ $dmchoice -eq "1" ]; then
#         set=1
#         sudo bash ./root.sh 5
#     fi
#     if [ $dmchoice -eq "2" ]; then
#         set=1
#         sudo bash ./root.sh 6
#     fi
#     if [ $set -eq 0 ]; then
#         echo "Please choose a Desktop Environment to install. Press [ENTER] to continue."
#         read
#     fi
# done
sleep 2
clear
echo "It seems the usb stick is almost ready for usage now. Just a few more things are needed."
echo "The PC will reboot, just load back into the USB stick, and log into your new username with your selected username and password."
echo "Once that's done, you'll have to go through one last script to clean up the setup, and get contact information and all. That's it."
echo -ne "\nPress enter to continue..."
read
sudo bash ./root.sh 9 $username
sudo bash ./root.sh 11
# oh hey its the police
sudo reboot