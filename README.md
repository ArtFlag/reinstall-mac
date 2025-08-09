# Reinstall MacOS

## Install

1. [Download the repo](https://github.com/ArtFlag/reinstall-mac/archive/refs/heads/master.zip) to
   your computer and unpack it.

1. From the root of the folder, run:

   ```console
   sh ./install.sh
   ```

1. Add the following aliases to `~/.zshrc`:

   ```ini
   export ZSH="$HOME/.oh-my-zsh"
   source $ZSH/oh-my-zsh.sh
   eval "$(starship init zsh)"
   eval "$(zoxide init zsh)"
   source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
   plugins=(git vi-mode zoxide)

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
   #alias ls='ls -GFh'
   #alias ll='ls -lsaGFh'
   alias ll='eza -l --icons --group-directories-first --no-permissions --no-user -s extension'
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
