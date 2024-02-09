# Shell Operation in Depth 

1. Tokenization
2. Command Identification 
3. Shell Expansions
4. Quote Removal
5. Redirections
6. Comamnd Execution 

---

# Tokenization 

Bash uses metacharacters to break command line into tokens (words and operators)

Metacharacters: space, tab, newline, |;&()<>

Token types: words and operators 


--

# Command Identification 

Command Types
    simple - a sequence of words separated by blanks and terminated by new line or another control operator
    compound - a command that starts and ends with a reserved word - think if/fi 

If you want to check if a word is reserved, use the 'type' command
 
type if 

type for 

---

# Shell expansions

Covered in Shell Expansions.md

---

Redirections - STDIN and STDOUT

STDIN  (0) - Standard input         <
STDOUT (1) - standard output        >,>>
STDERR (2) - standard error         2>, 2>>


# for just stderr output redirection try this
tail -n 3 /etc/shadow 2> error.txt 
cat error.txt

# for both, use this example
tail -n 2 /etc/shadow > output.txt 2> error.txt 

# redirect stderr to stdout, to a file
tail -n 2 /etc/shadow > output_error.txt 2>&1 
