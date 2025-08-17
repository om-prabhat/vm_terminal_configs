#!/bin/bash

SESSION="lab"

# Check if session already exists
tmux has-session -t $SESSION 2>/dev/null
if [ $? -eq 0 ]; then
    tmux attach -t $SESSION
    exit 0
fi

# Create the session and windows first
tmux new-session -d -s $SESSION -n vpn
tmux new-window -t $SESSION -n recon
tmux new-window -t $SESSION -n fuzz
tmux new-window -t $SESSION -n initial
tmux new-window -t $SESSION -n final
tmux new-window -t $SESSION -n extra

# Split fuzz and recon into 2 panes
tmux select-window -t $SESSION:fuzz
tmux split-window -v -t $SESSION:fuzz
tmux select-window -t $SESSION:recon
tmux split-window -v -t $SESSION:recon


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
        tmux send-keys -t $SESSION:vpn "htb" Enter
        ;;
    "THM")
        tmux send-keys -t $SESSION:vpn "thm" Enter
        ;;
    "Others")
        # do nothing
        ;;
esac

# Attach to session
tmux attach -t $SESSION:recon.0
