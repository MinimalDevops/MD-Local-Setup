#!/usr/bin/env bash
set -euo pipefail

if command -v brew >/dev/null 2>&1; then
    echo "Homebrew already installed. Skipping installation."
    exit 0
fi

# Detect operating system
OS="$(uname -s)"

if [[ "$OS" == "Darwin" ]]; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
elif [[ "$OS" == "Linux" ]]; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
    echo "Unsupported OS: $OS" >&2
    exit 1
fi

brew --version
