#!/bin/bash
echo ""
echo "********************************"
echo "*        Rootkit Checker       *"
echo "*  Automated Directory Checks  *"
echo "*          Version 1           *"
echo "*                              *"
echo "*           by Michael Leclair *"
echo "********************************"
echo ""
echo "Script to automate checking multiple directories for rootkit artifacts"
echo ""
echo "The search uses the ls and stat commands to count the number of directories within specific folders and compares the results. If the findings do not match, it may indicate a compromise, such as a hidden directory undetected by one of the commands due to attacker techniques."
echo ""
echo "The script checks these directories: /etc /lib /tmp /var /"
echo "Modify the search directories in the script for customization"
echo ""
echo ""
echo "Usage: ./rootkit_checker.sh"
echo ""
echo ""
read -p "Press [Enter] key to start rootkit_checker"
clear
echo""
# Start of rootkit_checker script
echo "****************************"
echo "*   Rootkit check started  *"
echo "****************************"
echo ""

for dir in /etc /lib /tmp /var /; do   echo -n "$dir: ";   count=$(find "$dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l);   links=$(stat "$dir" | grep 'Links:' | awk '{print $6-2}');   echo "Directories: $count, Links
: $links"; done
