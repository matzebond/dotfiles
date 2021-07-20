#!/bin/bash

maim --select --hidecursor --format=png /dev/stdout | xclip -selection clipboard -target image/png -i
