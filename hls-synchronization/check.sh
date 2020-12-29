#!/bin/bash

# Check current status of main.sh execution.
# If it is not in "S" status it means script is not running.
# Add this script in /etc/crontab like this:
# */1 * * * * root bash /opt/hls-synchronization/check.sh

CURRENT_STAT=$(ps aux | grep "main.sh" | grep -v grep | awk '{print $8}')
if [ $CURRENT_STAT != "S" ]
then
  echo "Synchronization script is not running"
else
  echo "Script is running"
fi
