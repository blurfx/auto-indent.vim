if !exists('g:autoindent_expandtab')
  let g:autoindent_expandtab = 0
endif

if !exists('g:autoindent_indent_space_size')
  let g:autoindent_indent_space_size = 2
endif

if !exists('g:autoindent_indent_tab_size')
  let g:autoindent_indent_tab_size = 4
endif

autocmd BufEnter,BufWritePost * call autoindent#bootstrap()