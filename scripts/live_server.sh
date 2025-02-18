#!/bin/bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

source "$SCRIPT_DIR/node.sh"

install_live_server(){
  if command -v live-server &> /dev/null; then
    echo "live-server is already installed."
    exit 0
  else
    echo "live-server is not installed."
    echo "Validating node.js..."
    if command -v node &> /dev/null; then
      echo "node installed. Version: $(node -v)"
      echo "Installing live-server..."
      npm install -g live-server
      echo "live-server installed successfully."
    else
      install_node
      echo "Node installed. Reloading script..."
      exec "$0" "$@"
    fi
  fi
}

install_live_server
