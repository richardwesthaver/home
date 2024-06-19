#!/usr/local/env bash
import png:- >> ${1:-"$(date +%s).png"}
# take screenshot of current window on sway
# swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | grim -g - ${1:-"$(date +%s).png"}
