#!/bin/bash
#set -e

#This is day 3 of the scripting challenge

# Function to display help information 
show_help() { 
    echo "Usage: $0 [OPTION]" 
    echo 
    echo "User Account Management Script" 
    echo 
    echo "Options:" 
    echo " -c, --create Create a new user account" 
    echo " -d, --delete Delete an existing user account" 
    echo " -r, --reset Reset a user's password" 
    echo " -l, --list List all user accounts and their UIDs" 
    echo " -h, --help Display this help message" 
}

#Part 1: Account Creation
create_user() {
    read -p "Enter the new username: " username
    if id "$username" &>/dev/null
    then
    echo "User '$username' already exists"
    return 1
    fi

    read -s -p "Enter the password for $username: " password
    echo

    sudo useradd "$username"
    echo "$username:$password" | sudo chpasswd

    echo "User '$username' was successfully created"
}

#Part 2: Account Deletion
delete_user() {
    read -p "Enter the username to delete: " username
    if ! id "$username" &>/dev/null
    then
    echo "User '$username' does not exist"
    return 1
    fi

    sudo userdel "$username"

    echo "User '$username' was successfully deleted"
}

#Part 3: Password Reset
reset_password() {
    read -p "Enter the username: " username
    if ! id "$username" &>/dev/null
    then
    echo "User '$username' does not exist"
    return 1
    fi

    read -s -p "Enter the neww password: " password
    echo
    
    echo "$username:$password" | sudo chpasswd

    echo "Password for user '$username' was successful"
}

#Part 4: List User Accounts
list_users() {
    echo "User Accounts and UIDs: "
    echo
    printf "%-25s %s\n" "USERNAME" "UID"
    echo "----------------------------------------"

    while IFS=: read -r username password uid gid info home shell
    do
    printf "%-25s %s\n" "$username" "$uid"
    done < /etc/passwd
}

#Check whether an option was provided 
if [[ $# -eq 0 ]] 
then
echo "No option was provided." 
echo 
show_help 
exit 1 
fi 

# Process the command-line argument 
case "$1" in 

-c|--create)
create_user
;;

-d|--delete)
delete_user 
;;

-r|--reset)
reset_password
;;

-l|--list)
list_users
;; 

-h|--help)
show_help
;;

*)
echo "Invalid option: $1" 
echo show_help 
exit 1 
;; 

esac
