# Universal Update Script 

# Generic Example - Checking for a dir to make a descision 

#!/bin/bash 

if [ -d /etc/pacman.d ]
then 
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu 
fi 

if [ -d /etc/apt ]
then
    # The host is based on Debian or Ubuntu,
    # Run the apt version of the command
    sudo apt update 
    sudo apt dist-upgrade 
fi 

--- 

# Searching based on os-release file 

#!/bin/bash 

release_file=/etc/os-release 

if grep -q "Arch" $release_file                                                 # -q for grep is 'quiet mode'
then 
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu 
fi 

if  grep -q "Debian" $release_file || grep -q "Ubuntu" $release_file            # the || means 'or' in this case 
then
    # The host is based on Debian or Ubuntu,
    # Run the apt version of the command
    sudo apt update 
    sudo apt dist-upgrade 
fi 

---

# Operators 

||          # OR
&&          # AND
