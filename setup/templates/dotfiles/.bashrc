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

if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    # shellcheck disable=SC1090
    source "$(brew --prefix)/etc/bash_completion"
fi

bind "set show-all-if-ambiguous on"

# nvm

if [[ -s "$(brew --prefix nvm)" ]]; then
    # shellcheck disable=SC1090
    source "$(brew --prefix nvm)/nvm.sh"
    NODE_VERSION=$(nvm current)
    nvm alias default "$NODE_VERSION" > /dev/null

    # fix for homebrew nvm

    if [ -f "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ]; then
        # shellcheck disable=SC1090
        source "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
    fi

    # npm completion

    npm completion > /dev/null
fi

# rbenv

if [[ -s "$(brew --prefix rbenv)" ]]; then
    eval "$(rbenv init -)"
fi

# pyenv

if [[ -s "$(brew --prefix pyenv)" ]]; then
    eval "$(pyenv init -)"
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
