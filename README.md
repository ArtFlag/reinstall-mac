# Reinstall script

1. Install the [Workman layout](https://github.com/workman-layout/Workman/tree/master/mac).

1. Install my ohmyzsh:

   ```console
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

1. [Download the dotfile repo](https://github.com/ArtFlag/dotfiles/archive/master.zip) to
   your computer and unpack it.

1. From the root of the repo, run:

   ```console
   sh ./install.sh
   ```

1. Run:

   ```console
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/
   zsh-autosuggestions
   git clone https://github.com/nyquase/vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/vi-mode
   ```

1. Set the plugin value in `~/.zshrc` to:

   ```console
   plugins=(git vi-mode zsh-autosuggestions)
   ```

1. From the dotfile repo, run

   ```console
   cp .vimrc ~
   cp -r .vim ~
   ```

1. Install the iTerm color scheme and profile.

1. Add the following aliases to `~/.zshrc`:

   ```console
   export JAVA_HOME=$(/usr/libexec/java_home)
   alias gcmu='gcm && gl'
   alias gmu='gcm && gl && gsw -'
   alias opr='gh pr create'
   alias showpr='gh pr view'
   alias ls='ls -GFh'
   alias ll='ll -lsa'
   alias clear_history='echo "" > ~/.zsh_history & exec $SHELL -l'
   alias check='brew update && echo "\n\nAPPS:" && brew cask outdated --greedy && echo "\n\nPACKAGES:" && brew outdated'
   alias pip=/usr/local/bin/pip3
   ```

1. Work.
