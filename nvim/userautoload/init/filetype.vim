" Filetype settings

" Disable auto adding comment in a new line
autocmd FileType * setlocal formatoptions-=r
autocmd FileType * setlocal formatoptions-=o
autocmd FileType * setlocal indentkeys-=0#

" Change indent width by the filetype
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufReadPost Makefile setlocal noexpandtab
augroup END

" Html indent
let g:html_indent_style1 = "inc"
