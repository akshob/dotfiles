#!/bin/bash
set -euo pipefail

# You can run it from any directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

set_homebrew_prefix() {
    if [ -f "/usr/local/bin/brew" ]; then
        export HOMEBREW_PREFIX="/usr/local"
    elif [ -f "/opt/homebrew/bin/brew" ]; then
        export HOMEBREW_PREFIX="/opt/homebrew"
    fi
}

set_homebrew_prefix

eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

brew install realpath
brew install akshob/tools/dotfiles-init
dotfiles-init
shellrc=."$(echo $SHELL | cut -d '/' -f3)"rc
source $shellrc
ll
if [ $? -ne 0 ]; then
    exit 1
fi

mkdir -p artifacts
cp dotfiles-init "artifacts/dotfiles-init"
