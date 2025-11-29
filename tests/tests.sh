#!/bin/sh
set -e

green() { printf '\033[1;32m%s\033[0m' "$1"; }

echo "=== Running basic environment tests ==="

echo "$(green 'Test'): git"
git --version

echo "$(green 'Test'): jq"
jq --version

echo "$(green 'Test'): devops-test directory"
ls -la /workspace/devops-test
cd /workspace/devops-test

echo "$(green 'Test'): git config (name/email)"
git config --global user.name || echo "user.name not set"
git config --global user.email || echo "user.email not set"

echo "$(green 'Test'): zsh"
zsh --version

echo "$(green 'Test'): Oh My Zsh"
zsh -ic "echo \$ZSH"
