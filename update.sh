#! /bin/bash

echo "Copying configs" 
mkdir -p nvim
cp ~/.config/nvim/init.lua nvim/
cp ~/.zshrc .

echo "Pushing to git"

git add .
git commit -m "Updating configs"
git push 

