#!/bin/bash
#NOTE: For this to work, you need a file which includes programs - binary or otherwise - that need to be transfered... This file will be a list. To parse the list

#populate file list first - and you can create a function for this long bash one-liner: 
# find find $HOME/dirpath -type f |  sed 's|^~/bin/||' | tr '\0' '\n' | tee /dirpath/filelist.txt
#As a function in .bashrc, you can always do this: 

#function cutlead {
#    sed 's|^~/bin/||' | tr '\0' '\n'
#}



#Accurately, you also need to run another command ... and I will include more code for that if needed. 
#You could do something as simple as ls dirpath | sed 's|^~/bin/||' ... At least on a Linux system, leading characters of ./ are not good friends of our dear SCP 
#command and if you populate a list by cancatenating files using the good ol' tee command with say find as a pipe - very bad things will happen and those are not 
#good things which are also bad. In short - it won't work ... 

#the files must be parsed onto a list without a trailing < ./ > - or else running the script #against files on a list in any other form will result in imminent #failure 
#As of now, this is limited ... It should work with pretty much any object a sys admin or end user is trying to fetch but I mostly use it for smaller files 
#This has not been tested thoroughly but it is stable or has shown itself to be and I find it mighty handy - if I don't say so myself. Hopefully you enjoy it #whomever you are
if [[ $@ = "-h" ]]; then
    echo "Options: scp-transfer filelist.txt localdir"
elif [[ $# -lt 2 ]]; then 
    echo "Two arguments are required for this script:"
    echo "Options: scp-transfer filelist.txt localdir"
else
    keyfile="/home/user/.ssh/id_rsa"
    filelist="$1"
    targetdir="$2" # local directory - where files go 
    hostarget="gokart@solaris.usbx.me:/home/gokart/downloads/bonbon/"

    # Read the filelist into an array
    readarray -t files_to_transfer < "$filelist"

    # Iterate through the files in the target directory
    for file in "${targetdir}"/*; do
        # Get the filename without the path
        filename="$(basename "$file")"

        # Set a flag to keep track of whether the file should be downloaded
        download_flag=false

        # Check if the file matches any item in the filelist
        for item in "${files_to_transfer[@]}"; do
            if [[ "$item" == "$filename" ]]; then
                download_flag=true
                break
            fi
        done

        if "$download_flag"; then
            # Wrap the filename in double quotes
            quoted_filename="$(printf "%q" "$filename")"

            if scp -i "$keyfile" -r "$hostarget$quoted_filename" "$targetdir"; then
                echo "Successfully transferred file: $filename" | tee -a ~/tmp/scp-transfer-scp.log
            else
                echo "Failed to transfer file: $filename" | tee -a ~/tmp/scp-transfer-scp.log
            fi
        else
            echo "File not in the list. Skipping: $filename" | tee -a ~/tmp/scp-transfer-scp.log
        fi
    done

fi
