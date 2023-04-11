#!/bin/bash

set +e

if [ $(id -u) != 0 ]
then
    echo "Sorry, not enough rights for this action" 1>&2
    exit 1
fi

select option in "Info" "Create" "Delete"

do case $option in

        "Info") read -p "Print username: " user
                echo "All info about user: $(id $user)"
                exit 0 ;;
        "Create") for (( x=0; x < 3; x++ ))
                  do
                    read -p "Print new username: " user
                    if [ $(cut -d':' -f1 /etc/passwd | grep -x "$user") ]
                    then
                        useradd $user
                    fi
                  done
                echo "Sorry, last try ;-;" 1>&2
                exit 1 ;;
        "Delete") read -p "Print username for delete: " user
                  userdel $user
                  exit 0 ;;

   esac
done

set -e
