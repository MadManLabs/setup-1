#!/usr/bin/env bash

# bashrc
#
# bash settings
# --------

# load dotfiles

files=(
  ~/.aliases
  ~/.exports
  ~/.functions
  ~/.git-prompt.sh
  ~/.env # placed last for precedence
)

for file in "${files[@]}"; do
  if [ -f "$file" ]; then
    # shellcheck disable=SC1090
    source "$file"
  fi
done

# bash options

options=(
  histappend
  cdspell
  globstar
  dotglob
  cmdhist
  dirspell
  nocaseglob
)

for option in "${options[@]}"; do
  shopt -s "$option"
done

# fuck

eval "$(thefuck --alias)"

# autojump

if [ -f "$(brew --prefix)/etc/profile.d/autojump.sh" ]; then
  # shellcheck disable=SC1090
  source "$(brew --prefix)/etc/profile.d/autojump.sh"
fi

# bash completion

if [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]; then
  export BASH_COMPLETION_COMPAT_DIR
  BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"

  # shellcheck disable=SC1090
  source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
fi

bind "set show-all-if-ambiguous on"

# nvm

if [[ -s "$(brew --prefix nvm)" ]]; then
  # shellcheck disable=SC1090
  source "$(brew --prefix nvm)/nvm.sh"
  nvm alias default system > /dev/null

  # fix for homebrew nvm

  if [ -f "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ]; then
    # shellcheck disable=SC1090
    source "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
  fi

  # call `nvm use` automatically

  function find-up() {
    path=$(pwd)
    while [[ "$path" != "" && ! -e "$path/$1" ]]; do
      path=${path%/*}
    done
    echo "$path"
  }

  function cdnvm() {
    cd "$@" || return;
    nvm_path=$(find-up .nvmrc | tr -d '[:space:]')

    # If there are no .nvmrc file, use the default nvm version
    if [[ ! $nvm_path = *[^[:space:]]* ]]; then

      declare default_version;
      default_version=$(nvm version default);

      # If there is no default version, set it to `node`
      # This will use the latest version on your machine
      if [[ $default_version == "N/A" ]]; then
        nvm alias default node;
        default_version=$(nvm version default);
      fi

      # If the current version is not the default version, set it to use the default version
      if [[ $(nvm current) != "$default_version" ]]; then
        nvm use default;
      fi

      elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
      declare nvm_version
      nvm_version=$(<"$nvm_path"/.nvmrc)

      # Add the `v` suffix if it does not exists in the .nvmrc file
      if [[ $nvm_version != v* ]]; then
        nvm_version="v""$nvm_version"
      fi

      # If it is not already installed, install it
      if [[ $(nvm ls "$nvm_version" | tr -d '[:space:]') == "N/A" ]]; then
        nvm install "$nvm_version";
      fi

      if [[ $(nvm current) != "$nvm_version" ]]; then
        nvm use "$nvm_version";
      fi
    fi
  }

  alias cd='cdnvm'

  # npm completion

  # shellcheck disable=SC1090
  source <(npm completion)
fi

# rbenv

if [[ -s "$(brew --prefix rbenv)" ]]; then
  eval "$(rbenv init -)"
fi

# pyenv

if [[ -s "$(brew --prefix pyenv)" ]]; then
  eval "$(pyenv init -)"

  PYTHON2_VERSION="$(pyenv install -l | grep -e '2.[0-9].[0-9]' | grep -v '[a-z]' | tail -1 | tr -d '[:space:]')"
  PYTHON3_VERSION="$(pyenv install -l | grep -e '3.[0-9].[0-9]' | grep -v '[a-z]' | tail -1 | tr -d '[:space:]')"

  pyenv install "$PYTHON2_VERSION" --skip-existing
  pyenv install "$PYTHON3_VERSION" --skip-existing
  pyenv global "$PYTHON3_VERSION" "$PYTHON2_VERSION"
fi

# pip

if command -v pip &> /dev/null; then
  eval "$(pip completion --bash)"
fi

# pipenv

if command -v pipenv &> /dev/null; then
  eval "$(pipenv --completion)"
fi

# completion for macos "defaults" command

complete -W "NSGlobalDomain" defaults;

# completion for git alias "g"

if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  complete -o default -o nospace -F _git g;
fi;

# load bash prompt

if [ -f ~/.bash_prompt ]; then
  # shellcheck disable=SC1090
  source ~/.bash_prompt
fi
