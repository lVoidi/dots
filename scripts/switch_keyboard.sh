#!/bin/bash 
CURR=$(cat /tmp/kb_map)

if [[ $CURR == 'us' ]]
then 
    setxkbmap latam && echo 'latam' > /tmp/kb_map
    
else
    setxkbmap us && echo 'us' > /tmp/kb_map
fi
CURR=$(cat /tmp/kb_map)
notify-send "Layout: $CURR"
