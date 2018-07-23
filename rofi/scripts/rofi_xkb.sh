#!/bin/bash

set -e

SEL_LAYOUT=$( cat <(echo EXIT) <(localectl list-x11-keymap-layouts) | rofi -dmenu -p "Keyboard Layout:" -no-custom -a 0)

if [ $SEL_LAYOUT == "EXIT" ]
then
   exit 1
fi

SEL_VARIANT=$( cat <(echo EXIT) <(echo NO_VARIANT) <(localectl list-x11-keymap-variants ${SEL_LAYOUT}) | rofi -dmenu -p "Keyboard Variant for $SEL_LAYOUT:" -no-custom -a 1)

if [ $SEL_VARIANT == "EXIT" ]
then
    exit 1
fi

echo "setxkbmap "$SEL_LAYOUT" "$SEL_VARIANT""
setxkbmap "$SEL_LAYOUT" ${SEL_VARIANT#NO_VARIANT}
