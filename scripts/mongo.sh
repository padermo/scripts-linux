#!/bin/bash

MONGO_KEYRING="/usr/share/keyrings/mongodb-server-8.0.gpg"
MONGO_PGP_URL="https://www.mongodb.org/static/pgp/server-8.0.asc"
MONGO_REPO_FILE="/etc/apt/sources.list.d/mongodb-org-8.0.list"
MONGO_REPO="deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse"

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

# Cargar installer.sh si existe
if [[ -f "$SCRIPT_DIR/installer.sh" ]]; then
    source "$SCRIPT_DIR/installer.sh"
else
    echo "Warning: installer.sh not found. Proceeding without it."
fi

install_mongo(){
  if command -v mongod &> /dev/null; then
    echo "MongoDB is already installed."
  else
    echo "MongoDB is not installed."
    echo "Validating dependencies (curl, gnupg)..."

    dependencies=(
      "Curl curl 'sudo apt install -y curl'"
      "GnuPG gpg 'sudo apt install -y gnupg'"
    )

    missing_packages=()

    for dep in "${dependencies[@]}"; do
      read -r name command install_cmd <<< "$dep"
      if ! command -v "$command" &> /dev/null; then
        echo "$name is not installed."
        missing_packages+=("$install_cmd")
      else
        echo "$name is already installed."
      fi
    done

    # Instalar paquetes faltantes
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
      echo "Installing missing dependencies..."
      for cmd in "${missing_packages[@]}"; do
        eval "$cmd"
      done
      echo "All dependencies installed successfully."
    else
      echo "All required dependencies are already installed."
    fi

    # Verificar si la clave GPG ya está instalada
    if [[ -f "$MONGO_KEYRING" ]]; then
      echo "MongoDB keyring already exists."
    else
      echo "Downloading MongoDB GPG key..."
      curl -fsSL "$MONGO_PGP_URL" | sudo gpg -o "$MONGO_KEYRING" --dearmor
      echo "MongoDB GPG key installed successfully."
    fi

    # Verificar si el repositorio ya está agregado
    if [[ -f "$MONGO_REPO_FILE" ]] && grep -Fxq "$MONGO_REPO" "$MONGO_REPO_FILE"; then
      echo "MongoDB repository is already added."
    else
      echo "Adding MongoDB repository..."
      echo "$MONGO_REPO" | sudo tee "$MONGO_REPO_FILE" > /dev/null
      echo "MongoDB repository added successfully."
    fi

    echo "Updating package lists..."
    sudo apt-get update

    echo "Installing MongoDB..."
    sudo apt-get install -y mongodb-org

    echo "Starting and enabling MongoDB service..."
    sudo systemctl start mongod
    sudo systemctl enable mongod

    echo "MongoDB installation completed."
  fi 
}
