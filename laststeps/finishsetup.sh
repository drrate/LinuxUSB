#!/bin/bash
echo "This is the final part of setup. Only a few things left to do."
echo "Now deleting the setup user and files."
username=`whoami`
sudo bash root.sh 10 $username
sleep 2
echo "Everything seems to be done. Please refer to https://github.com/ycdhleslkrlkyeft253/linusb/blob/docs/finalthings.md (control click) for further information."
echo "Thanks for buying and making use of this product."