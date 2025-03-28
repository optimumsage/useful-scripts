#!/bin/bash
# USE:
# curl -sSL https://raw.githubusercontent.com/optimumsage/useful-scripts/main/add_aliases.sh | bash

# Define your aliases
aliases=(
  "alias k='kubectl'"
  "alias d='docker'"
  "alias dc='docker-compose'"
  "alias dcu='docker-compose up -d'"
  "alias dcd='docker-compose down'"
  "alias ka='kubectl apply'"
  "alias kaf='kubectl apply -f'"
  "alias sshi='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i'"
)

# Function to add aliases to a file
add_aliases_to_file() {
  local file=$1
  for alias in "${aliases[@]}"; do
    # Check if the alias is already in the file
    if ! grep -Fxq "$alias" "$file"; then
      # Add alias if not already present
      echo "$alias" >> "$file"
      echo "Added alias: $alias to $file"
    else
      echo "Alias already present in $file: $alias"
    fi
  done
}

# Get the full path of the home directory
HOME_DIR=$HOME

# Create or append aliases to .my_aliases file
MY_ALIASES_FILE="$HOME_DIR/.my_aliases"
touch "$MY_ALIASES_FILE"
add_aliases_to_file "$MY_ALIASES_FILE"

# Function to ensure 'source ~/.my_aliases' is added to shell config files
add_source_to_shell_config() {
  local config_file=$1
  if ! grep -Fxq "source ~/.my_aliases" "$config_file"; then
    echo "source ~/.my_aliases" >> "$config_file"
    echo "Added 'source ~/.my_aliases' to $config_file"
  else
    echo "'source ~/.my_aliases' already present in $config_file"
  fi
}

# Check if .zshrc exists, then add 'source ~/.my_aliases' to .bashrc and .zshrc
if [ -f "$HOME_DIR/.zshrc" ]; then
  echo ".zshrc file found. Adding source ~/.my_aliases to .zshrc."
  add_source_to_shell_config "$HOME_DIR/.zshrc"
else
  echo ".zshrc not found, proceeding with .bashrc."
fi

# Add 'source ~/.my_aliases' to .bashrc
add_source_to_shell_config "$HOME_DIR/.bashrc"

# Source the relevant config file to apply changes immediately
if [ -f "$HOME_DIR/.zshrc" ]; then
  source "$HOME_DIR/.zshrc"
else
  source "$HOME_DIR/.bashrc"
fi
