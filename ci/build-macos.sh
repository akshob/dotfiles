#!/bin/bash
set -euo pipefail

# You can run it from any directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Printing .bashrc contents"
cat $HOME/.bashrc
$DIR/../dotfiles-init $DIR/..
echo "Printing .bashrc contents"
cat $HOME/.bashrc
echo "Sourcing .bashrc"
source $HOME/.bashrc
echo "Testing ll command"
ll

mkdir -p artifacts
cp $DIR/../dotfiles-init "artifacts/dotfiles-init"
