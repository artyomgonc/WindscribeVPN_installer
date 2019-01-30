#!/bin/bash

COL='\033[1;33m'
NC='\033[0m'

if [ -f /etc/os-release ]; then
    . /etc/os-release
    osname=$ID
elif [ -n "$(command -v lsb_release)" ]; then
	osname=$(lsb_release -is)
elif [ -f "/etc/debian_version" ]; then
	osname="Debian"
elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    osname=$DISTRIB_ID
else
    sudo echo -e "${COL}Choosing of your Linux distro${NC}"
    echo
    echo -e "${COL}#${NC} Ubuntu"
    echo -e "${COL}#${NC} Debian"
    echo -e "${COL}#${NC} Fedora"
    echo -e "${COL}#${NC} CentOS"
    echo
    read -r -p "Insert the name of your OS from the list above: " osname
fi

echo -e "${COL}OS: $osname ${NC}"

if [[ $osname =~ ^([uU][bB][uU][nN][tT][uU])$ ]]
then

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        ver=$VERSION_ID
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        ver=$DISTRIB_RELEASE
    else 
        echo
        echo -e "${COL}#${NC} Ubuntu 17.04 and above - [${COL}a${NC}]"
        echo -e "${COL}#${NC} Ubuntu 16.04 - [${COL}b${NC}]"
        echo -e "${COL}#${NC} Ubuntu 14.04 - [${COL}c${NC}]"
        echo
        echo "Insert your OS version from the list above"
        read -r -p "For example, if you have Ubuntu 18.04 type 'a': " vname
        echo
    fi
    
    echo -e "${COL}OS version: $ver ${NC}"
    
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
    
    if [[ $vname =~ ^([aA])$ ]] || [[ $ver -ge 17 ]]
    then
        echo 'deb https://repo.windscribe.com/ubuntu zesty main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list
        echo -e "${COL}Option A${NC}"
    elif [[ $vname =~ ^([bB])$ ]]
    then
        echo 'deb https://repo.windscribe.com/ubuntu xenial main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list
        echo -e "${COL}Option B${NC}"
    elif [[ $ver -lt 17 ]] && [[ $ver -ge 16 ]]
    then
        echo 'deb https://repo.windscribe.com/ubuntu xenial main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list
        echo -e "${COL}Option B${NC}"
    elif [[ $vname =~ ^([cC])$ ]] || [[ $ver -lt 16 ]]
    then
        echo 'deb https://repo.windscribe.com/ubuntu trusty main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list
        echo -e "${COL}Option C${NC}"
    fi 
    
    sudo apt-get update -y
    sudo apt-get install -y windscribe-cli
    
elif [[ $osname =~ ^([dD][eE][bB][iI][aA][nN])$ ]]
then
    
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        ver=$VERSION_ID
    elif [ -f "/etc/debian_version" ]; then
	    ver=$(cat /etc/debian_version)
    else
        echo
        echo -e "${COL}#${NC} Debian 9 and above - [${COL}a${NC}]"
        echo -e "${COL}#${NC} Debian 8 and below - [${COL}b${NC}]"
        echo
        echo "Insert your OS version from the list above"
        read -r -p "For example, if you have Debian 9 type 'a': " vname
        echo
    fi
    
    echo -e "${COL}OS version: $ver ${NC}"
    
    sudo apt-get install -y dirmngr apt-transport-https
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
    
    if [[ $vname =~ ^([aA])$ ]] || [[ $ver -ge 9 ]]
    then
        sudo sh -c "echo 'deb https://repo.windscribe.com/debian stretch main' > /etc/apt/sources.list.d/windscribe-repo.list"
        echo -e "${COL}Option A${NC}"
    fi
    
    if [[ $vname =~ ^([bB])$ ]] || [[ $ver -lt 9 ]]
    then
        sudo sh -c "echo 'deb https://repo.windscribe.com/debian jessie main' > /etc/apt/sources.list.d/windscribe-repo.list"
        echo -e "${COL}Option B${NC}"
    fi
    
    sudo apt-get update -y
    sudo apt-get install -y windscribe-cli

elif [[ $osname =~ ^([fF][eE][dD][oO][rR][aA])$ ]]
then
    echo
    echo -e "${COL}Installation will be successful only with Fedora version 22 and above${NC}"
    echo
    
    sudo wget https://repo.windscribe.com/fedora/windscribe.repo -O /etc/yum.repos.d/windscribe.repo
    sudo yum update -y
    sudo yum install -y windscribe-cli

elif [[ $osname =~ ^([cC][eE][nN][tT][oO][sS])$ ]]
then
    echo
    echo -e "${COL}Installation will be successful only with CentOS version 6 and above${NC}"
    echo
    
    sudo wget https://repo.windscribe.com/centos/windscribe.repo -O /etc/yum.repos.d/windscribe.repo
    sudo yum update
    sudo yum install -y epel-release
    sudo yum install -y windscribe-cli
else
    echo -e "${COL}Sorry, auto-install is currently unavailable for your OS.${NC}"
    exit 0
fi

echo
echo -e "Windscribe successfully installed. If you don't have Windscribe account go to ${COL}https://windscribe.com/signup${NC} and create it."
echo
echo
echo -e "To login to Windscribe VPN use ${COL}windscribe login${NC} command."
echo
echo -e "To connect to Windscribe VPN use ${COL}windscribe connect${NC} command."
echo
echo -e "For more commands use ${COL}windscribe --help${NC} command."
echo

exit 0
exec bash
