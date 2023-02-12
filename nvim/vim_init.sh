#!/bin/bash

if [ -n "$(command -v apt)" ]; then
    sudo apt install neovim nodejs npm clangd clang-tools
elif [ -n "$(command -v dnf)" ];then
    sudo dnf install neovim nodejs npm clang-tools-extra
elif [ -n "$(command -v pacman)" ]; then
    sudo pacman -S cmake make gcc neovim nodejs npm clang-tools-extra python-pip
else
    echo "Undefined package manager!!!"
fi
python3 -m pip install --user --upgrade pynvim

readonly VIM_CONFIG=~/.config/nvim/init.vim
readonly VIM_CONF_PATH='vim_config'

readonly BASH_LOCAL="
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
"

cp .clang_format ~

rm -f "${VIM_CONFIG}"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p ~/.config/nvim/
cat 'vim_config/plugins.vim' > "${VIM_CONFIG}"

nvim +PlugInstall +qall

for file in vim_config/config/*; do
    cat "${file}" >> "${VIM_CONFIG}"
done

nvim -c "CocInstall -sync coc-clangd coc-tsserver coc-json coc-html coc-css coc-pyright" +qall

if [ ! -f '~/.bash_local' ]; then
    echo "${BASH_LOCAL}" >> ~/.bashrc
fi
cp bash_config/.bash_local "${HOME}"

