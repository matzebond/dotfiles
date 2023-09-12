#!/bin/bash

# Launch bar1 and bar2
# DISPLAY1="$(xrandr -q | grep " connected" | grep 'eDP1\|HDMI-1' | cut -d ' ' -f1)"
DISPLAY1="$(xrandr -q | grep " connected" | grep 'eDP1\|eDP-1' | cut -d ' ' -f1)"
[[ ! -z "$DISPLAY1" ]] && MONITOR=$DISPLAY1 polybar main &

DISPLAY2="$(xrandr -q | grep " connected" | grep 'HDMI1\|HDMI-1' | cut -d ' ' -f1)"
[[ ! -z $DISPLAY2 ]] && MONITOR=$DISPLAY2 polybar main &

DISPLAY3="$(xrandr -q | grep " connected" | grep 'DP3\|DP-3' | cut -d ' ' -f1)"
[[ ! -z $DISPLAY3 ]] && MONITOR=$DISPLAY3 polybar main &
