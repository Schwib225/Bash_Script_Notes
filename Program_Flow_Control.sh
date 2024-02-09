# Program Flow Control

    Conditional Statements
    Logical Operators
    Nested Blocks
    Arithmetic Comparisons
    String Comparisons 
    Case Statements 


# If, Elif, and Else Statements 

# Basics
if [ some_condition_is_true ]
then 
    # do something
elif [ some_other_condition_is_true ]
then 
    # do something else
else 
    # do last thing
fi 

# Basic Example 

#!/bin/bash
# Display the contents if the input is a file 

if [[ -f "$1" ]]
then 
    echo "The argument is a file, displaying it's contents... "
    sleep 1
    cat $1 
elif [[ -d "$1" ]]
then 
    echo "The arguement is a directory, running ls -l ... "
    sleep 1
    ls -l $1 
else 
    echo "The argument ($1) is neither a file nor a directory."
fi 

## Viewing all testing conditions

man test        # this will give you all conditions in a list 


# NOTE for Brackets 
# Use single [] for older scripts and is not ideal 
# Use [[ ]] as they are safer - this prevents word splitting of string variables and can do regex


# Arithmetic Comparisons 

#!/bin/bash
read -p "Enter your age: " age

if [[ $age -lt 18 ]]
then
    echo "You are minor!"
elif [[ $age -eq 18 ]]
then 
    echo "Contratulations, you've just become major!"
else 
    echo "You are major!"
fi 

# Multiple Conditions and Nested IF/THEN statements 

#!/bin/bash
read -p "Enter your age: " age

if [[ $age -lt 18 && $age -ge 0 ]]
then
    echo "You are minor!"
elif [[ $age -eq 18 ]]
then 
    echo "Contratulations, you've just become major!"
elif [[ $age -gt 18 && $age -le 100 ]]
then
    echo "You are major!"
else
    echo "Invalid age"

if [ $age -lt 18 -a $age -ge 0 ]
then
    echo "You are minor!"
elif [[ $age -eq 18 ]]
then 
    echo "Contratulations, you've just become major!"
elif [[ $age -gt 18 -a $age -le 100 ]
then
    echo "You are major!"
else
    echo "Invalid age"
fi 

# Logical Operators

Logical AND => && for [[ test ]] and -a for [ test ]
Logical OR => || for [[ test ]] and -o for [ test ]

# Another example with and/or from our previous file - Nested IF/THEN 

#!/bin/bash 
if [[ $# -eq 1 ]]
then 
        if [ -f "$1" ] 
        then
                echo "The argument is a file, displaying it's contents... "
                sleep 1
                cat $1 
        elif [ -d "$1" ]
        then
                echo "The arguement is a directory, running ls -l ... "
                sleep 1
                ls -l $1 
        else 
                echo "The argument ($1) is neither a file nor a directory."
        fi 
else 
        echo "This script should be run with an argument!"
fi

# String comparisons 

= for [] and == for [[]]
-n => the string length is non-zero 
-z => the string length is zero 


# Example

#!/bin/bash
read -p "String1: " str1 
read -p "String2: " str2 
# Single braces example 
if [ "$str1" = "$str2" ]
then
    echo "The strings are equal!"
else 
    echo "The strings are not equal!"
fi 
# Double braces example 
if [[ "$str1" == "$str2" ]]
then
    echo "The strings are equal!"
else 
    echo "The strings are NOT equal!"
fi 
# Checking that the two don't match
if [[ "$str1" != "$str2" ]];then 
    echo "the strings are not equal!!"
fi 

# Another example - Checking if a value exists in a string
#!/bin/bash
str1="Nowdays, Linux powers the servers of the internet"

if [[ "$str1" == *"Linux"* ]]
then 
    echo "The substring Linux is there"
else 
    echo "The substring linux is not there"
fi 

# 

#!/bin/bash 
# empty_string checker
my_str="abc"
if [[ -z "$my_str" ]]       # -z is zero-length
then 
    echo "String is zero length"
else 
    echo "String IS NOT zero length"
fi 

if [[ -n "$my_str" ]]
then 
    echo "string is not zero-length."
else 
    echo "string is zero length"
fi 


# Project: Testing Network Connections - Basic if then example - Expand on it to mod gateways or email the admin 
vi connection.sh

#!/bin/bash
output="$(ping -c 3 $1)"
#echo $output
if [[ $output == *"100% packet loss"* ]]
then
        echo "The network connection to $1 is not working!"
else
        echo "The netowrk connection to $1 is working!"
fi

# The CASE Statement 

case "$variable" in
pattern1)
    execute_this_code_1
    ;;
pattern2)
    execute_this_code_2
    ;;
patternN)
    execute_this_code_N
    ;;
*)
    execute_this_default_code   # return if no pattern matches
    ;;
esac 

# CASE Examples

#!/bin/bash 
echo -n "Enter your favorite pet: "
read pet 
case "$pet" in 
"dog") 
    echo "Your favorite pet is a dog"
    ;;
"cat" | "Cat" | "kitty")
    echo "You like cats"
    ;;
"fish" | "African Turtle")
    echo "Fish or turtles are great!"
    ;;
*) 
    echo "Your favorite pet is unknown"
esac 

---
# Getting signal and PID - uses exit status 
#!/bin/bash
if [[ $# -ne 2 ]]
then 
    echo "Run the script with 2 arguments: Signal and PID"
    exit 1          # return status 1 
fi 
case "$1" in
1) 
    echo "Sending the SIGHUP signal to $2"      # Hangup the process 
    kill -SIGHUP $2
    ;;
2)
    echo "Sending the SIGINT signal to $2"
    kill -SIGINT $2 
    ;;
15)
    echo "Sending the SIGTERM signal to $2"
    kill -15 $2
    ;;
*)
    echo "Signal no. $1 will not be delievered."
esac 

# Menus in Bash (The Select Statement)

PS3="Select an Option:"

select ITEM in LIST_OF_OPTIONS
do
    commands 
done 

# Example - using PS3, the built-in $REPLY variable and case statements 

#!/bin/bash
PS3="Choose your Country"                                   # Modifying this value allows you to prompt
select COUNTRY in Germany France USA "United Kingdom" Quit 
do 
    echo "Your country is $COUNTRY"
    echo "Reply is $REPLY"
    case $REPLY in 
    1) 
        echo "You speak German!"
        ;;
    2)
        echo "You speak French!"
        ;;
    3)
        echo "You speak American English!"
        ;;
    4)
        echo "You speak British English!"
        ;;
    5) 
        echo "Quitting..."
        sleep 1 
        exit 
        ;;
    *)
        echo "Invalid Option $REPLY"
        ;;
    esac
done 


# Project: System Administration Script Using Menus 

#!/bin/bash
PS3="Your Choice: "

select ITEM in "Add User" "List all processes" "Kill Process" "Install Program" "Quit"
do 
    if [[ $REPLY -eq 1 ]]
    then 
        read -p "Enter the Username: " username 
        output="$(grep -w $username /etc/passwd)"
        if [[ -n "$output" ]]
        then
            echo "This username already exists!"
        else 
            sudo useradd -m -s $username /bin/bash "$username"
            if [[ $? -eq 0 ]]
            then
                echo "The user was added successfully!"
                tail -n 1 /etc/passwd 
            else 
                echo "There was an issue creating the user!"
            fi
        fi  
    elif [[ $REPLY -eq 2 ]]
    then 
        echo "listing all processes"
        sleep 1 
        ps -ef 
    elif [[ $REPLY -eq 3 ]]
    then 
        read -p "Enter the process to kill: " process 
        pkill $process 
    elif [[ $REPLY -eq 4 ]]
    then 
        read -p "Enter a program to install" app 
        sudo apt update && sudo apt install $app -y 
    elif [[ $REPLY -eq 5 ]]
    then 
        echo "Quitting.."
        sleep 1 
        exit 
    else 
        echo "Invalid Menu Selection"
    fi 
done 

# Chaining Commands - List of Commands 

List operators:
;
&
&&
|| 

# Examples of ';' - Will run sequentially 

command1; command2; command3; 

mkdir project; touch project/a.txt; tar -czvf proejct.tar.gz project/ 

sleep 10; ls -l 

# Examples of '&' - will run both at the same time 

command1& command2 

sleep 10& ls

# Examples of && - the second will only run if the first is successful - chain as many as you want together
command1 && command2 

ls ~ && echo success 

tar -cf project.tar project/ && rm -rf project      # archive and remove the project directory 

# Examples of || - Only runs the second command if the first returns an error - # DO SOMETHING || PROCESS THE ERROR

command1 || command2 

ls ~ || echo 'success'
ls /root || echo 'success'          # run as normal user for the error 

command1 && command2 || command3 

# DOS attack prevention - only run on a VM - creates an infinite number of system processes 

vi fork_bomb.sh 

#!/bin/bash 
$0 && $0 & 

-- 

# TO PREVENT - give users ulimits - dont limit them too much or they wont be able to use the system properly 
vi /etc/security/limits.conf 
# add the following
@admins     hard    nproc       4000 
