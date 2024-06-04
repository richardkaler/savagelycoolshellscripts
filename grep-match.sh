#!/bin/bash

#Use this to pattern match strings contained in files within selected directories. NOTE: the cool thing about this is that I have also sed "grep -n" which 
#includes line numbers to the output, so that you can easily hop into the text for your file and troubleshoot, identify, manipulate the data in question. 

read -rp "Enter full path of parent dir for search. 
Ex: /home/user/Desktop: " parent

if [[ -d "$parent" ]]; then  
    echo "proceeding" 
else 
    echo "ERROR! Invalid location - exiting now"
    exit 1 
fi

read -rp "Enter the string you want to grep: " stringval

if [[ -n "$stringval" ]]; then 
find "$parent" -type f | while IFS= read -r fileitem
do
    match="$(grep --color=always "$stringval" "$fileitem")"
    if [[ -n "$match" ]]; then 
        echo "match for $fileitem:"
        grep --color=always -n "$stringval" "$fileitem"
    fi
done 
fi
