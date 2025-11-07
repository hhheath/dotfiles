# ~/.zshrc
# Main zsh configuration file
# Modular configuration files are sourced from ~/.config/shell/zsh/

# Get the directory where this .zshrc file is located
DOTFILES_DIR="${${(%):-%N}:A:h}"

# Source modular configuration files
# Note: If dotfiles are copied to ~/, use ~/.config/shell/zsh/
# If running from dotfiles repo, use relative paths
if [[ -f "$HOME/.config/shell/zsh/env.zsh" ]]; then
  ZSH_CONFIG_DIR="$HOME/.config/shell/zsh"
else
  ZSH_CONFIG_DIR="$DOTFILES_DIR/shell/zsh"
fi

source "$ZSH_CONFIG_DIR/env.zsh"
source "$ZSH_CONFIG_DIR/path.zsh"
source "$ZSH_CONFIG_DIR/completion.zsh"
source "$ZSH_CONFIG_DIR/prompt.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"

# Load pyenv if available
if [[ -f "$ZSH_CONFIG_DIR/pyenv.zsh" ]]; then
  source "$ZSH_CONFIG_DIR/pyenv.zsh"
fi

# Load nvm if available
if [[ -f "$ZSH_CONFIG_DIR/nvm.zsh" ]]; then
  source "$ZSH_CONFIG_DIR/nvm.zsh"
fi

# Optional: Auto-start tmux (currently commented out)
# if [ "$TMUX" = "" ]; then tmux new -s default; fi
