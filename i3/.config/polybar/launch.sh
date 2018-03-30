# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
DISPLAY1="$(xrandr -q | grep " connected" | grep 'eDP1\|HDMI-0' | cut -d ' ' -f1)"
[[ ! -z "$DISPLAY1" ]] && MONITOR=$DISPLAY1 polybar main &

DISPLAY2="$(xrandr -q | grep 'DVI-I-2\|VGA0' | cut -d ' ' -f1)"
[[ ! -z $DISPLAY2 ]] && MONITOR=$DISPLAY2 polybar main &

echo "Bars launched..."
