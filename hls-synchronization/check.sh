#!/bin/bash

# Check current status of main.sh execution.
# If it is not in "S" status it means script is not running.
# Add this script in /etc/crontab like this:
# */1 * * * * root bash /opt/hls-synchronization/check.sh

#CURRENT_STAT=$(ps aux | grep "main.sh" | grep -v grep | awk '{print $8}')
#if [ $CURRENT_STAT != "S" ]
#then
#  echo "Synchronization script is not running"
#else
#  echo "Script is running"
#fi

CURRENT_STAT=$(ps aux | grep "streamnode1.sh" | grep -v grep | awk '{print $8}')
if [ $CURRENT_STAT != "S" ]
then
  echo "Synchronization script is not running for streamnode1"
else
  echo "Script streamnode1.sh is running"
fi

CURRENT_STAT=$(ps aux | grep "streamnode2.sh" | grep -v grep | awk '{print $8}')
if [ $CURRENT_STAT != "S" ]
then
  echo "Synchronization script is not running for streamnode2"
else
  echo "Script streamnode2.sh is running"
fi

CURRENT_STAT=$(ps aux | grep "streamnode3.sh" | grep -v grep | awk '{print $8}')
if [ $CURRENT_STAT != "S" ]
then
  echo "Synchronization script is not running for streamnode3"
else
  echo "Script streamnode3.sh is running"
fi
