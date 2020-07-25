# My ubuntu server's dotfiles

Just some configuration about my ubuntu server.

## What you need to do

when you first get you ubuntu server, just run:
```bash
sudo apt update
sudo apt upgrade
sudo add-apt-repository ppa:lazygit-team/release
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim lazygit neofetch htop npm nodejs zsh fzf gdb gcc git clangd
pip3 install pynvim ranger-fm
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://www.github.com/rainbowhxch/ubuntu-server
mv ubuntu-server .config
sudo reboot
```
then, enjoy.

## LICENSE

MIT
