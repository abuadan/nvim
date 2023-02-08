#!/usr/bin/env bash

### This script is to delete all nvim relatede folder and paths and
## start with a fresh nvim packer install

rm -rf ~/.local/share/nvim/
rm -rf ~/.local/state/nvim/
rm -rf ~/.cache/nvim/
rm ~/.config/nvim/plugin/packer_compiled.lua
