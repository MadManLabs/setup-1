#!/usr/bin/env bash

# python
# --------

# sets up python environment

PACKAGES=(
    ipython
    licenser
    pep8
    uncommitted
    virtualenv
)

log -v "setting up python..."

brew_install pyenv
brew install pyenv-virtualenv

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

pyenv rehash

PYTHON2_VERSION="$(pyenv install -l | grep -e '2.[0-9].[0-9]' | grep -v - | tail -1)"
PYTHON3_VERSION="$(pyenv install -l | grep -e '3.[0-9].[0-9]' | grep -v - | tail -1)"

pyenv install $PYTHON2_VERSION
pyenv install $PYTHON3_VERSION
pyenv global $PYTHON2_VERSION $PYTHON3_VERSION

# python 2

pip install --upgrade pip

for p in "${PACKAGES[@]}"; do
    pip install "$p"
done