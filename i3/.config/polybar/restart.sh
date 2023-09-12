#!/usr/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
# RACE CONDITION
# while pgrep -x polybar >/dev/null; do sleep 1; done

sleep 1

./launch.sh
