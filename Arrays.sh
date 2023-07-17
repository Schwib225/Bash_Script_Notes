# Bash Shell Notes - Arrays 

#!/bin/bash 

# Defining Array Values

array_name[index]=value


# Accessing Array Values 

${array_name[index]}


# Accessing all array values - use either or 

${array_name[*]}
${array_name[@]}

# Generic how-to 

# https://www.freecodecamp.org/news/bash-array-how-to-declare-an-array-of-strings-in-a-bash-script/