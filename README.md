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

1. From the dotfile repo, run

   ```console
   cp .vimrc ~
   cp -r .vim ~
   ```

1. Start VIM and run `:PlugInstall`.

1. Install the iTerm profile.

1. Add the following aliases to `~/.zshrc`:

   ```ini
   export REPOS="${HOME}/repos"
   export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
   export PATH="/usr/local/opt/openjdk/bin:$PATH"
   export PATH="/usr/local/sbin:$PATH"
   export path_service="${REPOS}/service"
   export path_docs="${REPOS}/docs"

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
   alias rd='cd ${path_docs}'
   alias to='cd ${path_service}'
   alias toc='code ${path_service}'
   alias rdc='code ${path_docs}'
   ```

1. Work.
