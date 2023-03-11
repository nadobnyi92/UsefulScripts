" NERDTree
" Открывать дерево по нажаить Ctrl+n
map <c-n> :NERDTreeToggle<cr>
" Немного магии, если мы запустим Vim без указания файла для редактирования,
" то дерево будет открыто, а если будет указан файл, то дерево 
" открыто не будет
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Открывать новые окна справа
set splitright

" игнорировать сгенерированные файлы
let NERDTreeIgnore=['\(\.o$\|\.lo$\|\.d$\)\@<=[[file]]']

nmap <C-F>f <Plug>CtrlSFPrompt
nmap <C-F>n <Plug>CtrlSFCwordPath
nmap <C-F>p <Plug>CtrlSFPwordPath

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

set listchars=eol:¶,tab:>·,trail:~,extends:>,precedes:<,space:·
set list

let NERDTreeShowHidden=1

