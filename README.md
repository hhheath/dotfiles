# dotfiles

Personal dotfiles for macOS and Linux.

## What's in here

- **zsh** — single `.zshrc` with custom git-aware prompt, aliases, and functions
- **ghostty** — terminal config (Inconsolata Mono Nerd Font, Catppuccin Mocha)
- **tmux** — `Ctrl+Space` prefix, vim-style pane navigation
- **neovim** — full LSP/Treesitter setup, maintained in a [separate repo](https://github.com/hhheath/nvim)
- **AeroSpace** — i3-like tiling window manager (macOS)
- **Brewfile** — macOS packages via Homebrew
- **Claude Code** — AI coding assistant

## Install

```bash
git clone https://github.com/hhheath/dotfiles.git ~/code/dotfiles
cd ~/code/dotfiles
./install.sh
```

The install script handles both platforms:

**macOS** — installs Homebrew, runs `brew bundle` from Brewfile, installs nvm/node, copies configs, symlinks nvim, sets zsh as default shell, installs Claude Code.

**Linux** — installs packages via apt, builds Neovim from source, installs nvm/node, copies configs, symlinks nvim, sets zsh as default shell, installs Claude Code.

### After install

1. Restart your terminal (or `source ~/.zshrc`)
2. Update `~/.gitconfig` with your name/email
3. Open `nvim` to auto-install plugins
4. `pyenv install 3.12 && pyenv global 3.12`
5. `nvm install --lts`

## Structure

```
dotfiles/
├── config/
│   ├── ghostty/config     # Ghostty terminal
│   └── aerospace/         # AeroSpace window manager (macOS)
├── .zshrc                 # Zsh config
├── .tmux.conf             # Tmux config
├── .gitconfig             # Git config (template)
├── Brewfile               # Homebrew packages
└── install.sh             # Setup script
```

## Key bindings

### Tmux
- **Prefix**: `Ctrl+Space`
- **Panes**: `Alt+hjkl` to navigate, `\` horizontal split, `-` vertical split
- **Mouse**: enabled

### AeroSpace (macOS)
- **Navigation**: `Alt+hjkl`
- **Move windows**: `Alt+Shift+hjkl`
- **Workspaces**: `Alt+1-9`, `Alt+A-Z`

## Updating

### Brewfile

```bash
brew bundle dump --force --file=~/code/dotfiles/Brewfile
```
