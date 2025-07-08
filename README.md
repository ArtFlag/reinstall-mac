# Reinstall

- [Reinstall](#reinstall)
  - [Minimal install](#minimal-install)
  - [Complete install](#complete-install)

## Minimal install

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/nyquase/vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/vi-mode
```

## Complete install

1. Run the minimal install.

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

1. Neovim:

   ```console
   sh ./setup-neovim.sh
   mkdir ~/.config/ghostty/themes
   cp arthur ~/.config/ghostty/themes
   cp config $HOME/Library/Application\ Support/com.mitchellh.ghostty/config
   ```

1. Add the following aliases to `~/.zshrc`:

   ```ini
   export HOMEBREW_AUTO_UPDATE_SECS="100400"
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
   alias rec='code ${REPOS}/recipes'
   alias opr='gh pr create'
   alias spr='gh pr view --web'
   alias vr='gh repo view --web'
   alias update_fork='git fetch upstream && git checkout main && git rebase upstream/main && git push'
   alias setGitUser='git config user.name "ArtFlag" && git config user.email "aflageul@tuta.io"'
   ```

1. Work.
