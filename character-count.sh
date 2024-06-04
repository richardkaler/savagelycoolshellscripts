#!/bin/bash


#Accurately count characters used to determine string length, evaluate code. There are two versions here. This needs to be included as a function - 
#and I have this in my bashrc profile... It will also work as an independent script ... if you do it that way, you'll need to edit it possibly - or source it 
#when or if needed

#Function to include in bashrc or similar profile... 
charcount() {
    local input
    input=$(cat)             # Read input from the pipe
    local count
    count=$(echo -n "$input" | wc -m)  # Count the characters, excluding newline
    echo "$count"            # Output the result
}

#This is much more succint - and the reminder of "Not what you expected? ..."  is personal. If you're already using printf. ignore that or leave it comented out
#showchars() { 
#    wc -m
#    echo "Not what you expected? - remember to use \"echo -n\" or \"printf\""
#}
