#!/bin/sh

function join_by { local IFS="$1"; shift; echo "$*"; }


shopt -s lastpipe

vpns=$(nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep vpn | cut -d ':' -f 1 | paste -sd "," -)

# ( nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep vpn | cut -d ':' -f 1 ) | readarray vpns
# vpns=("dus" "kef")
# bar=$(IFS=, ; echo "${vpns[*]}")
# echo $bar

if [ -n "$vpns" ]; then
    echo $vpns
else
	echo "no VPN"
    false
fi
