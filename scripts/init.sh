#!/bin/bash
function run {
  if ! pgrep $1 ;
  then 
    $@&
  fi
}

xrandr --output LVDS1 --mode 1366x768 --rotate normal \
       --output VGA1 --primary --mode 1920x1080 --rotate normal --right-of LVDS1
run /bin/nm-applet
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run picom
if ! pgrep python;
then
  cd $HOME/Projects/python/discord/selfbot
  python main.py
fi
