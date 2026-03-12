#!/bin/bash

if [ -z "$ROFI_RETV" ]; then
   rofi -show "ap" -modes "ap:$(readlink -f "$0")"
   exit $?
fi

echo -en "\0prompt\x1fAudio Profile\n"

if [ -n "$1" ]; then
    # echo $ROFI_INFO
    eval $ROFI_INFO
    exit 0
fi

DEFAULT_SINK=$(pactl get-default-sink)


# select default audio sink
pw-dump | jq -r '.[] |
if .info.props."media.class" == "Audio/Sink" then
  .info.props."node.name" as $dname |
  ($dname == "'$DEFAULT_SINK'") as $active |
  (.info.props."node.nick" // .info.props."node.description")
  + "\\0info\\x1fwpctl set-default " + (.id | tostring)
  + "\\x1factive\\x1f" + ($active | tostring)
  + "\\n"
else empty end' | xargs -0 printf "%b"


echo -en " \\0nonselectable\\x1ftrue\\n"
echo -en "Profiles:\\0permanent\\x1ftrue\\x1fnonselectable\\x1ftrue\\n"


# show audio devices and selectable profiles
pw-dump | jq -r '.[] |
if .info.props."media.class" == "Audio/Device" then
  .id as $id |
  .info.props."device.description" + "\\0info\\x1f" + .info.props."device.name" + "\\x1fnonselectable\\x1ftrue\\n",
  .info.params.Profile[].index as $active |
  .info.params.EnumProfile[] |
  if .available == "yes" then (
    (if $active == .index then "* " else "  " end)
    + .description
    + "\\0info\\x1fwpctl set-profile " + ($id | tostring) + " " + (.index | tostring)
    + "\\x1factive\\x1f" + ($active == .index | tostring)
    + "\\n"
  ) else empty end
else empty end' | xargs -0 printf "%b"


# pw-dump | jq -r '.[] |
# if .info.props."media.class" == "Audio/Sink" && (.info.props."node.description" | startswith("Tiger Lake-LP Smart") ) then .
# else empty end'


# # Find audio sinks with "Tiger Lake-LP Smart" in the description
# pw-dump | jq -r '.[] |
#   select(.info.props."media.class" == "Audio/Sink")  '


# pw-dump | jq -r '.[] |
#   select(.info.props."media.class" == "Audio/Sink" and
#          (.info.props."node.description" | startswith("Tiger Lake-LP Smart"))) |
#   del(.info.params)'
