# Viewing all environment / exported variables

env 
env | less 

printenv
printenv HOME SHELL USER

----

# Prompting for User input


read <some variable>
    <type something>

read name age city 
john 30 london 
echo $name 
echo $age 
echo $city 

read -p "Enter an ip address" ip 
8.8.8.8
ping -c 1 $ip 

---

# Positional Parameters

./script.sh filename.txt directory1 10.0.0.1 

$0 or ${0} = script.sh 
$1 or ${1 }= filename.txt 
$2 = directory1
$3 = 10.0.0.1

---

# Special Parameters

$0 = the name of the script itself 
$@ and $* = a string representing all positional parameters 
$# = the number of positional arguments 
$? = the most recent forground command exit status 
$$ = the process id of the shell 

# Note that $@ and $* both represent all positional parameters but there are some differences

$@ = splits everything
"$@" = separates positional parameters into their own variable

$* = the same as $@, splits everything 
"$*" = this uses IFS, which is the internal field separator, which can be modified if you set it as a variable like so:
    IFS=,
    "$*" = this will now combine everything not separated by a comma    


---

vi positional_parameters.sh

#!/bin/bash
echo "1st scripts argument (\$1) is ${1:-abc}"
echo "2nd scripts argument (\$2) is ${2}"
echo "3rd scripts argument (\$3) is ${3}"
#...
echo "10th scripts argument (\$10) is ${10}"
echo "11th scripts argument (\$11) is ${11}"

echo "Script name (\$0) is $0"

echo "\$# is $#"
echo "\$@ is $@"
echo "\$* is $*"
echo "\$? is $?"
echo "\$$ is $$"

---

vi display_and_compress.sh 

#!/bin/bash
echo "Displaying the contents of $1 ..."
sleep 2 
cat "$1"
echo 
echo "Compressing $1 ..."
sleep 2
tar -cjvf "$1.tar.gz" $1  


---

#!/bin/bash
# Note this will need to be run as root 
read -p "Enter an IP to block: " ip
iptables -I INPUT -s $ip -j DROP 


---

read -s -p "Enter new user password: "  pswd 

echo $pswd 