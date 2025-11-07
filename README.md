# dotfiles

Personal dotfiles for macOS and Linux (Ubuntu/Debian).

## Features

- **Modular Zsh configuration** - Organized into separate files for easy maintenance
- **Cross-platform support** - Works on both macOS and Ubuntu/Debian Linux
- **Automated installation** - Single script to set up everything
- **Version-controlled Neovim config** - Maintained as a git submodule
- **Consistent theming** - Catppuccin across all tools
- **Development ready** - Pre-configured for Python (pyenv), Node (nvm), and Rust
- **Claude Orchestration** - Optional multi-agent AI development system (git submodule)

## Contents

### Shell
- **zsh** - Modular configuration with custom prompt, aliases, and functions
  - Git-aware prompt with branch and status indicators
  - Custom git commands (ggpush, gcam, gst)
  - Tmux integration
  - Python, Node, and Rust path configuration

### Terminal
- **ghostty** - Primary terminal emulator (IBM Plex Mono, Catppuccin Mocha)
- **tmux** - Terminal multiplexer with vim-style keybindings

### Editor
- **neovim** - Full-featured config with LSP, Treesitter, and Telescope
  - Maintained as separate git submodule at [hhheath/nvim](https://github.com/hhheath/nvim)
  - Lazy.nvim for plugin management
  - Obsidian integration for note-taking

### macOS Specific
- **AeroSpace** - i3-like tiling window manager
- **Homebrew** - Package management via Brewfile

### Git
- **.gitconfig** - Common aliases and sensible defaults (template)

### Claude Orchestration (Optional)
- **Multi-agent AI system** - Coder, Reviewer, Tester, and Coordinator working together
- **Autonomous development** - Runs 24/7 in tmux sessions
- **File-based communication** - Markdown files for task management
- **Terminal UI** - Real-time monitoring with Python TUI
- See `claude/START_HERE.md` for full documentation

## Quick Start

### Installation

1. Clone this repository:
   ```bash
   git clone --recurse-submodules https://github.com/hhheath/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Restart your terminal or source the new configuration:
   ```bash
   source ~/.zshrc
   ```

4. Update `.gitconfig` with your personal information:
   ```bash
   nvim ~/.gitconfig
   # Update name and email fields
   ```

### What the Install Script Does

The `install.sh` script will:
- ✓ Detect your OS (macOS or Linux)
- ✓ Install base packages (git, zsh, curl, tmux, neovim, etc.)
- ✓ Install pyenv with Python build dependencies
- ✓ Install nvm (Node Version Manager)
- ✓ Install development tools (fzf, ripgrep, fd, jq, gh)
- ✓ **macOS**: Install Homebrew and packages from Brewfile
- ✓ **Linux**: Build/install tools from source where needed
- ✓ Set zsh as your default shell
- ✓ Backup existing configs to `~/.dotfiles_backup/`
- ✓ Copy dotfiles to appropriate locations
- ✓ Initialize and link Neovim config

### Post-Installation

1. **Install Python version**:
   ```bash
   pyenv install 3.12.0
   pyenv global 3.12.0
   ```

2. **Install Node version**:
   ```bash
   nvm install --lts
   nvm use --lts
   ```

3. **Launch Neovim** to auto-install plugins:
   ```bash
   nvim
   # Lazy.nvim will automatically install all plugins
   ```

4. **(Optional) Set up Claude Orchestration**:
   ```bash
   # Install Claude Code CLI
   npm install -g @anthropic-ai/claude-code
   claude-code auth

   # Create your first orchestrated project
   claude-new my-project

   # View status
   claude-status
   ```

## Directory Structure

```
dotfiles/
├── config/
│   ├── nvim/              # Neovim config (git submodule)
│   ├── ghostty/
│   │   └── config         # Ghostty terminal config
│   └── aerospace/
│       └── aerospace.toml # AeroSpace window manager (macOS)
├── shell/
│   └── zsh/
│       ├── aliases.zsh    # Shell aliases
│       ├── completion.zsh # Completion setup
│       ├── env.zsh        # Environment variables
│       ├── functions.zsh  # Custom functions
│       ├── nvm.zsh        # NVM initialization
│       ├── path.zsh       # PATH configuration
│       ├── prompt.zsh     # Git-aware prompt
│       └── pyenv.zsh      # Pyenv initialization
├── claude/                # Claude orchestration (git submodule)
│   ├── START_HERE.md      # Getting started guide
│   ├── install.sh         # Orchestration installer
│   ├── scripts/           # CLI tools (new, focus, status, etc.)
│   └── templates/         # Project templates
├── .zshrc                 # Main zsh config (sources modules)
├── .tmux.conf             # Tmux configuration
├── .gitconfig             # Git configuration template
├── Brewfile               # macOS package definitions
├── install.sh             # Installation script
└── README.md              # This file
```

## Configuration Highlights

### Zsh
- **Modular design** - Easy to add/remove functionality
- **Smart completion** - Case-insensitive with automatic suggestions
- **Git integration** - Branch name and status in prompt
- **Custom aliases** - Shortcuts for common tasks

### Tmux
- **Prefix**: `Ctrl+Space` (instead of `Ctrl+B`)
- **Navigation**: `Alt+hjkl` to move between panes
- **Splits**: `\` for horizontal, `-` for vertical
- **Mouse support** enabled

### AeroSpace (macOS)
- **i3-style tiling** - Automatic window management
- **Keyboard-driven** - `Alt+hjkl` for navigation
- **Workspaces** - Support for 1-9 and A-Z

## Manual Installation (Alternative)

If you prefer to manually install without the script:

1. **Install base tools**:
   - macOS: `brew install git zsh tmux neovim fzf ripgrep fd`
   - Ubuntu: `sudo apt install git zsh tmux build-essential`

2. **Install version managers**:
   ```bash
   # pyenv
   curl https://pyenv.run | bash

   # nvm
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
   ```

3. **Copy configs**:
   ```bash
   cp .zshrc ~/.zshrc
   cp -r shell ~/.config/shell
   cp .tmux.conf ~/.tmux.conf
   cp -r config/ghostty ~/.config/ghostty
   cp .gitconfig ~/.gitconfig
   ln -s $(pwd)/nvim ~/.config/nvim
   ```

4. **Set zsh as default shell**:
   ```bash
   chsh -s $(which zsh)
   ```

## Maintenance

### Update Neovim Config

The nvim config is a git submodule, so you can update it independently:

```bash
cd ~/dotfiles/nvim
git pull origin main
cd ~/dotfiles
git add nvim
git commit -m "Update nvim submodule"
```

### Update Claude Orchestration

The orchestration tool is also a git submodule:

```bash
cd ~/dotfiles/claude
git pull origin main
cd ~/dotfiles
git add claude
git commit -m "Update claude orchestration submodule"
```

### Update Brewfile (macOS)

To capture currently installed packages:

```bash
cd ~/dotfiles
brew bundle dump --force
git add Brewfile
git commit -m "Update Brewfile"
```

### Add New Zsh Module

1. Create new file in `shell/zsh/` (e.g., `docker.zsh`)
2. Add `source "$ZSH_CONFIG_DIR/docker.zsh"` to `.zshrc`
3. Commit both files

## Claude Orchestration

The dotfiles include an optional multi-agent Claude orchestration system for autonomous development.

### What It Does

- **Coder** - Implements features based on task specifications
- **Reviewer** - Reviews code for quality, security, and best practices
- **Tester** - Writes comprehensive tests and measures coverage
- **Coordinator** - Manages workflow, assigns tasks, tracks progress

All agents run in separate tmux windows and communicate via markdown files.

### Quick Start

```bash
# Create a new orchestrated project
cn my-project  # alias for claude-new

# This creates ~/projects/my-project/ with:
# - code/      Your actual code
# - comms/     Agent communication files
# - .claude/   Agent configurations

# Attach to the tmux session
tmux attach -t my-project

# Add tasks by editing the coordinator file
vim ~/projects/my-project/comms/coordinator.md

# Monitor progress in real-time
cm my-project  # alias for claude-monitor
```

### Available Commands

- `cn` / `claude-new` - Create new orchestrated project
- `cf` / `claude-focus` - Switch active project
- `cs` / `claude-status` - View all project statuses
- `cm` / `claude-monitor` - Real-time monitoring (single project)
- `cd` / `claude-dash` - Full dashboard (all projects)

### Documentation

Full documentation is available in the `claude/` directory:
- `START_HERE.md` - Getting started guide
- `QUICKSTART.md` - 10-minute setup
- `ARCHITECTURE.md` - Technical deep-dive
- `TUI_GUIDE.md` - Terminal UI guide

### Use Cases

Perfect for:
- Continuous development while you're away
- Managing multiple projects simultaneously
- Maintaining code quality with automated reviews
- Building comprehensive test suites
- 24/7 development on a VPS

## Troubleshooting

### Zsh modules not loading

Make sure the paths in `.zshrc` are correct. The script automatically detects whether to use `~/.config/shell/zsh` or the dotfiles directory.

### Neovim plugins not installing

Run `:Lazy sync` inside Neovim to manually trigger plugin installation.

### pyenv/nvm not found

Source your `.zshrc` again or restart your terminal:
```bash
source ~/.zshrc
```

## Platform Support

| OS | Status | Notes |
|----|--------|-------|
| macOS (Intel) | ✅ Fully supported | Tested on macOS Sonoma |
| macOS (Apple Silicon) | ✅ Fully supported | Homebrew handles architecture |
| Ubuntu 22.04+ | ✅ Fully supported | apt-based package installation |
| Debian 11+ | ✅ Fully supported | apt-based package installation |
| Other Linux | ⚠️ Partial | May require manual package installation |

## License

Free to use, modify, and distribute. No warranty provided.

## Credits

- Zsh prompt inspired by Oh-My-Zsh
- Neovim config structure based on modern Lua patterns
- Catppuccin theme by [@catppuccin](https://github.com/catppuccin)
