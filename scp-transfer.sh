#!/bin/bash
#NOTE: For this to work, you need a file which includes programs - binary or otherwise - that need to be transfered... This file will be a list. To parse the list

#populate file list first - and you can create a function for this long bash one-liner: 
# find find $HOME/dirpath -type f |  sed 's|^~/bin/||' | tr '\0' '\n' | tee /dirpath/filelist.txt
#As a function in .bashrc, you can always do this: 

#function cutlead {
#   sed 's|^./||' | tr '\0' '\n'  
#}



#Accurately, you also need to run another command ... and I will include more code for that if needed. 
#You could do something as simple as ls dirpath | sed 's|^~/bin/||' ... At least on a Linux system, leading characters of ./ are not good friends of our dear SCP 
#command and if you populate a list by cancatenating files using the good ol' tee command with say find as a pipe - very bad things will happen and those are not 
#good things which are also bad. In short - it won't work ... 

#the files must be parsed onto a list without a trailing < ./ > - or else running the script #against files on a list in any other form will result in imminent #failure 
#As of now, this is limited ... It should work with pretty much any object a sys admin or end user is trying to fetch but I mostly use it for smaller files 
#This has not been tested thoroughly but it is stable or has shown itself to be and I find it mighty handy - if I don't say so myself. Hopefully you enjoy it #whomever you are

if [[ $1 = "-h" ]]; then
    echo "Options: scp-transfer filelist.txt localdir"
elif [[ $# -lt 2 ]]; then 
    echo "Two arguments are required for this script:"
    echo "Options: scp-transfer filelist.txt localdir"
else
    keyfile="/home/username/.ssh/id_rsa"
    filelist="$1"
    targetdir="$2" # local directory - where files go 
    hostarget="domain:dirpath/"

    # Read the filelist into an array
    readarray -t files_to_transfer < "$filelist"

    # Array to store filenames already processed
    processed_files=()

    # Iterate through the files in the target directory
    for filename in "${files_to_transfer[@]}"; do
        # Check if the file has been processed before
        if [[ " ${processed_files[*]} " == *" $filename "* ]]; then
            echo "File already processed. Skipping: $filename" | tee -a ~/tmp/scp-transfer.log
            continue
        else
            # Add the filename to the processed_files array
            processed_files+=(" $filename ")

            # Wrap the filename in double quotes
            quoted_filename="$(printf "%q" "$filename")"

            if scp -i "$keyfile" -r "$hostarget$quoted_filename" "$targetdir"; then
                echo "Successfully transferred file: $filename" | tee -a ~/tmp/scp-transfer.log
            else
                echo "Failed to transfer file: $filename" | tee -a ~/tmp/scp-transfer.log
            fi
        fi
    done

fi

