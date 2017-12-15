#!/bin/bash

LAYOUTS=( $(localectl list-x11-keymap-layouts | awk '{print $1}') )
# LAYOUTS=( de,en)

NUM_LAYOUTS=${#LAYOUTS[@]}

TILES=()
COMMANDS=()

declare -i index=0


TILES[$index]="NOP"
COMMANDS[$index]=""
index+=1

for layout in $(seq 0 $((${NUM_LAYOUTS}-1)))
do
    VARIANTS=( $(localectl list-x11-keymap-variants ${LAYOUTS[$layout]}) )
    NUM_VARIANTS=${#VARIANTS[@]}
    for variant in $(seq 0 $((${NUM_VARIANTS}-1)))
    do
        TILES[$index]="${index} ${LAYOUTS[$layout]}-${VARIANTS[$variant]}"
        COMMANDS[$index]="setxkbmap ${LAYOUTS[$layout]} ${VARIANTS[$variant]}"
        index+=1
    done
done

function gen_entries()
{
    for a in $(seq 0 $(( ${#TILES[@]} -1)))
    do
        echo ${TILES[a]}
    done
}

# Call menu
SEL=$( gen_entries | rofi -dmenu -p "Keyboard Layout:" -a 0 -no-custom  | awk '{print $1}' )

echo $SEL

echo ${COMMANDS[$SEL]}

# Call setxkbmap
$( ${COMMANDS[$SEL]} )
