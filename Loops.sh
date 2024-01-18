# Loops 

# FOR Loops - Useful for iterating over a list

for item in list_of_values
do 
    RUN_THESE_COMMANDS
done 

# Example - Test with basic value input

#!/bin/bash 
for os in Ubuntu Pop!_OS Slackware Kali 
do 
    echo "OS is $os"
done 
for num in {3..7}
do 
    echo "num is $num"
#    touch "./$num.txt"
done 
for x in {10..100..5}
do 
    echo "$x"
done 


# Second Example 

#!/bin/bash
for item in ./*
do 
    if [[ -f $item ]]
    then
        echo "Displaying the contents of $item"
        sleep 1
        cat $item 
        echo "##############################"
    fi 
done 

# Renaming files in a dir as another example

#!/bin/bash
for file in *.txt 
do 
    mv "$file" "renamed_by_script_$file"
done 

# Displaying a list of numbers

#!/bin/bash
numbers="3 5 9 10 68 "
for n in $(echo $numbers);do
    echo -n "$n "
done 

# C_STYLE_FOR_LOOP

#!/bin/bash
for ((i=0;i<=20;i++))
do 
echo "i=$i"
done 

# Project - Dropping a list of IP addresses Using for Loops

#!/bin/bash 
DROPPED_IPS="8.8.8.8 1.1.1.1 10.10.11.1"
for ip in $DROPPED_IPS
do
    echo "Dropping packets from $ip"
    iptables -I INPUT -s $ip -j DROP 
done 

    # This version will take a list of IPs from a file
#!/bin/bash 
DROPPED_IPS="8.8.8.8 1.1.1.1 10.10.11.1"
for ip in $(cat ips.txt)
do
    echo "Dropping packets from $ip"
    iptables -I INPUT -s $ip -j DROP 
done 

## While Loops - Useful when we dont know the length of the list of iterations 

while CONDITION
do
    RUN_THESE_COMMANDS
done 

# Example 1 

i=0
while [[ $i -lt 10 ]]
do 
    echo "i=$i"
    (( i++ ))
#   let i=i+1       # same as above 
done 

# Infinite Loop
while [[ 1 -eq 1 ]]                
do
    echo "Infinite loop, press CTRL+C to exit"
done 

# Creating an infinite loop to monitor the system 

#!/bin/bash
while :                 # always returns true 
do 
    output="$(pgrep -l $1)"
    if [[ -n  "$output" ]]
    then
        echo "The process \"$1\"is running."
    else 
        echo "The process \"$1\" is NOT running."
    fi 
    sleep 3 
done 

# Single line while loop

while true; do echo "infinite loop"; sleep 1; done 


# Using it for checking connections - using return codes to determine while condition 
vi while_ping.sh

#!/bin/bash
while ping -c 1 8.8.8.8         # This uses the return code to determine if it is true or not 
do 
    echo "Ping was successful"
    sleep 1 
done 


# While READ 

#!/bin/bash

while read line 
do 
    echo $line 
done< $1                # This will echo any file that you select out 

# While Process Subsitution 

while read line 
do 
    echo $line 
done< <(ping -c 3 8.8.8.8)      # Echo's each line 


# Project: Dropping a list of IPs using awhile and process substitution

vi ips.txt 

1.1.1.1
8.8.4.4
1.2.3.4
6.10.10.10
10.0.10.10


vi drop_ips_while.sh

#!/bin/bash

while read ip 
do
    # echo $ip 
    echo "Dropping packets from $ip"
    iptables -I INPUT -s $ip -j DROP 
    sleep 0.5
done < ./ips.txt  

# Same with process substitution

while read ip 
do
    # echo $ip 
    echo "Dropping packets from $ip"
    iptables -I INPUT -s $ip -j DROP 
    sleep 0.5
done <(cat ips.txt)  

# Break and Continue With Loops 

# Break example 1 
i=0

while [[ $i -lt 7 ]]
do 
    echo "i is $i"
    (( i++ ))
    if [[ $i -eq 3 ]]
    then 
        echo "i is 3 and I am exiting the loop..."
        break 
    fi 
done 


# Break example with ping 

#!/bin/bash
while true 
do 
    ping -c 1 $1 &> /dev/null               # redirect output to /dev/null 
    if [[ $? -eq 0 ]]
    then 
        echo "OK"
    else 
        echo "I am exiting the while loop"
        break 
    fi 
    sleep 1
done 
echo "ping to $1 is not working, I'm sending an email to the admin."


# Continue Example - Printing only odd numbers 

#!/bin/bash
for i in {1..15}
do
        result=$(( i % 2 ))
        if [[ $result -eq 0 ]]
        then
                continue
        fi
        echo $i
done

# Bash Arrays 
# one-dimensional array 
# Indexed arrays 

ages=(20 22 40 29 38)   # Indexed array example 
echo $ages              # will only print the first value 
echo ${ages[@]}         # prints all values
echo ${ages[*]}         # prints all but different, check the values in previous tutorials 

echo ${#ages[@]}        # gives the length of the array
echo ${!ages[@]}        # gives the indicies in an array 

echo ${ages[0]}         # first array value
echo ${ages[2]}         # third array value 

echo ${ages[-1]}        # negatives go in reverse order, so this will yield the last element in the array 


numbers[0]=100          # Create new array
numbers[1]=200          # add values to the array 
echo ${numbers[@]}      # validate 
numbers[1]=500          # this will overwrite the previous value 
echo ${numbers[@]}

declare -a names        # declaring an array 
names[0]='Dan'
names[1]='Alina'
names[2]='Diana'
names[7]='Michael'

echo ${!names[@]}       # note the position of 'Michael' is 7 as we defined

unset names[1]          # remove 'Alina' from the array 

# Arrays in Depth 

# Slicing an array
years=(2018 2019 2020 2021 2022 2023)
years+=(2024)           # append to the end of the array 
echo ${years[@]}
echo ${years[@]:2}      # Start at index 2 and continue until the end of the array 
echo ${years[@]:2:4}    # will go from position 2 and show the next 4 positions in the array

# To create an associate array, you must use the 'declare' statement like so

declare -A userdata
userdata[username="youradmin"]
userdata[password='asdflkj']
userdata[uid=100]

echo ${userdata[username]}              # call the value for key 'username'
echo ${!userdata[@]}                    # This will print all key values w/o the keys

userdata[login]="$(date --utc +%s)"     # add a login parameter
echo ${!userdata[@]} 

userdata+=([shell]="Bash")              # This is another way to add a value (syntax)

unset userdata[password]                # clear a value 

# Declaring a read-only associative array

declare -r -A SUPERSTARS=(
    [Germany]="Boney M"
    [USA]="Bon Jovi"
    [England]="The Beatels"
)
echo ${SUPERSTARS[@]}

SUPERSTARS[USA]="Metallica"             # This fails 

# The READARRAY command 

readarray some_var

testing
1
2
3

# Reading from a file

readarray ips < <(cat ips.txt)      # This uses process substitution to redirect the input to 'readarray' command 

echo ${!ips[@]}

---

readarray users < <(cut -d: -f1 /etc/passwd)        # Grabs all users on the system 
echo ${users[@]}

readarray files< <(ls /etc)                         # Grabs all files in the etc dir 
echo ${files[@]}

# Iterating over arrays 
