swaymsg -t get_tree |
    jq  -r '.nodes[].nodes[] | if .nodes then [recurse(.nodes[])] else []
       end + .floating_nodes | .[] | select(.nodes==[]) | ((.id | tostring)  +
       " " + .name)' |
    wofi --show dmenu --insensitive --prompt "swith to window" | {
    read -r id name
    swaymsg "[con_id=$id]" focus
    }
