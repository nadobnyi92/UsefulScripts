#!/bin/bash

# sudo apt install neovim nodejs npm clangd clang-tools
sudo dnf install neovim nodejs npm clang-tools-extra

readonly VIM_CONFIG=~/.config/nvim/init.vim
readonly VIM_CONF_PATH='vim_config'

readonly BASH_LOCAL="
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
"

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

