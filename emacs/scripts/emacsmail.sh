#!/bin/sh

emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" | grep t
if [ "$?" = "1" ]; then
    emacsclient -c -n -a "" --eval "(browse-url-mail \"$@\")"
else
    emacsclient -n -a "" --eval "(browse-url-mail \"$@\")"
fi
