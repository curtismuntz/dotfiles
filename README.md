# dotfiles
An example can be seen in the dockerfile for murtbuntu for how to set up my work environment.

# bluetooth to bose headphones

https://askubuntu.com/questions/833322/pair-bose-quietcomfort-35-with-ubuntu-over-bluetooth

# more complex installs
## cinnamon
From http://www.omgubuntu.co.uk/2017/05/install-cinnamon-3-4-ubuntu-ppa
```!bash
sudo add-apt-repository ppa:embrosyn/cinnamon
sudo apt update && sudo apt install cinnamon
```

## themes
Download the deb file from here and install it http://www.ravefinity.com/p/vivacious-colors-gtk-icon-theme.html

```!bash
sudo apt install arc-theme
```

## vim
From https://github.com/VundleVim/Vundle.vim#quick-start
```!bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

## oh-my-zsh plugins
```!bash
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

## resin cli
https://nodejs.org/en/

```!bash
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install --global --production resin-cli
```

# steam
http://store.steampowered.com/about/
