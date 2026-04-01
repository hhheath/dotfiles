#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info() { echo "[*] $1"; }
warn() { echo "[!] $1"; }

command_exists() { command -v "$1" &>/dev/null; }

backup_and_copy() {
    local src="$1" dest="$2"
    if [ -f "$dest" ] || [ -d "$dest" ]; then
        mkdir -p "$HOME/.dotfiles_backup"
        mv "$dest" "$HOME/.dotfiles_backup/$(basename "$dest").$(date +%s).bak"
    fi
    cp "$src" "$dest"
}

# --- macOS ---

install_macos() {
    if ! command_exists brew; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    brew update
    brew bundle install --file="$DOTFILES_DIR/Brewfile"
}

# --- Linux ---

install_linux() {
    sudo apt update
    sudo apt install -y \
        git zsh curl wget tmux \
        build-essential cmake ninja-build gettext \
        jq tree ripgrep fd-find bat \
        pyenv python3-pip

    install_neovim_from_source
}

install_neovim_from_source() {
    if command_exists nvim; then
        info "Neovim already installed: $(nvim --version | head -1)"
        return
    fi

    info "Building Neovim from source..."
    git clone https://github.com/neovim/neovim.git /tmp/neovim-build
    cd /tmp/neovim-build
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    cd "$DOTFILES_DIR"
    rm -rf /tmp/neovim-build
    info "Neovim installed: $(nvim --version | head -1)"
}

# --- Shared ---

install_nvm_and_node() {
    if [ ! -d "$HOME/.nvm" ]; then
        info "Installing nvm..."
        curl -so- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    fi

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    if ! command_exists node; then
        info "Installing Node LTS..."
        nvm install --lts
    fi
}

install_claude_code() {
    if command_exists claude; then
        info "Claude Code already installed: $(claude --version 2>/dev/null)"
        return
    fi

    info "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | sh
}

copy_configs() {
    mkdir -p "$HOME/.config/ghostty" "$HOME/.config/aerospace"

    backup_and_copy "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    backup_and_copy "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

    if [ ! -f "$HOME/.gitconfig" ]; then
        cp "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
        warn "Copied .gitconfig template — update your name and email!"
    fi

    [ -f "$DOTFILES_DIR/config/ghostty/config" ] && \
        backup_and_copy "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
    [ -f "$DOTFILES_DIR/config/aerospace/aerospace.toml" ] && \
        backup_and_copy "$DOTFILES_DIR/config/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"

    # nvim config (symlink so updates come from repo)
    cd "$DOTFILES_DIR"
    git submodule update --init --recursive
    if [ ! -d "$HOME/.config/nvim" ] || [ -L "$HOME/.config/nvim" ]; then
        rm -f "$HOME/.config/nvim"
        ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
    else
        warn "~/.config/nvim exists and isn't a symlink, skipping"
    fi
}

set_default_shell() {
    if [ "$SHELL" != "$(which zsh)" ]; then
        info "Setting zsh as default shell..."
        chsh -s "$(which zsh)"
    fi
}

# --- Main ---

main() {
    info "Installing dotfiles from $DOTFILES_DIR"

    case "$OSTYPE" in
        darwin*)  install_macos ;;
        linux*)   install_linux ;;
        *)        warn "Unknown OS — skipping package install" ;;
    esac

    install_nvm_and_node
    copy_configs
    set_default_shell
    install_claude_code

    echo ""
    echo "Done! Next steps:"
    echo "  1. Restart your terminal (or: source ~/.zshrc)"
    echo "  2. Update ~/.gitconfig with your name/email"
    echo "  3. Open nvim to auto-install plugins"
    echo "  4. pyenv install 3.12 && pyenv global 3.12"
}

main
