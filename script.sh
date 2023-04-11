#!/bin/bash

read -p "Pls, write username: " username

if grep "$username" /etc/passwd > /dev/null
then
   echo "Shell: $(cat /etc/passwd | grep $username | cut -d':' -f7)"
   exit 0
else
   echo "No such username" 1>&2
   exit 1
fi

