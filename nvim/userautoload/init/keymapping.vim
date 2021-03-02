" Key mapping

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

" Reverse showing line number
function! SwitchLineNumber()
    if &number
        set nonumber
    else
        set number
    endif
endfunction
nnoremap <C-q> :call SwitchLineNumber()<CR>

" Remove highlight by repeating ESC
vmap  <C-n> g<C-a>
