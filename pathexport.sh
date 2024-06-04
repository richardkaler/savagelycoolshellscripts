#!/bin/bash 

#this is a helper script if you feel that manually modifying your path variables in .bashrc is tedious. 


# Prompt the user to enter the directory location
read -r -p "Please enter the directory location you would like to add to the PATH: " directory_location

# Check if the directory exists
if [ ! -d "$directory_location" ]; then
  echo "Directory not found. Please enter a valid directory location."
  exit 1
fi

# Add the directory to the PATH environment variable
if ! grep -q "^export PATH=.*:$directory_location$" /home/"$USER"/.bashrc; then
  if [ -f  /home/"$USER"/.bashrc ]; then
    echo "export PATH=\"\$PATH:$directory_location\"" >> /home/"$USER"/.bashrc
    #source  "/home/"$USER"/.bashrc"
    echo "Directory added to PATH successfully!"
    echo "Type: < source ~/.bashrc > for changes to take effect immediately"
  else
    echo "Error: ~/home/"$USER"/.bashrc file not found!"
    exit 1
  fi
else
  echo "Directory already exists in PATH!"
fi
