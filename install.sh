#!/bin/bash

mkdir ~/dotfiles/backup
echo "backing up current dotfiles to ~/dotfiles/backup..."
mv "$HOME/.bashrc" "$HOME/dotfiles/backup"
mv "$HOME/.zshrc" "$HOME/dotfiles/backup"
mv "$HOME/.profile" "$HOME/dotfiles/backup"
mv "$HOME/.tmux.conf" "$HOME/dotfiles/backup"
mv "$HOME/.vimrc" "$HOME/dotfiles/backup"
mv "$HOME/.p10k.zsh" "$HOME/dotfiles/backup"

echo "symlinking dotfiles"
ln -s "$HOME/dotfiles/.bashrc" "$HOME/.bashrc"
ln -s "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
ln -s "$HOME/dotfiles/.profile" "$HOME/.profile"
ln -s "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
ln -s "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"
ln -s "$HOME/dotfiles/.p10k.zsh" "$HOME/.p10k.zsh"

echo "installing zsh plugins"
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
git clone https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/zsh-syntax-highlighting"
mv "$HOME/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/"

## install miniconda if no anaconda/miniconda already
if [ ! -d "$HOME/anaconda3" ] && [ ! -d "$HOME/miniconda3" ] 
then
	echo "installing miniconda..."
	mkdir -p "$HOME/miniconda3"
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O "$HOME/miniconda3/miniconda.sh"
	bash ~/miniconda3/miniconda.sh -b -u -p "$HOME/miniconda3"
	rm -rf "$HOME/miniconda3/miniconda.sh"
	"$HOME/miniconda3/bin/conda" init bash
	"$HOME/miniconda3/bin/conda" init zsh
fi

pip install powerline-status
