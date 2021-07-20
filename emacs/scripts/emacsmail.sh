#!/bin/sh

emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" | grep t
if [ "$?" = "1" ]; then
    emacsclient -c -n --eval "(progn (x-focus-frame nil)(browse-url-mail \"$@\"))"
else
    emacsclient -n --eval "(progn (x-focus-frame nil)(browse-url-mail \"$@\"))"
fi
