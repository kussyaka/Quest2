#!/bin/bash


read -p "Pls, write me your name: " username

if [ $username == "Jhon Doe" ]
then
    echo "Access Granted"
    exit 0
else
    echo "No Acсsess" 1>&2
    exit 1
fi
