#!/bin/bash

# Define username
USER=

# Destination servers
DST_SERVERS=(Destination server addresses)

# Main folder
MAIN_FOLDER=/tmp/hls

while true
do
        for DST_SERVER in ${DST_SERVERS[*]}
        do
               rsync -zar --delete -e 'sshpass -p "YOUR PASSWORD" ssh' $MAIN_FOLDER/ $USER@$DST_SERVER:$MAIN_FOLDER

        done

done
