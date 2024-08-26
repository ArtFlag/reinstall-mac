# Reinstall

- [Minimal install](#minimal-install)
- [Complete install](#complete-install)

## Minimal install

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
CPU=$(uname -p)
if [[ "$CPU" == "arm" ]]; then #M1
  echo "💻 ARM computer."
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install romkatv/powerlevel10k/powerlevel10k
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/nyquase/vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/vi-mode
```

## Complete install

1. Install [ohmyzsh](https://ohmyz.sh/) and [powerlevel10k](https://github.com/romkatv/powerlevel10k):

   ```console
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   brew install romkatv/powerlevel10k/powerlevel10k
   echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/nyquase/vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/vi-mode
   ```

1. Set the plugin value in `~/.zshrc` to:

   ```console
   plugins=(git vi-mode zsh-autosuggestions)
   ```

1. [Download the repo](https://github.com/ArtFlag/reinstall-mac/archive/refs/heads/master.zip) to
   your computer and unpack it.

1. From the root of the folder, run:

   ```console
   sh ./install.sh
   ```

1. Install [vim-plug](https://github.com/junegunn/vim-plug?tab=readme-ov-file).

1. Neovim:

   ```console
   mkdir ~/.config/nvim
   touch ~/.config/nvim/init.vim
   curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   mkdir ~/.config/nvim/vim-plug
   touch ~/.config/nvim/vim-plug/plugins.vim
   ```

1. Add this to `plugins.vim`:

   ```lua
   " auto-install vim-plug
   if empty(glob('~/.config/nvim/autoload/plug.vim'))
     silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
       \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
     "autocmd VimEnter * PlugInstall
     "autocmd VimEnter * PlugInstall | source $MYVIMRC
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
   ```

1. Add this to `init.vim`:

   ```lua
   source $HOME/.config/nvim/vim-plug/plugins.vim
   if (has("termguicolors"))
    set termguicolors
   endif
   syntax on
   let g:airline_theme='minimalist'
   set nocompatible
   set number
   set nobackup
   set showmode
   set noerrorbells
   filetype on
   filetype plugin on
   filetype indent on
   ```

1. Run `git config --global core.editor nvim`.
1. Run `nvim` and run `:PlugInstall`.

1. Install the iTerm profile.

1. Add the following aliases to `~/.zshrc`:

   ```ini
   export REPOS="${HOME}/repos"
   export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
   export PATH="/usr/local/opt/openjdk/bin:$PATH"
   export PATH="/usr/local/sbin:$PATH"
   export PATH_SERVICE="${REPOS}/service"
   export PATH_DOCS="${REPOS}/docs"

   ## Generic
   alias gcmu='gcm && gl'
   alias gmu='gcm && gl && gsw -'
   alias opr='gh pr create'
   alias spr='gh pr view --web'
   alias ls='ls -GFh'
   alias ll='ls -lsaGFh'
   alias clear_history='echo "" > ~/.zsh_history & exec $SHELL -l'
   alias check='brew update && echo "\n\nAPPS:" && brew outdated --cask --greedy && echo "\n\nPACKAGES:" && brew outdated && brew cleanup'

   ## Docs repo aliases
   alias ys='yarn start'
   alias yb='yarn build'
   alias yss='yarn serve'
   alias rd='cd ${PATH_DOCS}'
   alias to='cd ${PATH_SERVICE}'
   alias toc='code ${PATH_SERVICE}'
   alias rdc='code ${PATH_DOCS}'
   ```

1. Work.
