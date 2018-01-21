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
sudo apt-get install -y zsh \
                        git \
                        tree \
                        curl \
                        vim \
                        nmap \
                        openssh-client \
                        terminator
```

# more complex installs
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
sudo apt-get install -y docker-ce
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

## oh-my-zsh
From https://github.com/robbyrussell/oh-my-zsh#basic-installation
```!bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## spotify
From https://www.spotify.com/us/download/linux/
```!bash
# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages
sudo apt-get update

# 4. Install Spotify
sudo apt-get install -y spotify-client
```

# downloaded installers
## slack
https://slack.com/downloads/linux
## discord
https://discordapp.com/download
