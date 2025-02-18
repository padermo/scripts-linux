#!/bin/bash

SCRIPTS_DIR="./scripts"

show_menu(){
  echo "==========================="
  echo "       Install Menu        "
  echo "==========================="
  echo "1. Install Node JS (LTS)"
  echo "2. Install Lua"
  echo "3. Install Curl"
  echo "4. Install Git"
  echo "5. Install Live Server (-g)"
  echo "6. Install Neovim"
  echo "0. Exit"
  echo "==========================="
}

run_script() {
  local script_name=$1
  if [ -f "$SCRIPTS_DIR/$script_name" ]; then
    source "$SCRIPTS_DIR/$script_name"
  else
    echo "Script $script_name does not exist in $SCRIPTS_DIR."
  fi
}

main_menu(){
  while true; do
    show_menu
    read -p "Select an option: " choice
    case $choice in 
      1)
        echo "Running installation of Node JS (LTS)..."
        run_script "node.sh"
        install_node
        ;;
      2)
        echo "Running installation of Lua..."
        run_script "installer.sh"
        install_software "Lua" "lua" "sudo apt install lua"
        ;;
      3)
        echo "Running installation of Curl..."
        run_script "installer.sh"
        install_software "Curl" "curl" "sudo apt install curl"
        ;;
      4)
        echo "Running installation of Git..."
        run_script "installer.sh"
        install_software "Git" "git" "sudo apt install git"
        ;;
      5)
        echo "Running installation of Live Server..."
        run_script "live_server.sh"
        install_live_server
        ;;
      6)
        echo "Running installation of Neovim..."
        run_script "installer.sh"
        install_software "Neovim" "nvim" "sudo apt install neovim"
        ;;
      0)
        echo "Leaving..."
        exit 0
        ;;
      *)
        echo "Invalid option. Please try again."
        ;;
    esac
  done
}

main_menu
