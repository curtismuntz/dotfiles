# Devlopment environment for murtis or murtis like persons

FROM ubuntu:16.04
MAINTAINER Curtis Muntz <cmuntz@outlook.com>

# update ubuntu
RUN apt-get update && apt-get upgrade -y --no-install-recommends

# usability installs
RUN apt-get install -y \
	software-properties-common \
	--no-install-recommends && \
	apt-get update && \
	apt-get install -y \
  iputils-ping \
	byobu \
	git \
	curl \
	wget \
	zsh \
	tree \
	nmap \
	openssh-client \
	vim \
	sudo \
	--no-install-recommends

# cleanup from all the apt stuff...
RUN rm -rf /var/lib/apt/lists/*

# change shell to zsh
RUN chsh -s $(which zsh)

# create a user for us to fuk wit
ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME
# stupid password
RUN echo "user:password" | chpasswd
RUN usermod -aG sudo user

# TODO: remove this step when I move dotfiles public
# ssh keys
COPY id_rsa $HOME/.ssh/id_rsa
COPY id_rsa.pub $HOME/.ssh/id_rsa.pub
RUN chown -R user $HOME/.ssh/
RUN chmod 0400 $HOME/.ssh/id_rsa

######################
# install my shiiiiit
######################
USER user

RUN touch $HOME/.ssh/known_hosts
RUN touch $HOME/.z

# Add github key
RUN ssh-keyscan github.com >> $HOME/.ssh/known_hosts

# clone dotfiles
RUN git clone git@github.com:curtismuntz/dotfiles.git $HOME/murt/dotfiles

ENV ZSH_CUSTOM $HOME/.oh-my-zsh/custom
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# run dotfile setup
RUN bash ~/murt/dotfiles/setup.sh

# make a sandbox
RUN mkdir $HOME/sbox

WORKDIR $HOME
CMD [ "zsh" ]
