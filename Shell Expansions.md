# Shell Expansions 

Command Line processing explained:

1. Tokenization
2. Command Identification
3. Shell Expansion 
4. Quote removal 
5. Redirections
6. Command execution 

There are 8 Types of expansions:

1. Brace Expansion
2. Tilde Expansion
3. Parameter and Variable Expansion 
4. Command Substitution 
5. Arithmatic expansion 
6. Process Substitution
7. Word Splitting
8. Filename expansion 

---

# Brace Expansion example: 

String lists

echo 01-{old,new,current,backup}.txt

Nested string list

echo 01-{old,new,current,{10,20,30}backup}.txt

Sequence Lists

echo {1..100}
echo {a..j}
# Adding an increment value
echo {1..20..2}

---

# Tilde Expansion 

~ = home directory for current user
~+ = current directory
~- = previous directory 
^^ = Upper case
,, = Lower Case

os=Linux
echo ${os^^}

# Setting a Default value - in this case it will be 1.1.1.1 if there is not $ip variable set 

ping ${ip:-1.1.1.1}

# Setting the default if it is not assigned - this will run the 'set' command essentially 

ping ${ip:=1.1.1.1}
echo $ip 

---

# Command Substitution

# 2 ways to do this, backtick and $()

now=`date`
echo $now
now="`now`"
echo $now

OR

users="$(who)"

sudo tar -czf etc-$(date +F_%H%M).tar.gz /etc/ 

---
# Arithmetic Expansion 

$((expression))

x=$(( 7*9 ))
echo $x

let y=2**8
echo $y

# Floating numbers not possible by default, this is the only way

echo "scale=2;11/4" | bc 

bc <<< "scale=3;23/7"

---

# Process Substitution

syntax <(command)

<(ls)
echo <(ls) 
cat <(ls)

---

# Word splitting

# Uses IFS (internal field separator) which is space,tab or newline by default, can be changed by changing that default 

to see them:

echo ${IFS@Q}

# Example

dirs="d1 d2 d3"
mkdir $dirs         # this will create 3 directories
mkdir "$dirs"       # this will make a single directory with the nname of the variable

IFS=":"
dirs="d1:d2:d3" 
mkdir $dirs          # this will create 3 directories


---

# Filename Expansion (Globbing)

* = matches any string
? = matches any single character
[] = matches a single character from within a range 

touch f{a..c}{1..10}.txt
touch f

ls f*
ls fa*.txt
ls fa?.txt
ls fa[123].txt

ls [f-h][a-zA-Z0-9]*
echo f[a-z][0-9].txt
rm f[a-z][0-9].txt


---

Example: Creating nested dirs and files with brace expansion - normally 183 commands to achieve the same result


sudo mkdir -p /var/log/app/{January/{01..31},February/{01..28},March/{01..31}}
touch -p /var/log/app/{January/{01..31}/log.daily,February/{01..28}/log.daily,March/{01..31}/log.daily} 