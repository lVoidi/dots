#!/bin/bash
function run {
  if ! pgrep $1 ;
  then 
    $@&
  fi
}
xrandr --output LVDS1 --mode 1366x768 --pos 0x156 --rotate normal --output DP1 --off --output HDMI1 --off --output VGA1 --primary --mode 1920x1080 --pos 1366x0 --rotate normal --output VIRTUAL1 --off
setxkbmap us -variant altgr-intl
run /bin/nm-applet
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run picom
run mpd
# run nitrogen --restore
