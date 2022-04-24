#!/bin/bash
echo "This is the final part of setup. Only a few things left to do."
echo "Now deleting the setup user and files."
sleep 2
username=`whoami`
sudo userdel -r setup &>/dev/null
sudo rm -rfv /home/setup &>/dev/null
sudo apt autoremove -y &>/dev/null
sudo apt clean -y &>/dev/null
rm /home/$username/.config/autostart/desktemp.desktop &>/dev/null
rm /home/$username/.bashrc &>/dev/null
mv /home/$username/.bashrc.bak /home/$username/.bashrc &>/dev/null
sleep 2
echo "Everything seems to be done. Please refer to https://github.com/ycdhleslkrlkyeft253/linusb/blob/docs/finalthings.md (control click) for further information."
echo "Thanks for buying and making use of this product."