#!/bin/bash


USER='';
PASSWORD='';
HOST='';
PORT='50110'
LOCAL_PATH='/var/backup/';
REMOTE_PATH='/var/backup/';




latest_file='ls -t | head -n 1'
RECENT=$(ssh ${USER}@${HOST} -p ${PORT} "cd /var/backup && $latest_file");
echo $RECENT
scp -P 50110  root@$HOST:/var/backup/$RECENT .
gunzip $RECENT
SQLFILE=$(ls -t | head -n 1)
echo $SQLFILE

mysql -u${USER} -p${PASSWORD}  armaghan_tv < ${SQLFILE}

