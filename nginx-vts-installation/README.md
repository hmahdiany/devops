# Install Nginx-1.18.0 from source + vhost traffic module

This script is used to install Nginx from source and compile vhost traffic module as a dynamic module to see Nginx traffic status details. 

## Requirements
Run this script with `root` user.

## Variables
Before you start executing this script first change `x.x.x.x` in `status.conf` with your correct local office IP address.

Look at this line in `main.sh`:
wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz

Remember that because of US sanctions downloading Golang is forbidden from Iran. You should first set a proxy in server before executing.
