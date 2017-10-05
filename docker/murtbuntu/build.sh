#!/bin/bash
cp ~/.ssh/id_rsa .
cp ~/.ssh/id_rsa.pub .
docker build -t murtis/murtbuntu .
rm id_rsa id_rsa.pub
