#!/bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

source "$SCRIPT_DIR/installer.sh"

install_node(){
  if [ -f "$HOME/.nvm/nvm.sh" ]; then
    echo "nvm is installed. Loading nvm..."
  
    # Cargar nvm
    export NVM_DIR="$HOME/.nvm"
    . "$NVM_DIR/nvm.sh"

    # Verificar si nvm se cargó correctamente
    if command -v nvm &> /dev/null; then
      echo "nvm is installed and available. Version: $(nvm --version)"
      if command -v node &> /dev/null; then
        echo "node installed. Version: $(node -v)"
      else
        echo "node is not installed."
        read -p "¿Do you want to install Node? [Y/N]: " choice

        while [[ ! "$choice" =~ ^[YyNn]$ ]]; do
          echo "Invalid option. Please enter Y or N."
          read -p "¿Do you want to install Node? [Y/N]: " choice
        done

        if [[ "$choice" =~ ^[Yy]$ ]]; then
          echo "Installing Node..."
          nvm install stable  
          version=$(nvm current)
          echo "Node installed. Version: $version"
          nvm alias default $version
          echo "Node is set as the default version."
        elif [[ "$choice" =~ ^[Nn]$ ]]; then
          echo "Skipping Node Installation."
          exit 0
        fi
      fi
    else
      echo "nvm is installed but could not be loaded."
      exit 1
    fi
  else
    echo "nvm is not installed."
    read -p "¿Do you want to install nvm? [Y/N]: " choice
    
    while [[ ! "$choice" =~ ^[YyNn]$ ]]; do
      echo "Invalid option. Please enter Y or N."
      read -p "¿Do you want to install nvm? [Y/N]: " choice
    done

    if [[ "$choice" =~ ^[Yy]$ ]]; then
      echo "Validating curl..."
      if command -v curl &> /dev/null; then
        echo "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
        echo "nvm installed."
        echo "Reloading script to validate nvm installation..."
        exec "$0" "$@"
      else
        echo "curl is not installed."
        install_software "Curl" "curl" "sudo apt install curl"
        echo "Curl installed. Reloading script..."
        exec "$0" "$@"
      fi
    elif [[ "$choice" =~ ^[Nn]$ ]]; then
      echo "Skipping nvm installation."
      exit 0
    fi
  fi
}
