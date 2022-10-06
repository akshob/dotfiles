#!/bin/bash
set -euo pipefail

# You can run it from any directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck disable=SC1090
source "$DIR/prepare-build-dir.sh"

# Put Docker files to root of build dir to use build dir as working dir for Docker.
cp "$BUILD_DIR/ci/docker/Dockerfile" "$BUILD_DIR"

pushd "$BUILD_DIR" > /dev/null

echo "Running shellcheck against all .sh files in the project..."

# shellcheck disable=SC2016
docker run \
--tty \
--rm \
--volume "$(pwd)":/project:ro \
--entrypoint sh \
koalaman/shellcheck-alpine:v0.4.7 \
-c 'for file in $(find /project/ -type f -name "*.sh"); do
if ! shellcheck --format=gcc $file; then export FAILED=true; fi; done;
if [ "$FAILED" != "" ]; then exit 1; fi'

echo "Finished shellcheck."

# Files created in mounted volume by container should have same owner as host machine user to prevent chmod problems.
USER_ID=$(id -u "$USER")

if [ "$USER_ID" == "0" ]; then
    echo "Warning: running as r00t."
fi

docker build -t dotfiles:latest .

# Command will run inside a container.
BUILD_COMMAND="set -xe && "

# Configure environment variables in ~/.bashrc.
BUILD_COMMAND+="mv ~/.bashrc ~/.bashrc_original && "
BUILD_COMMAND+="/opt/project/dotfiles-init /opt/project && "
BUILD_COMMAND+="cat ~/.bashrc_original >> ~/.bashrc && "
BUILD_COMMAND+="rm ~/.bashrc_original && "
BUILD_COMMAND+=". ~/.bashrc && "

# Check if env functions works.
BUILD_COMMAND+="type ssource"

docker run \
--rm \
--volume "$(pwd)":/opt/project \
--env LOCAL_USER_ID="$USER_ID" \
dotfiles:latest \
bash -c "$BUILD_COMMAND"

popd > /dev/null
