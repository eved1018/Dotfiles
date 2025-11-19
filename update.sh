#! /bin/bash

cwd=$(pwd)
cd /Users/evanedelstein/Documents/CodingProjects/dotfiles/
echo "Copying configs" 
mkdir -p nvim
cp ~/.config/nvim/init.lua nvim/
cp ~/.zshrc .
cp ~/.clang-format .
echo "Pushing to git"

git add .
git commit -m "Updating configs"
git push 

cd $cwd
