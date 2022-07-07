#!/bin/sh

# Prepare
sudo apt update
sudo apt install curl -y

# Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh