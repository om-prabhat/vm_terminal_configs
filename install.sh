#!/bin/bash

zsh="[+] Downloading zsh."

for ((i=0; i<${#zsh}; i++)); do
    echo -n "${zsh:$i:1}"
    sleep 0.05
done
echo ""
sudo apt install zsh -y



oh_my_zsh="[+] Downloading oh_my_zsh."

for ((i=0; i<${#oh_my_zsh}; i++)); do
    echo -n "${oh_my_zsh:$i:1}"
    sleep 0.05
done
echo ""
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && chmod +x ~/.oh-my-zsh/oh-my-zsh.sh
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

configure="[+] Configuring your zsh."

for ((i=0; i<${#configure}; i++)); do
    echo -n "${configure:$i:1}"
    sleep 0.05
done
echo ""

cp zshrc.new ~/.zshrc
cp alias.new ~/.alias
cp bash_zsh.zsh-theme ~/.oh-my-zsh/themes/bash_zsh.zsh-theme
chsh -s $(which zsh)

tmux="[+] Installing tmux..."

for ((i=0; i<${#tmux}; i++)); do
    echo -n "${tmux:$i:1}"
    sleep 0.05
done
echo ""

sudo apt install tmux xclip dconf-cli

cp tmux.conf ~/.tmux.conf

tmux_plugin="[+] adding tmux plugin manager..."
for ((i=0; i<${#tmux_plugin}; i++)); do
    echo -n "${tmux_plugin:$i:1}"
    sleep 0.05
done
echo

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Press Prefix+I inside tmux to install the plugins"

icons_install="[+] Installing icons in terminal..."
for ((i=0; i<${#icons_install}; i++)); do
    echo -n "${icons_install:$i:1}"
    sleep 0.05
done
echo

cd ~/ && git clone https://github.com/sebastiencs/icons-in-terminal.git
cd icons-in-terminal && chmod +x install.sh
~/icons-in-terminal/install.sh

setup_done="[-] D0ne!"
for ((i=0; i<${#setup_done}; i++)); do
    echo -n "${setup_done:$i:1}"
    sleep 0.05
done
echo

exit_txt="Exiting Script Now..."
for ((i=0; i<${#exit_txt}; i++)); do
    echo -n "${exit_txt:$i:1}"
    sleep 0.05
done
echo

echo "Reopen terminal now."
