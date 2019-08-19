#!/bin/sh

grim /tmp/screenshot.png
# convert /tmp/screenshot.png -blur 0x5 /tmp/screenshot.png
# convert -scale 10% -blur 0x1 -resize 1000% /tmp/screenshot.png /tmp/screenshot.png
convert in.png -scale 2.5% -resize 4000% /tmp/screenshot.png /tmp/screenshot.png
swaylock -efFk -i /tmp/screenshot.png
