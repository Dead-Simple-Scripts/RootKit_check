# RootKit_check

This script checks for root installations based on targeted directory counts using LS and STAT.  It iterates over the directories /etc, /lib, /tmp, /var, and /. 

For each directory:

Print Directory Path: echo -n "$dir: " prints the current directory being processed (/etc, /lib, /tmp, /var, /).

Count Directories: count=$(find "$dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l) counts the number of subdirectories (-type d) within the current directory ($dir). The find command searches for directories (-type d) at a minimum depth of 1 (-mindepth 1) and maximum depth of 1 (-maxdepth 1) to avoid counting directories recursively. 2>/dev/null redirects any error messages to /dev/null, suppressing them from the output.

Count Links: links=$(stat "$dir" | grep 'Links:' | awk '{print $6-2}') fetches the Links value from the stat command output for the current directory ($dir). grep 'Links:' filters the stat output to include only the line containing 'Links:'. awk '{print $6-2}' selects and prints the sixth field (which is the numeric value of Links), subtracts 2 from it to exclude the directory itself (.) and its parent (..).

Print Results: echo "Directories: $count, Links: $links" displays the count of directories ($count) and the adjusted number of links ($links) for the current directory.

Sample results below, mismatch may indicate a hidden rootkit directory:
/etc: Directories: 10, Links: 10
/lib: Directories: 5, Links: 5
/tmp: Directories: 3, Links: 3
/var: Directories: 7, Links: 7
/: Directories: 6, Links: 6

This is based on the Sandfly Security article "Detecting Linux Stealth Rootkits with Directory Link Errors", https://sandflysecurity.com/blog/detecting-linux-stealth-rootkits-with-directory-link-errors/
