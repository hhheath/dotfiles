# Start Tmux
# if [ "$TMUX" = "" ]; then tmux new -s default; fi

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

# PATHs 
export PATH="$HOME/.cargo/bin:$PATH" # cargo for rust
export PATH="$HOME/.local/:$PATH"
export PATH="/Applications/Alacritty.app/Contents/MacOS:$PATH" # this enables you to use alacritty commands, like to mirgate from yml to toml

# aliases
alias git-pub="git config --local user.name hhheath && git config --local user.email heath@steppe.sh"
alias python="python3"
alias virtual="python -m venv .venv"
alias activate="source .venv/bin/activate"
alias ll='ls -al'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias ol='ollama run llama3.2' # requires ollama - https://github.com/ollama/ollama
alias v='nvim'
alias dlaudio='f() { yt-dlp -x --audio-format opus $1. };f'
alias tm='tmux'
alias tmn='f() { tmux new-session -A -s $1. };f'
alias daily="v ~/Documents/personal-notes/daily.md"
alias todos="v ~/Documents/personal-notes/todos.md"
alias cat="bat" # requires `brew install bat`
alias gcam="git commit -a -m"
alias gst="git status"
alias ggpush="git push origin $(git rev-parse --abbrev-ref HEAD)"
alias wt="nvim ~/.config/wezterm/wezterm.lua"

# pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# node version manager (nvm) stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
