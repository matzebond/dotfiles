#!/bin/bash

if [ -z "$ROFI_RETV" ]; then
   rofi -show "xkb" -modes "xkb:$(readlink -f "$0")" -sort -sorting-method fzf
   exit $?
fi

echo -en "\0prompt\x1fKeyboard Layout\n"

# Handle selection
if [ -n "$1" ]; then
    eval "$ROFI_INFO"
    exit 0
fi

# Get current layout and variant
current_layout=$(setxkbmap -query | grep layout | awk '{print $2}')
current_variant=$(setxkbmap -query | grep variant | awk '{print $2}')
[ -z "$current_variant" ] && current_variant="default"

# Define favorites
favorites=("de - neo" "de - default")

# Check if current layout is among favorites
current_is_favorite=false
current_display="$current_layout - $current_variant"

for fav in "${favorites[@]}"; do
    if [ "$fav" = "$current_display" ]; then
        current_is_favorite=true
        break
    fi
done

# Display non-active favorites first
for fav in "${favorites[@]}"; do
    layout=${fav% - *}
    variant=${fav#* - }

    is_active=false
    if [ "$layout" = "$current_layout" ] && [[ ("$variant" = "default" && "$current_variant" = "default") || ("$variant" = "$current_variant") ]]; then
        is_active=true
        current_is_favorite=true
    fi

    if [ "$is_active" = "false" ]; then
        if [ "$variant" = "default" ]; then
            echo -en "$fav\0info\x1fsetxkbmap $layout\x1factive\x1f$is_active\n"
        else
            echo -en "$fav\0info\x1fsetxkbmap $layout $variant\x1factive\x1f$is_active\n"
        fi
    fi
done

# If current is not a favorite, add it to shortcuts
if [ "$current_is_favorite" = "false" ]; then
    if [ "$current_variant" = "default" ]; then
        echo -en "$current_layout - default\0info\x1fsetxkbmap $current_layout\x1factive\x1ftrue\n"
    else
        echo -en "$current_layout - $current_variant\0info\x1fsetxkbmap $current_layout $current_variant\x1factive\x1ftrue\n"
    fi
fi

# Display active favorites
for fav in "${favorites[@]}"; do
    layout=${fav% - *}
    variant=${fav#* - }

    is_active=false
    if [ "$layout" = "$current_layout" ] && [[ ("$variant" = "default" && "$current_variant" = "default") || ("$variant" = "$current_variant") ]]; then
        is_active=true
    fi

    if [ "$is_active" = "true" ]; then
        if [ "$variant" = "default" ]; then
            echo -en "$fav\0info\x1fsetxkbmap $layout\x1factive\x1f$is_active\n"
        else
            echo -en "$fav\0info\x1fsetxkbmap $layout $variant\x1factive\x1f$is_active\n"
        fi
    fi
done

# Display all layout-variant combinations
localectl list-x11-keymap-layouts | while read layout; do
    # Display layout with no variant
    is_active=false
    if [ "$layout" = "$current_layout" ] && [ "$current_variant" = "default" ]; then
        is_active=true
    fi
    echo -en "$layout - default\0info\x1fsetxkbmap $layout\x1factive\x1f$is_active\n"

    localectl list-x11-keymap-variants "$layout" | while read variant; do
        is_active=false
        if [ "$layout" = "$current_layout" ] && [ "$variant" = "$current_variant" ]; then
            is_active=true
        fi
        echo -en "$layout - $variant\0info\x1fsetxkbmap $layout $variant\x1factive\x1f$is_active\n"
    done
done
