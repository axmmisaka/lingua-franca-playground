#!/bin/bash

# This script sets up the lingua franca environment;
# it will use the nightly build of lingua franca, unless the second argument
# is "stable" where it will use the stable build, or "dev" where it will pull from the master branch and build it.

set -euxo pipefail

# Install dependencies
sudo apt update
npm install -g typescript
sudo apt install --assume-yes rustc

RELEASE_BUILD="nightly"
EXAMPLE=1

for arg in "$@"; do
    shift
    case "$arg" in
        'dev') RELEASE_BUILD="dev";;
        'stable') RELEASE_BUILD="stable";;
        '--no-example') EXAMPLE=0
    esac
done

# Use case here for maximum flexibility if we were to change later
case "$RELEASE_BUILD" in
    'dev') 
        git clone https://github.com/lf-lang/lingua-franca.git --branch master --depth 1
        cd lingua-franca
        git submodule update --init --recursive
        ./gradlew buildAll
        cd .. 
    ;;
    *) 
        ./.scripts/get-lf-executable $RELEASE_BUILD
        mkdir lingua-franca
        # While what we have here is tar.gz, lf release bot appear to have a bug and did not gunzip it.
        # Therefore `tar -xzf` will fail but `tar -xf` will work.
        # Here, we ignore the actual build name (the original name of the file and the original first directory). 
        tar -xf lf.tar.gz -C lingua-franca --strip-components 1
        rm lf.tar.gz
    ;;
esac

if [ $EXAMPLE ]; then
    git clone https://github.com/lf-lang/examples-lingua-franca.git examples --branch main
fi