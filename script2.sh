#!/bin/bash

if [ $(id -u) != 0 ]
then
   echo "Sorry, not enough rights for this action" 1>&2
   exit 1
fi

read -p "Write username: " username

if $(id $username > /dev/null 2> /dev/null)
then
   echo "Pls Wait."
   sleep 1
   echo "Pls Wait.."
   sleep 1
   echo "Pls Wait..."
   echo "Yes, we have such user!"
else
   echo "No such User" 1>&2
   exit 1
fi



echo "User uid - $(cat /etc/passwd | grep -m 1 $username | cut -d':' -f3)"
echo "User home directory - $(cat /etc/passwd | grep -m 1 $username | cut -d':' -f6)"
echo "User groups - $(groups $username)"

select option in "Change uid" "Change home directory" "Сhange group" "Exit"
do case $option in
        "Change uid") read -p "Write new uid: " uid
                      usermod -u $uid $username ;;
        "Change home directory")  read -p "Print new directory full way: " directory
                                  for (( x=0 ; x < 3 ; x++))
                                  do
                                    read -p "Do you want to move content in new directory?(Yes/No)" permission
                                    if [ $permission == "Yes" 2> /dev/null ] || [ $permission == "Y" 2> /dev/null ]
                                    then
                                       usermod -m -d $directory $username
                                       exit 0
                                    elif [ $permission == "No" 2> /dev/null ] || [ $permission == "N" 2> /dev/null ]
                                    then
                                       usermod -d $directory $username
                                       exit 0
                                    fi
                                   done
                                   echo "Sorry, you lose your chance" 1>&2
                                   exit 1 ;;
        "Сhange group") for (( x=0 ; x < 3 ; x++ ))
                        do
                          read -p "Do you want to change main or sub group(main/sub)?" group
                          if [ $group == main 2> /dev/null ]
                          then
                             for (( y=0 ; y < 3 ; y++ ))
                             do
                               read -p "Write me new main group: " main
                               if $(cut -d':' -f1 /etc/group | grep -x $main > /dev/null 2> /dev/null)
                               then
                                  usermod -g $main $username
                                  exit 0
                               fi
                             done
                             echo "Sorry, You lose your chance" 1>&2
                             exit 1
                          elif [ $group == sub 2> /dev/null ]
                          then
                             for (( y=0 ; y < 3 ; y++ ))
                             do
                               read -p "Write me new sub group: " sub
                               if $(cut -d':' -f1 /etc/group | grep -x $main > /dev/null 2> /dev/null)
                               then
                                  usermod -G $sub $username
                                  exit 0
                               fi
                             done
                             echo "Sorry, You lose your chance" 1>&2
                             exit 1
                          else
                             echo "Write normally pls"
                          fi
                        done
                        echo "Sorry, you lose your chance" 1>&2
                        exit 1 ;;
        "Exit") echo "Exit"
                exit 0 ;;
   esac
done













