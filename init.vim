" dein
set runtimepath+=$XDG_CACHE_HOME/dein/repos/github.com/Shougo/dein.vim
if dein#load_state($XDG_CONFIG_HOME . '/nvim/dein')
    let g:dein#cache_directory = $XDG_CACHE_HOME . '/dein'
    let s:toml_dir  = $XDG_CONFIG_HOME . '/nvim/dein/toml' 
    let s:toml      = s:toml_dir . '/dein.toml'
    let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'
    call dein#begin($XDG_CONFIG_HOME . '/nvim/dein')
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable                       " Highlight syntastic
set nobackup	                    " Generate no backup file
set noswapfile	                    " Generate no swap file
set undofile                        " Enable to undo after rerun
set undodir=~/.cache/undodir        " Set directory stored undo file
set t_Co=256                        " 256 color
set number                          " Show line number
set encoding=utf-8                  " Character code on buffer
set fenc=utf-8                      " Character code on writing
set fencs=utf-8,euc-jp,sjis         " Set fenc in order of left first
set backspace=indent,eol,start      " Enable to delete by BS
set showmatch                       " Emphasize parentheses
set laststatus=2                    " Show status line always
set wildmode=list:longest           " Complicate command line
set incsearch                       " Incremental cursor jump in search
set wrapscan                        " Cursor loop in search
set hlsearch                        " Highlight match patten in find
set expandtab                       " Convert tab character to spaces
set tabstop=4                       " Tab width of already input tab
set softtabstop=4                   " Tab width of new input tab
set shiftwidth=4                    " Indent width
set smartindent                     " Set clang indent type
set clipboard+=unnamed              " For share clipboard with shell
set ambiwidth=double                " Draw multibyte character with 2-wide
set vb t_vb=                        " Off beep sound
set foldlevel=100                   " Disable folding
set timeout timeoutlen=1000 ttimeoutlen=50  " Accelerate mapped key that has common prefix

" Cursor settings
" Reverse color
highlight CursorLine term=reverse cterm=reverse
let &t_ti.="\e[2 q"     " Unflashing bar cursor on booted vim
let &t_SI.="\e[6 q"     " Unflashing block cursor on started insert mode
let &t_EI.="\e[2 q"     " Unflashing bar cursor on ended insert mode
let &t_te.="\e[6 q"     " Unflashing block cursor on killed vim

" Filetype settings
" Desable auto adding comment in a new line
autocmd FileType * setlocal formatoptions-=r
autocmd FileType * setlocal formatoptions-=o
" Change indent width by the filetype
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
" Not expand tab to spaces on Makefile
let _curfile=expand("%:r")
if _curfile == 'Makefile'
  set noexpandtab
endif

" Mapping
" Move 
nnoremap j gj
nnoremap k gk
" Tab settings
nnoremap tt :tabnew<CR>
nnoremap tp :tab sp<CR>
nnoremap <C-h> gT
nnoremap <C-l> gt
nnoremap <C-w><C-h> :tabmove -1<CR>
nnoremap <C-w><C-l> :tabmove +1<CR>
" Substitute for Ctrl-H over tmux
nnoremap <BS> gT
nnoremap <C-w><BS> :tabmove -1<CR>
" Remove highlight by repeating ESC
noremap <Esc><Esc> :nohlsearch<CR><Esc>
" Reverse cursorline emphasis
function! SwitchCursorLine()
    if &cursorline
        set nocursorline
    else
        set cursorline
    endif
endfunction
nnoremap <C-q> :call SwitchCursorLine()<CR>
