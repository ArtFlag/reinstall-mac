#!/bin/bash

function install_python_tooling() {
  brew install pyenv
  brew install pipenv
  printf "\n\nInstalling poetry...\n"
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
  export PATH="$PATH:$HOME/.poetry/bin"
  printf "\n\nInstalling Python..."
  pyenv install 3.10.4
  pyenv global 3.10.4
  echo "export PATH=\"/usr/local/opt/coreutils/libexec/gnubin:\${PATH}\"" >> ~/.zshrc
  echo "export PATH=\"\${HOME}/.poetry/bin:\${PATH}\"" >> ~/.zshrc
  echo "if command -v pyenv 1>/dev/null 2>&1; then" >> ~/.zshrc
  echo "  eval \"\$(pyenv init -)\"" >> ~/.zshrc
  echo "fi" >> ~/.zshrc
  printf "\nRun 'source ~/.zshrc' to apply changes to your PATH.\n"
}

function install_utilities() {
  # Installs all the apps
  printf "Installing oh-my-zsh...\n"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  printf "Checking if Homebrew is installed...\n"
  if ! command -v brew >/dev/null; then
    printf "\nInstalling Homebrew...\n\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    printf "\nUpdating Homebrew...\n\n"
    brew update
  fi
  printf "\n\nInstalling utilities...\n\n"
  brew bundle
  brew cleanup
  read -p "Install Python tooling? (y,n): " doit
  printf "\n"
  case $doit in
    y | Y) install_python_tooling ;;
    n | N) echo "Skipping python\n" ;;
  esac
}

function setup_git() {
  printf "\n\nSetting up git...\n\n"
  # Creates SSH key and sets up git config
  if ssh -q git@github.com; [ $? -eq 255 ]; then
    # GitHub SSH failed, so create a new SSH key
    printf "\nCreating SSH key...\n"
    read -rp "Enter your e-mail: " ssh_email
    printf "\n"
    ssh-keygen -t ed25519 -C "$ssh_email"
    printf "\n"

    printf "Adding ssh key to ssh-agent\n"
    eval "$(ssh-agent -s)"
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519

    printf "\n👋 Copying SSH key to clipboard. You can copy the key again by running 'pbcopy <~/.ssh/id_ed25519.pub'\n"
    pbcopy <~/.ssh/id_ed25519.pub
    printf "\n✅ Done.\n 👋 Paste it in GitHub https://github.com/settings/keys\n\n"
    read -p "Set up git config? (y,n): " doit
    printf "\n"
    case $doit in
      y | Y)
        read -p "👋 Enter your first name (no spaces): " fn
        read -p "👋 Enter your last name (no spaces): " ln
        git config --global credential.helper store
        git config --global user.name "$fn $ln"
        git config --global user.email "$ssh_email"
        git config --global core.pager cat
        git config --global pull.rebase true
        git config --global fetch.prune true
        git config --global push.autoSetupRemote true
        git config --global mergetool.keepBackup false
        git config --global merge.tool vscode
        git config --global mergetool.vscode.cmd "code --wait --merge \$REMOTE \$LOCAL \$BASE \$MERGED"
        ;;
      n | N) echo "Skipping" ;;
    esac
  else
    printf "\nSSH is already configured. Nothing to do.\n"
  fi
}

function setup_editors() {
  printf "\n\nSetting up neovim and ghostty...\n\n"
  sh ./setup-neovim.sh
  mkdir -p ~/.config/ghostty/themes
  cp ./ghostty/arthur ~/.config/ghostty/themes
  cp ./ghostty/config "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
}

########################################
################# MAIN #################
########################################

install_utilities
setup_git
setup_editors

mkdir -p ~/repos
printf "✅ Created ~/repos.\n"
printf "Done. ✅\n"
