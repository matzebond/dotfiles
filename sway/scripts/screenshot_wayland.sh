#!/bin/bash

case $1 in
    "window")
	rect=$(swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select(.pid and .visible) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)
	;;
    "output")
	rect=$(swaymsg -t get_outputs | jq -r '.[] | select(.active) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)
	;;
    *)
	rect=$(slurp)
esac

grim -g "$rect" - | wl-copy -t image/png
# grim -g "$rect" screenshot.png
