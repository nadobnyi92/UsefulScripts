call plug#begin()

Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/vim-clang-format'
Plug 'itspriddle/vim-shellcheck'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

call plug#end()            " required
