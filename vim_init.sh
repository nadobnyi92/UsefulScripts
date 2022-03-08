#!/bin/bash

BASE_INIT="
\" set the runtime path to include Vundle and initialize
call plug#begin()

Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/vim-clang-format'
Plug 'itspriddle/vim-shellcheck'

\" All of your Plugins must be added before the following line
call plug#end()            \" required
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

\" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
\" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
\" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

autocmd FileType c ClangFormatAutoEnable

\" if hidden is not set, TextEdit might fail.
set hidden

\" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

\" Better display for messages
set cmdheight=2

\" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

\" don't give |ins-completion-menu| messages.
set shortmess+=c

\" always show signcolumns
set signcolumn=yes

\" Use tab for trigger completion with characters ahead and navigate.
\" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? \"\<C-n>\" :
      \ <SID>check_back_space() ? \"\<TAB>\" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? \"\<C-p>\" : \"\<C-h>\"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

\" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

\" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
\" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? \"\<C-y>\" : \"\<C-g>u\<CR>\"

\" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

\" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

\" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

\" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

\" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

\" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  \" Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  \" Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

\" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

\" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
\" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

\" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

\" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

\" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

\" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

\" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

\" Using CocList
\" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
\" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
\" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
\" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
\" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
\" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
\" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
\" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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

readonly VIM_CONFIG=~/.config/nvim/init.vim

rm -f "${VIM_CONFIG}"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p ~/.config/nvim/
echo "${BASE_INIT}" > "${VIM_CONFIG}"

nvim +PlugInstall +qall

echo "${FULL_INIT}" >> "${VIM_CONFIG}"

echo "${BASH_LOCAL}" >> ~/.bashrc

echo "${BASH_COMMANDS}" > ~/.bash_local

