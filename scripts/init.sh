#!/bin/bash
function run {
  if ! pgrep $1 ;
  then 
    $@&
  fi
}
xrandr -r 75
setxkbmap us -variant altgr-intl
run /bin/nm-applet
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run picom
if ! pgrep python3 ;
then
  python3 $HOME/.config/awesome/scripts/discord_rich_presence.py
fi
run mpd
run pasystray
# run nitrogen --restore
