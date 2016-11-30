set dir=/tmp
set nolist
set listchars=trail:.
set pastetoggle=<F2>
set autoindent
set nowrap
syntax enable
set foldmethod=marker
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nu!
set ruler
set autowrite
set fileencodings=ucs-bom,utf-8
setglobal fenc=utf-8
set fileencoding=utf-8
set tenc=utf-8
set enc=utf-8
set viminfo='10,\"100,:20,%,n~/.viminfo
colorscheme ron
runtime macros/justify.vim

set smarttab
augroup Binary
  au!
  au BufReadPre  *.hex let &bin=1
  au BufReadPost *.hex if &bin | %!xxd
  au BufReadPost *.hex set ft=xxd | endif
  au BufWritePre *.hex if &bin | %!xxd -r
  au BufWritePre *.hex endif
  au BufWritePost *.hex if &bin | %!xxd
  au BufWritePost *.hex set nomod | endif
augroup END

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

