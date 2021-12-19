#!/bin/bash
echo "This is the final part of setup. Only a few things left to do."
echo "Now deleting the setup user and files."
sleep 2
username=`whoami`
sudo userdel -r setup
sudo rm -rfv /home/setup
sudo apt autoremove
sudo apt clean
rm /home/$username/.config/autostart/desktemp.desktop
rm /home/$username/.bashrc
mv /home/$username/.bashrc.bak /home/$username/.bashrc
sleep 2
echo "Everything seems to be done. Please refer to https://github.com/ycdhleslkrlkyeft253/linusb/blob/docs/finalthings.md (control click) for further information."
echo "Thanks for buying and making use of this product."