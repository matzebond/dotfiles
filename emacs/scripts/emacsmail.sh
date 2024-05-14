#!/bin/sh

emacsclient -r -n --eval "(progn (x-focus-frame nil)(browse-url-mail \"$@\"))"
