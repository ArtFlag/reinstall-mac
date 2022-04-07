#!/bin/bash

function install_vscode_extensions() {
  # Installs the VSCode extensions
  printf "Installing extensions...\n"
  code --install-extension 42crunch.vscode-openapi
  code --install-extension artflag.aubergine
  code --install-extension bierner.markdown-preview-github-styles
  code --install-extension davidanson.vscode-markdownlint
  code --install-extension donjayamanne.python
  code --install-extension eamodio.gitlens
  code --install-extension errata-ai.vale-server
  code --install-extension esbenp.prettier-vscode
  code --install-extension jounqin.vscode-mdx
  code --install-extension nhoizey.gremlins
  code --install-extension redhat.vscode-yaml
  code --install-extension shuworks.vscode-table-formatter
  code --install-extension silvenon.mdx
  code --install-extension tuxtina.json2yaml
  code --install-extension vscodevim.vim
  code --install-extension vstirbu.vscode-mermaid-preview
  code --install-extension wmaurer.change-case
  code --install-extension yzhang.markdown-all-in-one
  printf "Done.\n"
}

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
  source ~/.zshrc
}

function install_utilities() {
  # Installs all the apps
  printf "Checking if Homebrew is installed...\n"
  if ! command -v brew >/dev/null; then
    printf "\nInstalling Homebrew...\n\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    printf "\nUpdating Homebrew...\n\n"
    brew update
  fi
  printf "\n\nInstalling utilities...\n\n"
  if [[ $(command -v code 2>&1 > /dev/null; echo $?) -eq 0 ]]; then
    printf "VS Code found\n"
  else
    brew install --cask "visual-studio-code"
    printf "\n\n"
    read -p "Launch VSCode once, then close it (cmd-Q). When it is closed, press Enter in this window to continue... "
  fi
  brew bundle
  brew cleanup
  read -p "Install Python tooling (y,n): " doit
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
    ssh-add -K ~/.ssh/id_ed25519

    printf "\nCopying ssh key to clipboard. You can copy the key again by running 'pbcopy <~/.ssh/id_ed25519.pub'\n"
    pbcopy <~/.ssh/id_ed25519.pub
    printf "Done. Paste it in GitHub https://github.com/settings/keys\n\n"
    read -p "Set up git config? (y,n): " doit
    printf "\n"
    case $doit in
    y | Y)
      read -p "Enter your first name (no spaces): " fn
      read -p "Enter your last name (no spaces): " ln
      git config --global credential.helper store
      git config --global user.name "$fn $ln"
      git config --global user.email "$ssh_email"
      git config --global core.pager cat
      git config --global merge.tool p4merge
      git config --global mergetool.p4merge.path /Applications/p4merge.app/Contents/MacOS/p4merge
      git config --global mergetool.keepBackup false
      git config --global pull.rebase true
      git config --global fetch.prune true
      ;;
    n | N) echo "Skipping" ;;
    esac
  else
    printf "\nSSH is already configured. Nothing to do.\n"
  fi
}
########################################
################# MAIN #################
########################################

install_utilities
install_vscode_extensions
setup_git
mkdir ~/repos
printf "Created ~/repos.\n"
brew cleanup

printf "Done. ✅\n"
