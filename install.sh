#!/bin/bash
if ! [ $(id -u) = 0 ]; then
   echo "This script must be run as root"
   exit 1
fi
mv ./shutdownButton/ /etc/
cd /etc/shutdownButton/
cp ./shutdownButton.service /etc/systemd/system
systemctl daemon-reload
systemctl enable shutdownButton.service

#Ask user if they are using a power indicator
echo
read -p 'Are you using a power indicator led connected to GPIO 14 (Pin 8)? (y/n): ' pwrIndctr <&1
echo
case $pwrIndctr in
y|Y ) echo 'enable_uart=1' >> /boot/config.txt ;;
* ) echo 'User said not using a power indicator led';;
esac

echo 'Reboot Needed!'