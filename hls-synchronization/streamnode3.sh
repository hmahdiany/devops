#!/bin/bash

# Define username
USER=

# Destination servers
DST_SERVER=

# Main folder
MAIN_FOLDER=/tmp/hls

while true
do
    rsync -zar --delete -e 'sshpass -p "YOUR PASSWORD" ssh' $MAIN_FOLDER/ $USER@$DST_SERVER:$MAIN_FOLDER
done
