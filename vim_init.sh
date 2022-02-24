#!/bin/bash

BASE_INIT="
set nocompatible
filetype off

\" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'https://github.com/tpope/vim-fugitive'

\" All of your Plugins must be added before the following line
call vundle#end()            \" required
filetype plugin indent on    \" required
\" Put your non-Plugin stuff after this line
"

FULL_INIT="
\" Позволим конфигурационным файлам в проекте изменять настройки vim'a
\" Включим чтение конфигурационных файлов .vimrc в текущей директории
set exrc
\" Запретим опасные команды в локальных .vimrc файлах (эта опция должна идти в вашем 
\" ~/.vimrc после запрещаемых команд, таких как write)
set secure 

\" Отступы пробелами, а не табуляциями
set expandtab
\" Ширина строки 120 символов
set textwidth=120
\" Ширина табуляции в колонках
set ts=4
\" Количество пробелов (колонок) одного отступа
set shiftwidth=4
\" Новая строка будет с тем же отступом, что и предыдущая
set autoindent
\" Умная расстановка отступов (например, отступ при начале нового блока)
set smartindent

\" Подсвечивать синтаксис
syntax on
\" Указывать номера строк
set number
\" Подсветить максимальную ширину строки
let &colorcolumn=&textwidth
\" Цвет линии - тёмно-серый
highlight ColorColumn ctermbg=darkgray

\" Игнорировать регистр при поиске
set ic
\" Подсвечивать поиск
set hls
\" Использовать последовательный поиск
set is

\" Включаем bash-подобное дополнение командной строки
set wildmode=longest:list,full

\" Не делать все окна одинакового размера
set noequalalways
\" Высота окон по-умолчанию 20 строк
set winheight=20

set fileencoding=utf-8

set foldmethod=syntax
au BufRead * normal zR

\" С/C++ файлы
\" Расставлять отступы в стиле С
autocmd filetype c,cpp set cin

\" make-файлы
\" В make-файлах нам не нужно заменять табуляцию пробелами
autocmd filetype make set noexpandtab
autocmd filetype make set nocin

\" html-файлы
\" Не расставлять отступы в стиле С в html файлах
autocmd filetype html set noexpandtab
autocmd filetype html set nocin
autocmd filetype html set textwidth=160

\" css-файлы
\" Не расставлять отступы в стиле C и не заменять табуляцию пробелами
autocmd filetype css set nocin
autocmd filetype css set noexpandtab

\" python-файлы
\" Не расставлять отступы в стиле С
autocmd filetype python set nocin

\" NERDTree
\" Открывать дерево по нажаить Ctrl+n
map <c-n> :NERDTreeToggle<cr>
\" Немного магии, если мы запустим Vim без указания файла для редактирования,
\" то дерево будет открыто, а если будет указан файл, то дерево 
\" открыто не будет
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists(\"s:std_in\") | NERDTree | endif
\" Открывать новые окна справа
set splitright

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

set listchars=eol:¶,tab:>·,trail:~,extends:>,precedes:<,space:·
set list

colorscheme space-vim-dark

"

BASH_LOCAL="
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi
"

BASH_COMMANDS="
#!/bin/bash

bind '\"\\e[A\":history-search-backward'
bind '\"\\e[B\":history-search-forward'

"

rm -Rf ~/.vim*

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone git@github.com:rafi/awesome-vim-colorschemes.git tmp #TODO temp directory
mv tmp/* ~/.vim/

echo "${BASE_INIT}" > ~/.vimrc

vim +PluginInstall +qall

echo "${FULL_INIT}" >> ~/.vimrc

echo "${BASH_LOCAL}" >> ~/.bashrc

echo "${BASH_COMMANDS}" > ~/.bash_local

