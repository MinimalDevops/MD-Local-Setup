#!/usr/bin/env bash
set -euo pipefail

if command -v brew >/dev/null 2>&1; then
    echo "Homebrew already installed. Skipping installation."
    exit 0
fi

# Detect operating system
OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
    if ! xcode-select -p >/dev/null 2>&1; then
        echo "Installing Xcode command line tools..."
        xcode-select --install
    fi
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OS" == "Linux" ]]; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "Unsupported OS: $OS" >&2
    exit 1
fi

brew --version
