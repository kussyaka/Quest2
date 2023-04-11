#!/bin/bash

for username in $(cat ./username)
do
  echo "Create new user: useradd $username"
done
