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
   eval "$(starship init zsh)"
   eval "$(zoxide init zsh)"
   export ZSH="$HOME/.oh-my-zsh"
   plugins=(git vi-mode)
   source $ZSH/oh-my-zsh.sh
   source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
   source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

   export HOMEBREW_AUTO_UPDATE_SECS="100400"
   export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
   export REPOS="${HOME}/repos"
   export PATH="/usr/local/opt/openjdk/bin:$PATH"
   export PATH="/usr/local/sbin:$PATH"
   export PATH="/Users/arthur/:$PATH"
   export REPOS="${HOME}/repos"
   export PATH_DOCS="${REPOS}/docs"
   export VALE_CONFIG_PATH="${PATH_DOCS}/.vale.ini"
   export VALE_STYLES_PATH="${PATH_DOCS}/_vale/Docker"
   export PATH_SERVICE="${REPOS}/service"
   export PATH_DOCS="${REPOS}/docs"

   ## Generic
   alias gcmu='gcm && gl'
   alias gmu='gcm && gl && gsw -'
   alias opr='gh pr create'
   alias spr='gh pr view --web'
   alias ll='eza -la --icons --group-directories-first --no-permissions --no-user -s extension'
   alias clear_history='echo "" > ~/.zsh_history & exec $SHELL -l'
   alias check='brew update && echo "\n\nAPPS:" && brew outdated --cask --greedy && echo "\n\nPACKAGES:" && brew outdated && brew cleanup'
   alias upgradestuff='brew update && brew upgrade && brew cleanup && upgrade_oh_my_zsh && bash <(curl -sSL https://spotx-official.github.io/run.sh)'
   alias sshadd='ssh-add ~/.ssh/id_ed25519 && ssh-add ~/.ssh/perso'
   # alias setup-fork='git remote add upstream (url) && git remote set-url --push upstream no_pushing'

   ### Docs repo aliases
   alias ys='yarn start'
   alias yb='yarn build'
   alias yss='yarn serve'
   alias rts='cd ${TALONSERVICEPATH}'
   alias rtsc='code ${TALONSERVICEPATH}'
   alias rd='cd ${PATH_DOCS}'
   alias rdc='code ${PATH_DOCS}'
   alias rr='cd ${REPOS}/recipes'
   alias rrc='code ${REPOS}/recipes'
   alias opr='gh pr create'
   alias spr='gh pr view --web'
   alias vr='gh repo view --web'
   alias update_fork='git fetch upstream && git checkout main && git rebase upstream/main && git push'
   alias setGitUser='git config user.name "ArtFlag" && git config user.email "aflageul@tuta.io"'
   ```

1. Run:

   ```bash
   bash <(curl -sSL https://spotx-official.github.io/run.sh)
   ```

3. Work.
