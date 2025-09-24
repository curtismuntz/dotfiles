# Setup

Assumptions

Install nix:

```
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

Enable flakes:

```
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
```

Install home manager

```
VERSION=25.05
nix-channel --add https://github.com/nix-community/home-manager/archive/release-$VERSION.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

Clone this repo:

```
git clone git@github.com:curtismuntz/dotfiles && cd dotfiles
```

Build the flake:

```
home-manager switch --flake .#murt
```

Set zsh as shell:

```
command -v zsh | sudo tee -a /etc/shells
chsh -s $(which zsh)
```
