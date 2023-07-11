#!/bin/bash
# This script specifically detects and set up nvm and SDKMAN in bash environment, and install
# needed components for LF
set -euxo pipefail

# Check if SDK is installed like what SDKMAN installer does
if [ -z "$SDKMAN_DIR" ] ; then
    echo "SDKMAN not found. Installing"
    curl -s "https://get.sdkman.io" | bash
    export SDKMAN_DIR="$HOME/.sdkman"
fi

set +ux
\. "$SDKMAN_DIR/bin/sdkman-init.sh"
sdk install java 17.0.7-ms <<< "y"
sdk use java 17.0.7-ms
set -ux


# Check if nvm is installed
NVM_INSTALLED=0
if [ -d "${HOME}/.nvm/.git" ]; then 
    NVM_INSTALLED=1;
    export NVM_DIR="${HOME}/.nvm"
fi
# Check if nvm is in .bashrc
NVM_BASHRC_COMMAND=$(grep -e "export NVM_DIR" "$HOME/.bashrc")
set +ux
if [ -n "${NVM_BASHRC_COMMAND}" ]; then
    NVM_INSTALLED=1

    eval "${NVM_BASHRC_COMMAND}"
fi
if [ $NVM_INSTALLED -eq 1 ]; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
else
    set +ux
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    export NVM_DIR="${HOME}/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
fi
nvm install --lts
nvm use --lts
npm install --global typescript pnpm

