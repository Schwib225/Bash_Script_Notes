# Shell Scripting Notes - Exit Codes

# Checking an exit code 

echo $?

# Example

ls -l /etc 
echo $?             # This will print the exit code, should be 0 if successful 
ls -l /test
echo $?             # Will fail and give us a non-zero exit code  

---

#!/bin/bash

package=htop

sudo apt install $package

echo "The exit code for the package install is: $?"

__ 

# More complex example by validating the exit code of a command to make descisions 
package=notexist 

sudo apt install $package >> package_install_results.log            # Redirect the output into a log file 
if [ $? -eq 0 ] 
then 
    echo "The installation of the $package was successful."
    echo "The new command is available here: "
    which $package
else    
    echo "$package failed to install." >> package_install_failure.log 
fi 


---

# Example with multiple points of exit codes - watch carefully what exit code you are looking for 

directory=/noexist

if [ -d $directory ]
then
    $?                                                          # Note the exit code here - this will reference the -d $directory statement
    echo "The directory $directory exists"
else
    $?                                                          # Note the exit code here - this will reference the -d $directory statement
    echo "The directory $directory doesnt exist"
fi 

echo "The exit code for this script run is $?"                  # This code will always be '0' because it is referencing the 'echo' statements in the if block

--- 
# Customizing Exit Codes
#!/bin/bash

echo "Hello World"
exit 1 
echo $?                         # This actually does nothing since we are running exit on the previous line

# Now run echo to validate the exit code - it will show 1 
echo $?

# OR

sudo apt install notexist 
exit 0                          # By doing this, we are forcing it to use exit code 0 even though it failed and under normal circumstances it would NOT be 0 

echo $?



---

#!/bin/bash
directory=/etc 

if [ -d $directory ]
then 
    echo "The directory $directory exists"
    exit 0
else 
    echo echo "The directory $directory doesnt exist"
    exit 1
fi 
echo "The exit code for this script run is :$?"
echo "You didnt see this stateent"
echo "Or this one "
