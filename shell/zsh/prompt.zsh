# Prompt configuration with git integration

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# Setup prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{002}%n%f@%F{002}%m%f | %F{004}${PWD/#$HOME/~}%f ${vcs_info_msg_0_} >%{$reset_color%} '

# Format the git branch name in the prompt
zstyle ':vcs_info:git:*' formats '(%F{005}%b%f)'

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true

# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' ✗'
zstyle ':vcs_info:*' stagedstr ' ✓'

# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%F{005}%b%u%c%f)'
zstyle ':vcs_info:git:*' actionformats '(%F{005}%b|%a%u%c%f)'
