#!/bin/bash

if [ -z "$ROFI_RETV" ]; then
   rofi -show "ap" -modi "ap:~/scripts/audio_profile.sh"
   exit $?
fi

echo -en "\0prompt\x1fAudio Profile\n"

if [ -n "$1" ]; then
    pactl set-card-profile $ROFI_INFO
    exit 0
fi

# show audio devices and selectable profiles
pw-dump | jq -r '.[] | if .info.props."media.class" == "Audio/Device" then .info.props."device.name" as $dname | .info.props."device.description" + "\\0info\\x1f" + .info.props."device.name" + "\\x1fnonselectable\\x1ftrue\\n", .info.params.Profile[].index as $active | .info.params.EnumProfile[] | if .available == "yes" then ((if $active == .index then "* " else "  " end) + .description + "\\0info\\x1f" + ($dname + " " + .name) + "\\n" ) else empty end else empty end' | xargs -0 printf "%b"


# show audio devices
# pw-dump | jq -r '.[] | if .info.props."media.class" == "Audio/Device" then  .info.props."device.description" + "\\0info\\x1f" + .info.props."device.name" + "\\n" else empty end' | xargs -0 printf "%b"

# show available profiles for all devices
# pw-dump | jq -r '.[] | if .info.props."media.class" == "Audio/Device" then .info.props."device.name" as $dname | .info.params.Profile[].index as $active | .info.params.EnumProfile[] | if .available == "yes" then (.description + "\\0info\\x1f" + ($dname + " " + .name) + "\\n" ) else empty end else empty end' | xargs -0 printf "%b"


# show available profiles for the selected device
# pw-dump | jq -r '.[] | if .info.props."device.name" == "'"$ROFI_INFO"'" then .info.params.EnumProfile[] | if .available == "yes" then (.description + "\\0info\\x1f" + .name + "\\n") else empty end else empty end' | xargs -0 printf "%b"
