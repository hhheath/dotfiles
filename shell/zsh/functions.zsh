# Custom shell functions

# ggpush - Push current branch to origin (from oh-my-zsh)
ggpush() {
  git push origin $(git rev-parse --abbrev-ref HEAD)
}

# gcam - Git commit all with message (from oh-my-zsh)
gcam() {
  if [ $# -eq 0 ]; then
    # If no commit message is provided, prompt the user for one
    echo "Please enter a commit message:"
    read -r -p "> " msg
    git commit -a -m "$msg"
  else
    # If a commit message is provided, use it
    local msg=$1
    shift
    git commit -a -m "$msg"
  fi
}

# gst - Git status or switch branch (from oh-my-zsh)
gst() {
  if [ $# -gt 0 ]; then
    # If an argument is provided, assume it's a branch name and switch to that branch
    local branch=$1
    git checkout $branch
  else
    # If no arguments are provided, just show the current status
    git status
  fi
}

# tmux_first_session - Connect to first tmux session or create new one
tmux_first_session() {
    # Get the list of existing Tmux sessions, excluding any empty lines
    local sessions=$(tmux ls 2>/dev/null | awk -F: '{print $1}' | sed '/^$/d')

    if [[ -z "$sessions" ]]; then
        echo "No tmux sessions found. Creating a new session..."
        # Create a new Tmux session with a default name (e.g., 'default') and attach to it
        tmux new-session -s default || {
            echo "Failed to create a new Tmux session."
            return 1
        }
    else
        # Get the first session from the list
        local first_session=$(echo "$sessions" | head -n 1)

        # Attach to the first session
        tmux attach-session -t "$first_session"
    fi
}
