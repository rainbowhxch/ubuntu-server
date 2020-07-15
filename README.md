# My ubuntu server's dotfiles

Just some configuration about my ubuntu server.

## What you need to do

when you first get you ubuntu server, just run:
```bash
sudo apt update
sudo apt upgrade
sudo add-apt-repository ppa:lazygit-team/release
sudo apt update
sudo apt install neovim ranger lazygit neofetch htop npm zsh
pip3 install pynvim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://www.github.com/rainbowhxch/ubuntu-server
mv ubuntu-server .config
```
then, enjoy.

## LICENSE

MIT
