#!/bin/sh
format="%s"
dmenu="dmenu -b"
swaymsg="swaymsg"
while [ $# -gt 0 ]
do
    case $1 in
        -s)
            swaymsg="$swaymsg -s '$2'"
            shift
            ;;
        -F)
            format="$2"
            shift
            ;;
        -f)
            dmenu="$dmenu -fn '$2'"
            shift
            ;;
        -P)
            dmenu="$dmenu -p '$2'"
            shift
            ;;
        -l)
            echo "Warning: -l is not supported"
            ;;
        -v)
            exec swaymsg -v
            ;;
        *)
            echo "Unknown argument '$1'" >&2
            exit 1
            ;;
    esac
    shift
done
cmd=$(eval $dmenu < /dev/null)
[ $? -ne 0 ] && exit $?
cmd=$(printf "$format" "$cmd")
eval $swaymsg "$cmd"
exit $?
