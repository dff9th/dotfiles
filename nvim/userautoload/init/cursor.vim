" Cursor settings

" Reverse color
highlight CursorLine term=reverse cterm=reverse
let &t_ti.="\e[2 q"     " Unflashing bar cursor on booted vim
let &t_SI.="\e[6 q"     " Unflashing block cursor on started insert mode
let &t_EI.="\e[2 q"     " Unflashing bar cursor on ended insert mode
let &t_te.="\e[6 q"     " Unflashing block cursor on killed vim
