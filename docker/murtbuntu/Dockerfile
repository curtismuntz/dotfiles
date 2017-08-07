FROM ubuntu:16.04
MAINTAINER Curtis Muntz <cmuntz@outlook.com>

RUN apt-get update && apt-get install -y \
	software-properties-common \
	--no-install-recommends && \
	apt-get update && \
	apt-get install -y \
	byobu \
  git \
	curl \
	wget \
	zsh \
	tree \
	nmap \
	openssh-client \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN chsh -s $(which zsh)

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME

# install my shiiiiit
ADD id_rsa /root/.ssh/id_rsa
RUN git clone git@github.com:curtismuntz/dotfiles.git
RUN /usr/bin/setxkbmap -option "caps:swapescape"
RUN bash ~/dotfiles/setup.sh

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

COPY ./simple_zshrc $HOME/.zshrc

WORKDIR $HOME
USER user

CMD [ "zsh" ]
