#!/bin/bash

# maim --select --hidecursor --format=png /dev/stdout 2>/dev/null | tesseract --psm 6 - - -l eng+deu --tessdata-dir /usr/share/tessdata/ | tee | xclip -in -selection clipboard -rmlastnl
maim --select --hidecursor --format=png /dev/stdout 2>/dev/null | tesseract --psm 6 - - -l kor --tessdata-dir /usr/share/tessdata/ | tee | xclip -in -selection clipboard -rmlastnl
# maim --select --hidecursor --format=png /dev/stdout 2>/dev/null | tesseract --psm 6 - - -l chi_sim --tessdata-dir /usr/share/tessdata/ | tee | xclip -in -selection clipboard -rmlastnl
# maim --select --hidecursor --format=png /dev/stdout 2>/dev/null | tesseract --psm 6 - - -l eng+deu+ukr --tessdata-dir /usr/share/tessdata/ | tee | xclip -in -selection clipboard -rmlastnl
