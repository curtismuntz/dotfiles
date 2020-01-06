#!/bin/bash
set -e

server=$1
if [[ -z ${server} ]]; then
  echo "Usage: $0 <servername or ip>"
  exit 1
fi

# https://askubuntu.com/a/929711/819866
printf "%s" "waiting for $server..."
while ! ping -c 1 -n -w 1 $server &> /dev/null
do
      printf "%c" "."
      sleep 1
done
printf "\n%s\n"  "$server is back online"

ping $server
