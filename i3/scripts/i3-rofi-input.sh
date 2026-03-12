#!/usr/bin/bash

# rofi preamble
if [ -z "$ROFI_RETV" ]; then
    rofi -l 5 -show "i3-msg" -modi "i3-msg:~/scripts/i3-rofi-input.sh"
    exit $?
fi

# how to call selected item
if [ -n "$1" ]; then
    i3-msg "$1" >/dev/null
    exit 0
fi

echo kill

# move {workspace|container} to output {{directon}|{type}|{monitor}}
for what in workspace container; do
    for dir in left right down up current primary next; do
        echo move $what to output $dir
    done

    for monitor in $(i3-msg -t get_outputs | jq -r '.[] | select(.active == true) | .name'); do
        echo move $what to output "$monitor"
    done
done

echo move position center
echo move scratchpad
echo floating toggle
echo scratchpad show

# focus on marks
for element in $(i3-msg -t get_marks | jq -r '.[]'); do
    echo "[con_mark=\"${element}\"] focus"
done

echo focus mode_toggle
echo focus parent
echo focus child
echo focus primary
echo focus nonprimary

echo mark \$1

for element in $(i3-msg -t get_marks | jq -r '.[]'); do
    echo unmark "${element}"
done
