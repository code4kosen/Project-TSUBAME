#!/bin/sh

sudo apt update && sudo apt upgrade -y
sudo apt install python3
sudo apt install python3-pip
sudo apt install ntpdate
pip3 install pillow
pip3 install google-cloud-firestore
pip3 install schedule
sudo ntpdate ntp.nict.jp
sudo cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#python3 /mnt/c/Users/hmjn0/myfile/wicon/test.py