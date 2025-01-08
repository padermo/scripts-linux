#!/bin/bash

install_software(){
  local software_name=$1
  local command_check=$2
  local install_command=$3

  # Comprueba si el software está instalado
  if command -v "$command_check" &> /dev/null; then
    echo "$software_name is already installed."

    # Intentar obtener la versión utilizando diferentes flags
    version=""
    for version_flag in "-v" "--version" "-V"; do
      version=$($command_check $version_flag 2>/dev/null)
      if [[ $? -eq 0 ]]; then
        echo "$software_name version: $version"
        break
      fi
    done

    if [[ -z "$version" ]]; then
      echo "Unable to fetch version for $software_name. Please check the installation."
    fi
  else
    echo "$software_name is not installed."
    read -p "Do you want to install $software_name? [Y/N]: " choice

    # Validar la respuesta
    while [[ ! "$choice" =~ ^[YyNn]$ ]]; do
      echo "Invalid option. Please enter Y or N."
      read -p "Do you want to install $software_name? [Y/N]: " choice
    done

    if [[ "$choice" =~ ^[Yy]$ ]]; then
      echo "Installing $software_name..."
      eval "$install_command"
      echo "$software_name installed successfully."
    else
      echo "Skipping $software_name installation."
      exit 0
    fi
  fi
}
