#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
    --exclude "brew.sh" --exclude "liquidprompt/" --exclude ".vim/UltiSnips"\
		--exclude "README.md" --exclude "LICENSE-MIT.txt" --exclude "bash" -avh --no-perms . ~;
	# source ~/.bash_profile;

  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  if [ ! -d $HOME/.vim/UltiSnips ]; then
    ln -s $DOTFILES/.vim/UltiSnips $HOME/.vim/UltiSnips
  fi
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
  echo "dotfiles installed completed. Please don't forget to change your git username and email:";
  echo "    git config --global user.name \"Your Name\"";
  echo "    git config --global user.email you@example.com";
  echo "";
  echo "When you first start vim, please use :BundleInstall to install all the plugins."
  echo "Have fun!"
fi;
unset doIt;
