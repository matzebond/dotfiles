#!/usr/bin/env bash

if [ -z "$ROFI_RETV" ]; then
   rofi -show "bt" -modes "bt:$(readlink -f "$0")" -sort -sorting-method fzf
   exit $?
fi

echo -en "\0prompt\x1fBluetooth\n"

# Handle selection
if [ -n "$1" ]; then
    eval "$ROFI_INFO"
    exit 0
fi

# Check if bluetooth is powered on
if ! bluetoothctl show | grep -q "Powered: yes"; then
    echo -en "Power On\0info\x1fsystemctl restart bluetooth.service && rfkill unblock bluetooth\x1factive\x1ffalse\n"
    exit 0
fi

# List devices
bluetoothctl devices | grep "Device" | while read -r _ mac name; do
    # Check if device is connected
    is_active=false
    if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
        is_active=true
        action="bluetoothctl disconnect $mac"
    else
        action="bluetoothctl connect $mac"
    fi

    echo -en "$name\0info\x1f$action\x1factive\x1f$is_active\n"
done

echo -en " \0nonselectable\x1ftrue\n"

# Power control
echo -en "Power off\0info\x1fbluetoothctl power off\x1factive\x1ffalse\n"

# Scan control
if bluetoothctl show | grep -q "Discovering: yes"; then
    echo -en "Stop Scan\0info\x1fbluetoothctl scan off\x1factive\x1ftrue\n"
else
    echo -en "Start Scan\0info\x1fbluetoothctl scan on\x1factive\x1ffalse\n"
fi
