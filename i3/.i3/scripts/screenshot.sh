#!/bin/bash

maim -s --format=png /dev/stdout | xclip -selection clipboard -target image/png -i
