filetype plugin indent on
syntax enable                       " Highlight syntastic
set nobackup	                      " Generate no backup file
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
set tabstop=2                       " Tab width of already input tab
set softtabstop=2                   " Tab width of new input tab
set shiftwidth=2                    " Indent width
set smartindent                     " Set clang indent type
set clipboard+=unnamed              " For share clipboard with shell
set ambiwidth=double                " Draw multibyte character with 2-wide
set vb t_vb=                        " Off beep sound
set foldlevel=100                   " Disable folding
set timeout timeoutlen=1000 ttimeoutlen=50  " Accelerate mapped key that has common prefix
set ignorecase                      " Ignore upper/lower case in search
set smartcase                       " Consider upper/lower case if search word includes upper case
