"""""""""" dein.vim start """"""""""
if &compatible
    set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
if dein#load_state(expand('~/.vim/dein'))
    call dein#begin(expand('~/.vim/dein'))
" plugin load begin
    call dein#add(expand('~/.vim/dein/repos/github.com/Shougo/dein.vim'))
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    call dein#add('scrooloose/syntastic')
    call dein#add('itchyny/lightline.vim')
    call dein#add('tomasr/molokai')
    call dein#add('knockts/nerdtree_vimdiff')
    call dein#add('rhysd/vim-clang-format')
    call dein#add('kana/vim-operator-user')
    call dein#add('justmao945/vim-clang')
    call dein#add('vim-scripts/DoxygenToolkit.vim')
    call dein#add('Shougo/unite.vim')
    "call dein#add('Shougo/neocomplete')
    call dein#add('plasticboy/vim-markdown')
    call dein#add('embear/vim-localvimrc')
    call dein#add('knockts/nerdtree_vimdiff')
    call dein#add('ConradIrwin/vim-bracketed-paste')
" plugin load end
    call dein#end()
    call dein#save_state()
endif
filetype plugin indent on           " ファイルタイプ別設定実行
syntax enable                       " 構文ハイライト
"""""""""" dein.vim end """"""""""

"""""""""" set valiables begin """"""""""
set nobackup	                    " バックアップ作らない
set noswapfile	                    " swpファイル作らない
set undofile                        " vim終了後もundoできるように
set undodir=~/.vim/undodir          " vim終了後もundoできるように
set t_Co=256                        " 256色カラー表示
set number                          " 行番号表示
set encoding=utf-8                  " vim上のバッファで用いる文字コード
set fenc=utf-8                      " 書き込み時の文字コード
set fileencodings=utf-8,euc-jp,sjis " 左優先で入力の文字コード判定後fencに設定
set backspace=indent,eol,start      " BSで削除可能に
set cursorline                      " 現在の行を強調表示
set virtualedit=onemore             " 行末+1カーソル移動可能に
set showmatch                       " 対応括弧を強調表示
set laststatus=2                    " ステータスラインを常に表示
set wildmode=list:longest           " コマンドラインの補完
set incsearch                       " 検索順次ヒット
set wrapscan                        " 検索順次ヒットループ
set hlsearch                        " 検索ヒットハイライト
set expandtab                       " Tab文字を半角スペースに
set tabstop=2                       " 入力ファイル中の既存Tabの空白幅
set softtabstop=2                   " キー入力したTabの空白幅
set shiftwidth=2                    " インデント時の空白幅
set smartindent                     " c言語ベースのインデント方式
colorscheme molokai                 " カラースキーム (dein後に指定)
" 81文字目以降の背景色を変更
execute "set colorcolumn=" . join(range(81, 9999), ',') 
"""""""""" set valiables end """"""""""

" 改行時の自動コメント挿入の無効化方法
" ~/.vim/after/plugin/common.vimに以下を記載
" autocmd FileType * setlocal formatoptions-=r
" autocmd FileType * setlocal formatoptions-=o

"""""""""" set map begin """"""""""
" 折り返し時に表示行単位での移動できるように
nnoremap j gj
nnoremap k gk
" タブ関連
noremap tt :tabnew<CR>
noremap tp :tab sp<CR>
noremap <C-h> gT
noremap <C-l> gt
noremap <C-w><C-h> :tabmove -1<CR>
noremap <C-w><C-l> :tabmove +1<CR>
" ESC連打でハイライト解除
noremap <Esc><Esc> :nohlsearch<CR><Esc>
" NerdTreeショートカット
noremap <silent><C-n> :NERDTreeToggle<CR>
" clang-formatでインデント実行
map f= <Plug>(operator-clang-format)
"""""""""" set map end """"""""""

" vim-localvimrc setting
"let g:localvimrc_ask = 0        " .lvimrcを確認なしで読み込む

" clang-format setting
" アクセス指定子は1インデント分下げる
" C++11 の機能を使う
let g:clang_format#style_options = {
            \ "BasedOnStyle" : 'Google',
            \ "TabWidth" : 4,
            \ "UseTab" : 'Never',
            \ "AccessModifierOffset" : -4,
            \ "Standard" : "C++11",
            \ }

" vim-markdown settings
let g:vim_markdown_folding_disabled = 1

" deoplete boot
let g:deoplete#enable_at_startup = 1
