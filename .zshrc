# Start Tmux
# if [ "$TMUX" = "" ]; then tmux new -s default; fi

# color ls output
export CLICOLOR=1

setopt autocd
# setopt auto_cd

# turn on completions and then make sure to tell zsh that big letters match small letters and small letters match big letters
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

#====================== Prompt ====================================================================
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# setup prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{002}%n%f@%F{002}%m%f | %F{004}${PWD/#$HOME/~}%f ${vcs_info_msg_0_} >%{$reset_color%} '

# format the git branch name in the prompt
zstyle ':vcs_info:git:*' formats '(%F{005}%b%f)'
# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' ✗'
zstyle ':vcs_info:*' stagedstr ' ✓'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%F{005}%b%u%c%f)'
zstyle ':vcs_info:git:*' actionformats '(%F{005}%b|%a%u%c%f)'
#===================== Prompt =====================================================================

#===================== Functions ==================================================================

# ggpush because i like that command from omz
ggpush() {
  git push origin $(git rev-parse --abbrev-ref HEAD)
}

# gcam because i like that command from omz
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

# gst because i like that command from omz
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

#===================== Functions ==================================================================

# PATHs 
export PATH="$HOME/.cargo/bin:$PATH" # cargo for rust
export PATH="$HOME/.local/:$PATH"
export PATH="/Applications/Alacritty.app/Contents/MacOS:$PATH" # this enables you to use alacritty commands, like to mirgate from yml to toml

# aliases
alias python="python3"
alias virtual="python -m venv .venv"
alias activate="source .venv/bin/activate"
alias ll='ls -al'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias ol='ollama run llama3.2'
alias v='nvim'
alias dlaudio='f() { yt-dlp -x --audio-format opus $1. };f'
alias tm='tmux'
alias tmn='f() { tmux new-session -A -s $1. };f'
alias daily="v ~/Documents/personal-notes/daily.md"
alias todos="v ~/Documents/personal-notes/todos.md"
alias cat="bat"
alias wt="nvim ~/.config/wezterm/wezterm.lua"

# pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# node version manager (nvm) stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
