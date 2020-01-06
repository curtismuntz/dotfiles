#!/bin/bash
server=$1
printf "%s" "waiting for $server..."
while ! ping -c 1 -n -w 1 $server &> /dev/null
do
      printf "%c" "."
      sleep 1
done
printf "\n%s\n"  "$server is back online"

ping $server
