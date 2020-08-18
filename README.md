# My ubuntu server's dotfiles

Just some configuration about my ubuntu server.
Run the commands below, then you can get a comfortable ubuntu server.

## What you need to do

when you first get you ubuntu server, just run:
```bash
# update existed packages and add your owen user
apt update
apt upgrade
adduser 'yourusername' # replace 'yourusername' to your user name
usermod -a -G sudo 'yourusername'
su - 'yourusername'

# install some apps
sudo apt install software-properties-common
sudo add-apt-repository ppa:lazygit-team/release
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim lazygit neofetch htop npm nodejs zsh fzf gdb gcc git clangd locate exuberant-ctags
sudo updatedb
pip3 install pynvim neovim-remote ranger-fm

# get my ubuntu server dotfiles
git clone https://www.github.com/rainbowhxch/ubuntu-server ~/.config

# make a nice zsh environment
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://www.github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
git clone https://www.github.com/zsh-users/zsh-completions ~/.oh-my-zsh/plugins/zsh-completions
git clone https://www.github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
cp -f ~/.config/zsh/.zshrc ~/.zshrc
cp -f ~/.config/zsh/.zprofile ~/.zprofile

# reboot and enjoy
sudo reboot
```
then, enjoy.

## LICENSE

MIT
