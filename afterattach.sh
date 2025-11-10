#!/usr/bin/env bash

tmux send-keys -t $TMUX_SESSION:recon.0 "tcpscan" Enter
tmux send-keys -t $TMUX_SESSION:recon.1 "udpscan" Enter
