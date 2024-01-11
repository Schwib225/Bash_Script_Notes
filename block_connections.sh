#! /bin/bash 

read -p "Enter IP, Network, or Domain to block: " ip 

echo "Blocking connections from $ip" 
sleep 1 

# TODO: Drop packets for specific ip
iptables -I INPUT -s $ip -j DROP 

echo "Done" 


---
# This version you can call with the ip as an argument - remember to run as root 

echo "Blocking connections from ${1}" 
sleep 1 

# TODO: Drop packets for specific ip
iptables -I INPUT -s ${1} -j DROP 

echo "Done" 
