#!/usr/bin/bash

if [ -z "$ROFI_RETV" ]; then
    rofi -l 5 -show "i3-msg" -modi "i3-msg:~/scripts/i3-rofi-input.sh"
    exit $?
fi

if [ -n "$1" ]; then
    i3-msg "$1" >/dev/null
    exit 0
fi

for what in workspace container; do
    for dir in left right down up current primary next; do
        echo move $what to output $dir
    done
done

echo move position center
echo move scratchpad
echo floating toggle
