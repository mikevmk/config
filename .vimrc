syntax enable
set dir=/tmp
set viminfo='10,\"100,:20,%,n~/.cache/viminfo
set fileencodings=ucs-bom,utf-8,cp1251
set autoindent
set pastetoggle=<F2>
set number
set nowrap
set softtabstop=4
set shiftwidth=4
set smarttab
set noexpandtab

vmap <C-c> :!xclip -f -sel clip<CR>
map <C-v> :r!xclip -o -sel clip<CR>

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
