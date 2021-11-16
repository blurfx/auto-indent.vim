if !exists('g:autoindent_expandtab')
  let g:autoindent_expandtab = 0
endif

if !exists('g:autoindent_indent_size')
  let g:autoindent_indent_size = 2
endif

autocmd BufEnter,BufWritePost * call autoindent#bootstrap()