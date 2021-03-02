"" LSP with coc
" 'coc-python' uses python-language-server in default.
"
" You need to set up pip/pipenv and install:
" - python-language-server (include jedi)
" - pylint
" - black

" Extensions
let g:coc_global_extensions = [
  \'coc-python',
  \'coc-json',
  \'coc-toml',
  \'coc-prettier',
  \'coc-eslint',
  \'coc-tsserver',
  \'coc-vimlsp',
  \]

let g:markdown_fenced_languages = [
  \ 'vim',
  \ 'help'
  \]

" Format whole/selected code
nnoremap = :call CocAction('format')<CR>
vnoremap = <Plug>(coc-format-selected)

" Run completion manuallty
inoremap <silent><expr> <c-f> coc#refresh()

" Jump to definition
nnoremap <C-f> <Plug>(coc-definition)

" Hover
nnoremap <C-b> :call CocAction('doHover')<CR>


"" Status line with coc
"set statusline^=%{coc#status()}

let g:lightline = {
\ 'active': {
\   'left': [
\     [ 'mode', 'paste' ],
\     [ 'readonly', 'filename', 'modified' ],
\     [ 'coc_errors', 'coc_warnings', 'coc_ok' ],
\     [ 'coc_status' ]
\   ],
\ },
\ 'component_function': {
\   'filename': 'LightlineFilename'
\ }
\}

" Draw filename with relative path
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" Use autocmd to force lightline update
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Register compoments
call lightline#coc#register()
