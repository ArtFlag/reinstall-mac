#!/bin/bash

set -e

echo "Setting up Neovim as your main vi/vim replacement..."

# Ensure Neovim is installed
if ! command -v nvim &> /dev/null; then
    echo "Neovim not found. Installing via Homebrew..."
    brew install neovim
fi

# Create symlinks to replace vi and vim with nvim
echo "Creating symlinks for vi and vim..."
sudo ln -sf "$(which nvim)" /usr/local/bin/vi
sudo ln -sf "$(which nvim)" /usr/local/bin/vim

# Define paths
NVIM_CONFIG_DIR="${HOME}/.config/nvim"
AUTOLOAD_DIR="${NVIM_CONFIG_DIR}/autoload"
PLUGINS_FILE="${NVIM_CONFIG_DIR}/vim-plug/plugins.vim"
INIT_VIM="${NVIM_CONFIG_DIR}/init.vim"

# Install vim-plug
echo "Installing vim-plug for Neovim..."
mkdir -p "$AUTOLOAD_DIR"
curl -fLo "${AUTOLOAD_DIR}/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Create plugins.vim
echo "Creating plugins.vim configuration..."
mkdir -p "$(dirname "$PLUGINS_FILE")"
cat << 'EOF' > "$PLUGINS_FILE"
if has("termguicolors")
  set termguicolors
endif

syntax on
let g:airline_theme = 'minimalist'

set nocompatible
set number
set nobackup
set showmode
set noerrorbells

filetype on
filetype plugin on
filetype indent on
EOF

# Create init.vim
if [ ! -f "$INIT_VIM" ]; then
    echo "Creating init.vim..."
    mkdir -p "$NVIM_CONFIG_DIR"
    cat << 'EOF' > "$INIT_VIM"
" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Plug 'VonHeikemen/midnight-owl.vim'
  Plug 'Mofiqul/vscode.nvim'
  Plug 'sheerun/vim-polyglot'
  Plug 'scrooloose/NERDTree'
  Plug 'jiangmiao/auto-pairs'
call plug#end()

source $HOME/.config/nvim/vim-plug/plugins.vim
EOF
else
    echo "init.vim already exists. Skipping overwrite."
fi

# Install plugins
echo "Installing plugins with PlugInstall..."
nvim +PlugInstall +qall
git config --global core.editor nvim
echo "🎉 Neovim setup complete! Plugins installed and ready to use."
