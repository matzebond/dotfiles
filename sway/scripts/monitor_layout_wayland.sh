#!/bin/bash

# adapted from https://github.com/davatorium/rofi-scripts/blob/master/monitor_layout.sh

XRANDR="swaymsg -t get_outputs"

# echo $( swaymsg -t get_outputs | jq )

MONITORS=( $( swaymsg -t get_outputs | jq -r '.[] | select(.active) | .name' ) )
MONITORS_ALL=($( swaymsg -t get_outputs | jq -r '.[] | .name' ) )

NUM_MONITORS=${#MONITORS[@]}
NUM_MONITORS_ALL=${#MONITORS_ALL[@]}

TILES=()
COMMANDS=()


function gen_xrandr_only()
{
    selected=$1

    cmd="wlr-randr --output ${MONITORS_ALL[$selected]} --on --pos 0,0 --preferred"

    for entry in $(seq 0 $((${NUM_MONITORS_ALL}-1)))
    do
        if [ ${MONITORS_ALL[$selected]} != ${MONITORS_ALL[$entry]} ]
        then
            cmd="$cmd --output ${MONITORS_ALL[$entry]} --off"
        fi
    done

    echo $cmd
}


declare -i index=0
TILES[$index]="Cancel"
COMMANDS[$index]="true"
index+=1


for entry in $(seq 0 $((${NUM_MONITORS_ALL}-1)))
do
    TILES[$index]="Only ${MONITORS_ALL[$entry]}"
    COMMANDS[$index]=$(gen_xrandr_only $entry)
    index+=1
done

##
# Dual screen options
##
for entry_a in $(seq 0 $((${NUM_MONITORS_ALL}-1)))
do
    for entry_b in $(seq 0 $((${NUM_MONITORS_ALL}-1)))
    do
        if [ $entry_a != $entry_b ]
        then
            TILES[$index]="Dual Screen ${MONITORS[$entry_a]} -> ${MONITORS[$entry_b]}"
            COMMANDS[$index]="xrandr --output ${MONITORS[$entry_a]} --auto \
                              --output ${MONITORS[$entry_b]} --auto --right-of ${MONITORS[$entry_a]}"

            index+=1
        fi
    done
done


##
# Clone monitors
##
# for entry_a in $(seq 0 $((${NUM_MONITORS}-1)))
# do
#     for entry_b in $(seq 0 $((${NUM_MONITORS}-1)))
#     do
#         if [ $entry_a != $entry_b ]
#         then
#             TILES[$index]="Clone Screen ${MONITORS[$entry_a]} -> ${MONITORS[$entry_b]}"
#             COMMANDS[$index]="xrandr --output ${MONITORS[$entry_a]} --auto \
#                               --output ${MONITORS[$entry_b]} --auto --same-as ${MONITORS[$entry_a]}"

#             index+=1
#         fi
#     done
# done

# custom configs
# TILES[$index]="Home Laptop Dell"
# COMMANDS[$index]=" --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP1 --off --output DP2 --off --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI2 --off --output VIRTUAL1 --off"
# index+=1

##
#  Generate entries, where first is key.
##
function gen_entries()
{
    for a in $(seq 0 $(( ${#TILES[@]} -1 )))
    do
        echo $a ${TILES[a]}
    done

}

# Call menu
SEL=$( gen_entries | rofi -dmenu -i -p "Monitor Setup:" -selected-row 1 -u 0 -no-custom  | awk '{print $1}' )

# Call xrandr
echo ${COMMANDS[$SEL]}
$( ${COMMANDS[$SEL]} )
