# LinuxUSB [Continued]
The setup files for LinuxUSB, soon there will be other things too.

To make your own, here's how:
- Install bare arch linux to a USB Stick, or a tmpfs drive [to make a premade image to mass write to usbs or other purposes].
- Create a new user called `setupuser`, and place it in the group `wheel`.
- Set the password for that user to `setup`, just in case you need to sign in manually somehow. This user gets deleted by the script, don't worry about security there.
- Edit `/etc/sudoers` to allow group `wheel` to use `sudo` without a password.
- Install NetworkManager, and enable it to start on boot with `systemctl enable NetworkManager`
- Replace the bashrc in `/home/setupuser` with the one in the setup folder. This will prompt the user to set up a network connection, and then will update and download the rest of the installer.
- Follow the steps [here](https://wiki.archlinux.org/title/Getty#Automatic_login_to_virtual_console) to auto login setupuser on boot.
- TODO: rest of this [I'm currently reinventing the wheel by archifying LinuxUSB, so this is to be continued.]



# Other info.
- forked by me due to the fact that i completely lost access to ycdhleslkrlkyeft253