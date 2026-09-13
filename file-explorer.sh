#!/bin/bash
set -e

#Day 2 Challenge: Interactive File and Directory Explorer

echo "Welcome to Inioluwa's 2nd day of scripting challenge"
echo 

#Part 1:File and Directory Exploration

while true
do
echo "Files and Directories in the Current Path are:"
echo

ls -lh

echo
read -p "Do you want to keep checking? (y/n): " choice

if [[ "$choice" == "n" || "$choice" == "N" ]]
then
break
fi

echo
done


#Part 2:Character Counting

while true
do
echo
read -r -p "Enter a text (Press Enter to exit): " line

#To check if user sent an empty line
if [[ -z "$line" ]]
then
echo "Exiting Inioluwa's 2nd day of scripting challenge"
break
fi

#Counting characters in text
count=${#line}

echo "Character Count: $count"
done
