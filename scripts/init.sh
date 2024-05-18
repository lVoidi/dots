#!/bin/bash
function run {
  if ! pgrep $1 ;
  then 
    $@&
  fi
}
function discord_rpc {
  if ! pgrep python3 ;
  then 
    nohup python3 ~/.config/awesome/scripts/discord_rich_presence.py&
  fi
}
xrandr --output DisplayPort-0 --mode 1366x768 --rotate normal --output HDMI-A-0 --primary --mode 1920x1080 -r 75 --right-of DisplayPort-0
setxkbmap us -variant altgr-intl
run /bin/nm-applet
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run picom
run mpd
run pasystray
sleep 5
discord_rpc
