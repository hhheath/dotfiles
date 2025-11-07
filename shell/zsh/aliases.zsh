# Shell aliases

# Python
alias python="python3"
alias virtual="python -m venv .venv"
alias activate="source .venv/bin/activate"

# System
alias ll='ls -al'

# Applications
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias ol='ollama run llama3.2'
alias v='nvim'
alias btop="bpytop"

# Media
alias dlaudio='f() { yt-dlp -x --audio-format opus $1. };f'

# Quick edits
alias daily="v ~/Documents/personal-notes/daily.md"
alias todos="v ~/Documents/personal-notes/todos.md"
alias gt="nvim ~/.config/ghostty/config"

# Tmux
alias tm="tmux_first_session"
