#!/bin/bash

COL='\033[1;33m'
NC='\033[0m'

sudo git clone https://github.com/artgonatiacool/WindscribeVPN_installer

cd WindscribeVPN_installer
sudo bash install.sh

cd ..
sudo rm -r ./WindscribeVPN_installer

exec bash