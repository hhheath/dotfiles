#!/usr/bin/env bash

# Dotfiles installation script
# Supports macOS and Ubuntu/Debian-based Linux

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$ID
        else
            OS="linux"
        fi
    else
        OS="unknown"
    fi
    log_info "Detected OS: $OS"
}

# Backup existing files
backup_file() {
    local file=$1
    local backup_dir="$HOME/.dotfiles_backup"

    if [ -f "$file" ] || [ -d "$file" ]; then
        mkdir -p "$backup_dir"
        local filename=$(basename "$file")
        local timestamp=$(date +%Y%m%d_%H%M%S)
        local backup_path="$backup_dir/${filename}.${timestamp}.bak"

        log_warn "Backing up existing $file to $backup_path"
        mv "$file" "$backup_path"
    fi
}

# Install Homebrew (macOS)
install_homebrew() {
    if ! command -v brew &> /dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        log_success "Homebrew installed"
    else
        log_info "Homebrew already installed"
    fi
}

# Install packages on macOS
install_macos_packages() {
    log_info "Installing packages via Homebrew..."

    # Update Homebrew
    brew update

    # Install from Brewfile if it exists
    if [ -f "$DOTFILES_DIR/Brewfile" ]; then
        log_info "Installing from Brewfile..."
        brew bundle install --file="$DOTFILES_DIR/Brewfile"
    else
        # Fallback: install essential packages
        log_info "Installing essential packages..."
        brew install git zsh tmux neovim fzf ripgrep fd tree jq gh pyenv
    fi

    log_success "macOS packages installed"
}

# Install packages on Ubuntu/Debian
install_ubuntu_packages() {
    log_info "Installing packages via apt..."

    sudo apt update
    sudo apt install -y \
        git \
        zsh \
        curl \
        wget \
        tmux \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        sqlite3 \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libxml2-dev \
        libxmlsec1-dev \
        libffi-dev \
        liblzma-dev \
        python3-pip \
        jq \
        tree \
        ripgrep \
        fd-find

    # Install Neovim (latest stable)
    log_info "Installing Neovim..."
    if ! command -v nvim &> /dev/null; then
        wget https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz
        sudo tar xzf nvim-linux-x86_64.tar.gz -C /opt
        sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
        rm nvim-linux-x86_64.tar.gz
    fi

    # Install fzf
    if ! command -v fzf &> /dev/null; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
    fi

    log_success "Ubuntu packages installed"
}

# Install pyenv
install_pyenv() {
    if [ ! -d "$HOME/.pyenv" ]; then
        log_info "Installing pyenv..."
        curl https://pyenv.run | bash
        log_success "pyenv installed"
    else
        log_info "pyenv already installed"
    fi
}

# Install nvm
install_nvm() {
    if [ ! -d "$HOME/.nvm" ]; then
        log_info "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        log_success "nvm installed"
    else
        log_info "nvm already installed"
    fi
}

# Install Claude orchestration (optional)
install_claude_orchestration() {
    if [ -d "$DOTFILES_DIR/claude" ]; then
        log_info "Installing Claude orchestration tool..."

        # Check if Claude Code is installed
        if ! command -v claude-code &> /dev/null; then
            log_warn "Claude Code CLI not found."
            log_warn "Install with: npm install -g @anthropic-ai/claude-code"
            log_warn "Then run: claude-code auth"
        fi

        # Install Python dependencies for TUI (optional)
        if command -v pip3 &> /dev/null; then
            log_info "Installing Python TUI dependencies..."
            if [ -f "$DOTFILES_DIR/claude/requirements.txt" ]; then
                pip3 install -r "$DOTFILES_DIR/claude/requirements.txt" --break-system-packages 2>/dev/null || \
                pip3 install -r "$DOTFILES_DIR/claude/requirements.txt" 2>/dev/null || \
                log_warn "Could not install Python dependencies (non-critical)"
            fi
        fi

        # Run the orchestration installer
        if [ -f "$DOTFILES_DIR/claude/install.sh" ]; then
            log_info "Running Claude orchestration installer..."
            cd "$DOTFILES_DIR/claude" && bash install.sh && cd "$DOTFILES_DIR"
            log_success "Claude orchestration installed"
        else
            log_warn "Claude orchestration install.sh not found, skipping..."
        fi
    else
        log_info "Claude orchestration submodule not found, skipping..."
        log_info "To add it later: cd ~/.dotfiles && git submodule update --init --recursive"
    fi
}

# Set zsh as default shell
set_zsh_default() {
    if [ "$SHELL" != "$(which zsh)" ]; then
        log_info "Setting zsh as default shell..."
        chsh -s "$(which zsh)"
        log_success "Default shell changed to zsh (restart terminal to apply)"
    else
        log_info "zsh is already the default shell"
    fi
}

# Copy configuration files
copy_configs() {
    log_info "Copying configuration files..."

    # Ensure .config directory exists first
    mkdir -p "$HOME/.config"

    # Create necessary directories
    mkdir -p "$HOME/.config/ghostty"
    mkdir -p "$HOME/.config/aerospace"
    mkdir -p "$HOME/.config/shell/zsh"

    # Backup and copy .zshrc
    backup_file "$HOME/.zshrc"
    cp "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    log_success "Copied .zshrc"

    # Copy modular zsh configs
    if [ -d "$DOTFILES_DIR/shell/zsh" ]; then
        cp -r "$DOTFILES_DIR/shell/zsh/"* "$HOME/.config/shell/zsh/"
        if [ $? -eq 0 ]; then
            log_success "Copied zsh modules"
        else
            log_error "Failed to copy zsh modules from $DOTFILES_DIR/shell/zsh/"
            exit 1
        fi
    else
        log_error "Zsh modules directory not found at $DOTFILES_DIR/shell/zsh/"
        exit 1
    fi

    # Backup and copy .tmux.conf
    backup_file "$HOME/.tmux.conf"
    cp "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
    log_success "Copied .tmux.conf"

    # Copy ghostty config
    if [ -f "$DOTFILES_DIR/config/ghostty/config" ]; then
        backup_file "$HOME/.config/ghostty/config"
        cp "$DOTFILES_DIR/config/ghostty/config" "$HOME/.config/ghostty/config"
        log_success "Copied ghostty config"
    fi

    # Copy aerospace config (macOS only)
    if [ "$OS" == "macos" ] && [ -f "$DOTFILES_DIR/config/aerospace/aerospace.toml" ]; then
        backup_file "$HOME/.config/aerospace/aerospace.toml"
        cp "$DOTFILES_DIR/config/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"
        log_success "Copied aerospace config"
    fi

    # Copy .gitconfig if user hasn't configured it
    if [ ! -f "$HOME/.gitconfig" ]; then
        cp "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
        log_warn "Copied .gitconfig template - PLEASE UPDATE with your name and email!"
    else
        log_info ".gitconfig already exists, skipping..."
    fi

    # Initialize nvim submodule if needed
    if [ ! -f "$DOTFILES_DIR/nvim/init.lua" ]; then
        log_info "Initializing nvim submodule..."
        git submodule update --init --recursive
    fi

    # Link nvim config
    if [ ! -d "$HOME/.config/nvim" ] || [ -L "$HOME/.config/nvim" ]; then
        backup_file "$HOME/.config/nvim"
        ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
        log_success "Linked nvim config"
    else
        log_warn "nvim config already exists and is not a symlink, skipping..."
    fi
}

# Main installation flow
main() {
    log_info "Starting dotfiles installation..."

    # Get the directory where this script is located
    DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    log_info "Dotfiles directory: $DOTFILES_DIR"

    # Detect OS
    detect_os

    # Install packages based on OS
    case "$OS" in
        macos)
            install_homebrew
            install_macos_packages
            ;;
        ubuntu|debian)
            install_ubuntu_packages
            ;;
        *)
            log_error "Unsupported OS: $OS"
            log_info "You'll need to manually install: git, zsh, tmux, neovim, fzf, ripgrep"
            ;;
    esac

    # Install version managers
    install_pyenv
    install_nvm

    # Install Claude orchestration (optional)
    install_claude_orchestration

    # Copy configuration files
    copy_configs

    # Set zsh as default shell
    set_zsh_default

    log_success "Installation complete!"
    log_info ""
    log_info "Next steps:"
    log_info "1. Restart your terminal or run: source ~/.zshrc"
    log_info "2. Edit ~/.gitconfig with your name and email"
    log_info "3. Launch nvim to install plugins (they'll install automatically)"
    log_info "4. Install a Python version with: pyenv install 3.12.0 && pyenv global 3.12.0"
    log_info "5. Install Node with: nvm install --lts && nvm use --lts"
    log_info ""
    if [ -d "$DOTFILES_DIR/claude" ]; then
        log_info "Claude Orchestration installed! Quick start:"
        log_info "  - Create project: claude-new my-project"
        log_info "  - View status: claude-status"
        log_info "  - See docs: cat ~/.dotfiles/claude/START_HERE.md"
        log_info ""
    fi
    log_warn "Backups of existing configs saved to: ~/.dotfiles_backup/"
}

# Run main installation
main
