#!/usr/bin/env bash

source ~/.tmux/scripts/setup.sh
export TMUX_SESSION=$MACHINE_NAME # every env in current shell session is loaded into the env of the tmux session
export IP

# Check if session already exists
tmux has-session -t $TMUX_SESSION 2>/dev/null
if [ $? -eq 0 ]; then
    tmux attach -t $TMUX_SESSION
    exit 0
fi

# Create the session and windows first
tmux new-session -d -s $TMUX_SESSION -n vpn
tmux new-window -t $TMUX_SESSION -n recon
tmux new-window -t $TMUX_SESSION -n start
#tmux new-window -t $TMUX_SESSION -n initial
#tmux new-window -t $TMUX_SESSION -n final
#tmux new-window -t $TMUX_SESSION -n extra

# Split fuzz and recon into 2 panes
tmux select-window -t $TMUX_SESSION:recon
tmux split-window -v -t $TMUX_SESSION:recon
#tmux select-window -t $TMUX_SESSION:recon
#tmux split-window -v -t $TMUX_SESSION:recon


# ---- Interactive menu ----
options=("HTB" "THM" "Others")
selected=0

draw_menu() {
    clear
    echo "Select lab type (use ↑ ↓ arrows and Enter):"
    for i in "${!options[@]}"; do
        if [ $i -eq $selected ]; then
            echo -e "> \e[1;32m${options[i]}\e[0m"
        else
            echo "  ${options[i]}"
        fi
    done
}

while true; do
    draw_menu
    read -rsn1 input
    case "$input" in
        $'\x1b') # Arrow keys start with ESC
            read -rsn2 -t 0.1 key
            case "$key" in
                '[A') # Up
                    ((selected--))
                    if [ $selected -lt 0 ]; then selected=$((${#options[@]}-1)); fi
                    ;;
                '[B') # Down
                    ((selected++))
                    if [ $selected -ge ${#options[@]} ]; then selected=0; fi
                    ;;
            esac
            ;;
        '') # Enter
            break
            ;;
    esac
done

# Send command to vpn window based on selection
case "${options[$selected]}" in
    "HTB")
    # this will only work if you have an alias of htb e.g. htb=openvpn something.ovpn
    # and also normally it needs sudo privileges so it will prompt for password in place of connecting
    # but if it has cap_net_admin+ep (capability) it can connect without having root access.
        tmux send-keys -t $TMUX_SESSION:vpn "htb" Enter	
	;;
    "THM")
        tmux send-keys -t $TMUX_SESSION:vpn "thm" Enter
        ;;
    "Others")
        # do nothing
        ;;
esac

# tmux send-keys -t $TMUX_SESSION:recon.0 "tcpscan" Enter
# tmux send-keys -t $TMUX_SESSION:recon.1 "udpscan" Enter

# Attach to session
tmux attach -t $TMUX_SESSION:start
