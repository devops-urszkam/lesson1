#!/bin/sh
set -e

# update the system
apt update && apt upgrade -y

# install tools
apt install -y \
    git \
    curl \
    wget \
    unzip \
    htop \
    tree \
    jq \
    zsh

# Oh My Zsh installation + plugins
RUNZSH=no \
CHSH=no \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions \
    ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# git config
git config --global user.name "${GIT_NAME}"
git config --global user.email "${GIT_EMAIL}"

git config --global alias.s "status -s"
git config --global alias.lg "log --oneline --graph --decorate"
git config --global alias.amend "commit --amend --no-edit"
git config --global alias.undo "reset HEAD~1 --mixed"

# set up the test project
mkdir -p /workspace/devops-test
cd /workspace/devops-test

git init
