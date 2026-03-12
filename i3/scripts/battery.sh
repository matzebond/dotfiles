#!/usr/bin/sh
# SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="1[0-9]|20|[0-9]", RUN+="/usr/bin/systemd-run --machine=maschm@.host --user /home/maschm/scripts/battery.sh"
# in /etc/udev/rules.d/99-lowbat.rules

exec 1>> /tmp/battery-events.`whoami`.txt

BAT=`cat /sys/class/power_supply/BAT0/capacity`

echo `date`
echo $BAT
echo $DBUS_SESSION_BUS_ADDRESS
echo $XAUTHORITY
echo $DISPLAY

notify-send -u critical "Low battery ($BAT)" -e
