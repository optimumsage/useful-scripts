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

# Function to add aliases to the specified shell config file
add_aliases_to_shell_config() {
  local config_file=$1
  for alias in "${aliases[@]}"; do
    # Check if the alias is already in the config file
    if ! grep -Fxq "$alias" "$config_file"; then
      # Add alias if not already present
      echo "$alias" >> "$config_file"
      echo "Added alias: $alias to $config_file"
    else
      echo "Alias already present in $config_file: $alias"
    fi
  done
}

# Check if Zsh is the current shell
if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
  echo "Zsh shell detected."
  add_aliases_to_shell_config "~/.zshrc"
else
  echo "Bash shell detected or another shell is in use."
  add_aliases_to_shell_config "~/.bashrc"
fi

# Source the relevant config file to apply changes immediately
if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/bin/zsh" ]; then
  source ~/.zshrc
else
  source ~/.bashrc
fi
