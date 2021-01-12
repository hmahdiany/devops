# Synchronize ts files in Nginx servers
This script is used for syncing ts files with rsync

## Requirements
The server which this script is being executed must have ssh access to destination servers.

## Variables
First add username in this part: `USER=`

Next edit the `DST_SERVER` and add correct IP address.

Then if needed add ssh password here: `sshpass -p "YOUR PASSWORD`. If the server is able to access to destination server with public key you should first delete this part of rsync command before executing the script.
