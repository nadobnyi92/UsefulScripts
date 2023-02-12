let g:clang_format#style_options = {
            \ "BasedOnStyle": "LLVM",
            \ "IndentWidth": 4,
            \ "BreakBeforeBraces" : "Custom",
            \ "BraceWrapping" : {
                \ "AfterClass" : "true",
                \ "AfterEnum" : "true",
                \ "AfterStruct" : "true",
                \ "AfterUnion" : "true",
                \ "AfterNamespace" : "true",
                \ "AfterFunction" : "true",
                \ }
            \ }

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

autocmd FileType c ClangFormatAutoEnable

