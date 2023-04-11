#!/bin/bash

numb=0

if [ -s $1 ] && [ -s $2 ]
then
   read -p "Which port we have to check: " portname
   read -p "Print filename: " file
else
   portname=$1
   file=$2
fi

while [ $numb -lt 5 ]
do
  for host in $(cat $file)
  do
    echo $host
    nc -zw1 $host $portname
    if [ $? == 0 ]
    then
       echo "$host is avaible on port - $portname" >> port_log.txt
    else
       echo "$host is not avaible on port - $portname" >> port_log.txt
    fi
  done
numb=$(( $numb+1 ))
done
