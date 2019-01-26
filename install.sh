#!/bin/bash

COL='\033[1;33m'
NC='\033[0m'

sudo echo -e "${COL}Choosing of your Linux distro${NC}"
echo
echo -e "${COL}# Ubuntu${NC}"
echo -e "${COL}# Debian${NC}"
echo -e "${COL}# Fedora${NC}"
echo -e "${COL}# CentOS${NC}"
echo
read -r -p "Insert the name of your OS from the list above:" osname

if [[ $osname =~ ^([uU][bB][uU][nN][tT][uU])$ ]]
then
    echo
    echo "${COL}#${NC} Ubuntu 17.04 and above - [${COL}a${NC}]"
    echo "${COL}#${NC} Ubuntu 16.04 - [${COL}b${NC}]"
    echo "${COL}#${NC} Ubuntu 14.04 - [${COL}c${NC}]"
    echo
    echo "Insert your OS version from the list above"
    read -r -p "For example, if you have ${COL}Ubuntu 18.04${NC} type '${COL}174${NC}':" vname
    echo
    
    if [[ $vname =~ ^([aA])$ ]]
    then
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
        echo 'deb https://repo.windscribe.com/ubuntu zesty main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list
        sudo apt-get update
        sudo apt-get install windscribe-cli
    fi  
    
    if [[ $vname =~ ^([bB])$ ]]
    then
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
        echo 'deb https://repo.windscribe.com/ubuntu xenial main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list
        sudo apt-get update
        sudo apt-get install windscribe-cli
    fi
    
    if [[ $vname =~ ^([cC])$ ]]
    then
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
        echo 'deb https://repo.windscribe.com/ubuntu trusty main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list
        sudo apt-get update
        sudo apt-get install windscribe-cli
    fi  
fi

if [[ $osname =~ ^([dD][eE][bB][iI][aA][nN])$ ]]
then
    echo
    echo "${COL}#${NC} Debian 9 and above - [${COL}a${NC}]"
    echo "${COL}#${NC} Debian 8 and below - [${COL}b${NC}]"
    echo
    echo "Insert your OS version from the list above"
    read -r -p "For example, if you have ${COL}Debian 9${NC} type '${COL}9${NC}':" vname
    echo
    
    if [[ $vname =~ ^([aA])$ ]]
    then
        sudo apt-get install dirmngr apt-transport-https
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
        sudo sh -c "echo 'deb https://repo.windscribe.com/debian stretch main' > /etc/apt/sources.list.d/windscribe-repo.list"
        sudo apt-get update
        sudo apt-get install windscribe-cli
    fi
    
    if [[ $vname =~ ^([bB])$ ]]
    then
        sudo apt-get install dirmngr apt-transport-https
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
        sudo sh -c "echo 'deb https://repo.windscribe.com/debian jessie main' > /etc/apt/sources.list.d/windscribe-repo.list"
        sudo apt-get update
        sudo apt-get install windscribe-cli
    fi
fi

if [[ $osname =~ ^([fF][eE][dD][oO][rR][aA])$ ]]
then
    echo
    echo "${COL}Installation will be successful only with Fedora version 22 and above${NC}"
    echo
    
    sudo wget https://repo.windscribe.com/fedora/windscribe.repo -O /etc/yum.repos.d/windscribe.repo
    sudo yum update
    sudo yum install windscribe-cli
fi

if [[ $osname =~ ^([cC][eE][nN][tT][oO][sS])$ ]]
then
    echo
    echo "${COL}Installation will be successful only with CentOS version 6 and above${NC}"
    echo
    
    sudo wget https://repo.windscribe.com/centos/windscribe.repo -O /etc/yum.repos.d/windscribe.repo
    sudo yum update
    sudo yum install epel-release
    sudo yum install windscribe-cli
fi

echo
echo -e "${COL}Windscribe successfully installed. If you don't have Windscribe account go to ${NC}https://windscribe.com/signup${COL} and create it.${NC}"
echo
echo
echo -e "To login to Windscribe VPN use ${COL}windscribe login${NC} command."
echo
echo -e "To connect to Windscribe VPN use ${COL}windscribe connect${NC} command."
echo
echo -e "To get help use ${COL}windscribe --help${NC} command."

exit 0
