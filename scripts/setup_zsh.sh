#!/usr/bin/env bash
set -euo pipefail

# Install oh-my-zsh if not present
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Clone plugins and theme if missing
[[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

[[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

[[ -d "$ZSH_CUSTOM/themes/powerlevel10k" ]] || \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

# Install useful utilities
brew install git fzf bat direnv ollama msty >/dev/null
brew install --cask warp >/dev/null

ZSHRC="$HOME/.zshrc"

# Configure theme
if grep -q '^ZSH_THEME=' "$ZSHRC"; then
  sed -i.bak 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSHRC"
else
  echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSHRC"
fi

# Configure plugins
if grep -q '^plugins=' "$ZSHRC"; then
  sed -i.bak 's/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
else
  echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> "$ZSHRC"
fi

# Add aliases if not already present
grep -q "alias bat='bat --paging=never --style plain'" "$ZSHRC" || \
  echo "alias bat='bat --paging=never --style plain'" >> "$ZSHRC"

grep -q "alias fzfp='fzf --preview \"bat --style numbers --color always {}\"'" "$ZSHRC" || \
  echo "alias fzfp='fzf --preview \"bat --style numbers --color always {}\"'" >> "$ZSHRC"

# Source .zshrc to apply changes in current session if ZSH is running
if [[ "$SHELL" == *"zsh"* ]]; then
  source "$ZSHRC"
fi

