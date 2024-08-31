#!/bin/bash

# Directory
EXTRACT_DIR="./"

# Create directory
mkdir -p "$EXTRACT_DIR"

# Extract the tarball
tar -xzvf scripts.tar.gz -C "$EXTRACT_DIR"

eval "$EXTRACT_DIR/scripts/install_dev_tools.sh"
