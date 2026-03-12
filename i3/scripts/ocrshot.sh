#!/bin/bash

CONFIG_FILE="$HOME/.config/ocr_language"
DEFAULT_LANG="eng+deu"

# Load saved language preference
if [ -f "$CONFIG_FILE" ]; then
    SAVED_LANG=$(cat "$CONFIG_FILE")
else
    SAVED_LANG="$DEFAULT_LANG"
fi

# Handle rofi mode
if [ -z "$ROFI_RETV" ]; then
    if [ "$1" = "menu" ]; then
        rofi -show "ocr" -modes "ocr:$(readlink -f "$0")"
        exit $?
    elif [ -n "$1" ]; then
        # Use provided language without saving
        maim --select --hidecursor --format=png /dev/stdout 2>/dev/null | \
        tesseract --psm 6 - - -l "$1" --tessdata-dir /usr/share/tessdata/ | \
        tee | xclip -in -selection clipboard -rmlastnl
        exit $?
    else
        # Use saved/default language
        maim --select --hidecursor --format=png /dev/stdout 2>/dev/null | \
        tesseract --psm 6 - - -l "$SAVED_LANG" --tessdata-dir /usr/share/tessdata/ | \
        tee | xclip -in -selection clipboard -rmlastnl
        exit $?
    fi
fi

# Rofi menu mode
echo -en "\0prompt\x1fOCR Language\n"

if [ -n "$1" ]; then
    # Save selected language and run OCR
    echo "$ROFI_INFO" > "$CONFIG_FILE"
    maim --select --hidecursor --format=png /dev/stdout 2>/dev/null | \
    tesseract --psm 6 - - -l "$ROFI_INFO" --tessdata-dir /usr/share/tessdata/ | \
    tee | xclip -in -selection clipboard -rmlastnl
    exit 0
fi

# Get available languages from tesseract, excluding osd and equ
AVAILABLE_LANGS=$(tesseract --list-langs 2>&1 | grep -v "List of available" | grep -v "^$" | grep -v "osd" | grep -v "equ")

# Add common combinations first
echo -en "English + German\0info\x1feng+deu\x1factive\x1f$([ "eng+deu" = "$SAVED_LANG" ] && echo "true" || echo "false")\n"
echo -en "English + German + Ukrainian\0info\x1feng+deu+ukr\x1factive\x1f$([ "eng+deu+ukr" = "$SAVED_LANG" ] && echo "true" || echo "false")\n"

# Add individual languages
for lang in $AVAILABLE_LANGS; do
    # Convert language code to readable name
    case $lang in
        chi_sim) desc="Chinese Simplified" ;;
        deu) desc="German" ;;
        eng) desc="English" ;;
        kor) desc="Korean" ;;
        ukr) desc="Ukrainian" ;;
        *) desc="$lang" ;;
    esac
    
    active="false"
    if [ "$lang" = "$SAVED_LANG" ]; then
        active="true"
    fi
    
    echo -en "$desc\0info\x1f$lang\x1factive\x1f$active\n"
done
