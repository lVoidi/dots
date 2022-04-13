#!/bin/bash 
CURR=$(setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}')

if [[ $CURR == 'us' ]]
then 
    setxkbmap latam
else
    setxkbmap us
fi
