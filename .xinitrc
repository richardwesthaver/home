#!/bin/sh
xrdb .Xresources &
xset r rate 200 40 &
xset s off -dpms &
systemctl --user import-environment DISPLAY
case $session in
  sway              ) exec sway;;
  stumpwm           ) /usr/local/bin/stumpwm;;
  i3|i3wm           ) exec i3;;
  kde               ) exec startplasma-x11;;
  xfce|xfce4        ) exec startxfce4;;
  leftwm            ) exec leftwm;;
  
  # No known session, try to run it as command
  *                 ) /usr/local/bin/stumpwm;;
esac
