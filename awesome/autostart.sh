#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop
#run xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#run xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
# run xrandr --output LVDS1 --mode 1366x768 --rotate normal --output VGA1 --primary --mode 1920x1080 --rotate normal --right-of LVDS1

#autorandr horizontal
run nm-applet
#run caffeine
run pamac-tray
run variety
run xfce4-power-manager
run blueberry-tray
run picom
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run numlockx on
run volumeicon
run nitrogen --restore
run dunst
run conky -c $HOME/.config/awesome/system-overview
#you can set wallpapers in themes as well

#run applications from startup
#run firefox
#run atom
#run dropbox
#run insync start
#run spotify
#run ckb-next -b
#run discord
#run telegram-desktop
