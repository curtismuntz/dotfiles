# dotfiles
An example can be seen in the dockerfile for murtbuntu for how to set up my work environment.


# todo:
* vundle
* murtbuntu mounting scheme
* installer for all things
* buildifier
* resin
* extras
  * hack font
    * `sudo apt-get install fonts-hack-ttf`

# basic installs
```!bash
sudo apt install -y zsh \
                        git \
                        tree \
                        curl \
                        vim \
                        nmap \
                        nfs-common \
                        openssh-client \
                        golang-go \
                        ctop \
                        clang-format \
                        python \
                        python3 \
                        python3-pip \
                        python3-tk \
                        rsync \
                        silversearcher-ag \
                        tilix
sudo pip3 install virtualenv
chsh -s $(which zsh)
```

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

## docker
From https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
```!bash
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-compose
sudo usermod -aG docker `whoami`
```

## bazel
From https://docs.bazel.build/versions/master/install-ubuntu.html

```!bash
sudo apt-get install -y openjdk-8-jdk
echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install -y bazel
```

### buildifier
From https://github.com/bazelbuild/buildtools/tree/master/buildifier
```!bash
sudo apt-get install -y golang-go
go get github.com/bazelbuild/buildtools/buildifier
```

### cmake
```!bash
sudo add-apt-repository ppa:george-edison55/cmake-3.x -y
sudo apt-get update && sudo apt-get install cmake -y
```

## oh-my-zsh
From https://github.com/robbyrussell/oh-my-zsh#basic-installation
```!bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

## resin cli
https://nodejs.org/en/

```!bash
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install --global --production resin-cli
```

# snap installs
## slack
```!bash
snap install spotify
snap install slack --classic
snap install discord
snap install atom --classic
```

# steam
http://store.steampowered.com/about/
