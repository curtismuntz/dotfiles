#!/usr/bin/env
set -eux

install_lutris() {
	sudo add-apt-repository ppa:lutris-team/lutris
	sudo apt update
	sudo apt install lutris

	# https://github.com/lutris/lutris/wiki/Installing-drivers
	sudo add-apt-repository ppa:graphics-drivers/ppa
	sudo dpkg --add-architecture i386
	sudo apt update
	sudo apt install -y nvidia-driver-430 libnvidia-gl-430 libnvidia-gl-430:i386
	sudo apt install -y libvulkan1 libvulkan1:i386
}

install_bnet_deps() {
  sudo apt install -y libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libsqlite3-0:i386
}

install_lutris
install_deps
