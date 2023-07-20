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

#!/bin/bash

if [[ $@ = "-h" ]]; then
    #echo "-------------------Help Menu-------------------"
    #echo "options:"
    echo "Options: scp-transfer.sh filelist.txt localdir"
elif [[ $# -lt 2 ]]; then 
    echo "Two arguments are required for this script:"
    echo "Options: scp-transfer.sh filelist.txt localdir"
else

keyfile="$HOME/username/.ssh/id_rsa" #scp keyfile ... if this is not included, the script will require a password and that will effectively eliminate whatever utility it otherwise had
filelist="$1"
#filedir="$2"
hostarget="domain:/dirpath/"
targetdir="$2" #local directory - where files go 

while IFS= read -r filename; do
  # Wrap the filename in double quotes
  quoted_filename="$(printf "%q" "$filename")"

  if scp -i "$keyfile" -r "$hostarget$quoted_filename" $targetdir; then
    echo "Successfully transferred file: $filename" | tee -a ~/tmp/scp-transfer.log
elif ! scp -i "$keyfile" -r $hostarget"$quoted_filename" "$targetdir"; then
    echo "Failed to transfer file: $filename" | tee -a ~/tmp/scp-transfer.log
else 
    echo "Error: exiting script" | tee -a ~/dirpath/logfile.log
    exit 1  
  fi

done < "$filelist"

fi

