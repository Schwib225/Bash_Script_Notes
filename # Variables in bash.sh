# Variables in bash

# TO get a full list use the 'set' command - this will be a massive list so use grep or more to go through it slowly

set 

# use unset to remove a variable 

unset <variable> 


# Defining variables - use lower case and underscores as a best practice, constants and ENV variables should be upper case 

os="Ubuntu"

declare -r LOGDIR=/var/log          # You cannot unset this type of variable 

# Calling variables

age=30
os="Kali Linux"

# These are the same 
echo $os
echo ${os}

# Note if you want to append you will need the braces

os=Windows

echo ${os}11        # this would not work without the braces since you are referencing os11 as a variable

# Setting Variables with commands

x="ls | wc"
eval "$x"
y=$(eval "$x")
echo "$y"

# Kubernetes Variable set example

DU2_NS="du-2"
DU2_POD="kubectl -n $DU2_NS get po | grep du | cut -d ' ' -f 1"
PO=$(eval "$DU2_POD")
kubectl -n $DU2_NS exec -ti ${PO} -- tail -f /data/storage/log/mvrp.redirect


# Bash Quoting Mechanisms

1. Single Quotes
2. Double Quotes
3. The escape character

# The following will not work
echo 'I am learning $os and I am $age years old.'
# The following will work properly - double quotes
echo "I am learning $os and I am $age years old."

echo me \& you 