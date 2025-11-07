# Completion configuration

# Enable completions
autoload -Uz compinit && compinit

# Case-insensitive completion (big letters match small letters and vice versa)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
