#!/bin/bash

for dir in /etc /lib /tmp /var /; do   echo -n "$dir: ";   count=$(find "$dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l);   links=$(stat "$dir" | grep 'Links:' | awk '{print $6-2}');   echo "Directories: $count, Links
: $links"; done
