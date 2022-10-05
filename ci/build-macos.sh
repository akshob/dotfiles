#!/bin/bash
set -euo pipefail

# You can run it from any directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/dotfiles-init .
shellrc=."$(echo $SHELL | cut -d '/' -f3)"rc
source $shellrc
ll
if [ $? -ne 0 ]; then
    exit 1
fi

mkdir -p artifacts
cp dotfiles-init "artifacts/dotfiles-init"
