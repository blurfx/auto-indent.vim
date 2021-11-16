function! autoindent#get_leading_spaces(text)
  let spaces = matchstrpos(a:text, '^\s*')
  let is_tab = 0
  let is_space = 0

  if stridx(spaces[0], '	') > -1
    let is_tab = 1
  endif 

  if stridx(spaces[0], ' ') > -1
    let is_space = 1
  endif 
  
  if !xor(is_tab, is_space)
      return {}
  endif

  let indent_type = is_tab ? 'tab' : 'space'
  let indent_size = spaces[2] - spaces[1]
  return {'type': indent_type, 'size': indent_size}
endfunction

function! autoindent#detect_indent(lines)
  let indents = {}
  let last_indent_size = 0

  for line in a:lines
    let indent_info = autoindent#get_leading_spaces(line)
    if len(indent_info) == 0
      continue
    endif

    let indent = abs(indent_info.size - last_indent_size)

    if indent > 0
      let key = indent_info.type . '#' . indent
      if has_key(indents, key)
        let indents[key] = 1 + indents[key]
      else
        let indents[key] = 1
      endif
    endif

    let last_indent_size = indent_info.size
  endfor

  let indent = ''
  let maxi = 0

  for [size, score] in items(indents)
    if score > maxi
      let indent = size
      let maxi = score
    endif
  endfor

  if indent == ''
    return {'type': 'unknown', 'size': 0}
  endif 

  let [type, size] = split(indent, '#')
  return {'type': type, 'size': str2nr(size, 10)}
endfunction


function! autoindent#set_indent(indent)
  let indent = copy(a:indent)
  if indent.type == 'tab'
    let indent.size = g:autoindent_indent_tab_size
    silent setlocal noexpandtab
  elseif indent.type == 'space'
    silent setlocal expandtab
  endif

  let &tabstop = indent.size
  let &shiftwidth = indent.size
  let &softtabstop = indent.size
  silent setlocal tabstop? shiftwidth? softtabstop?
endfunction


function! autoindent#bootstrap()
  let lines = getline(1, 300)
  let indent = autoindent#detect_indent(lines)

  if indent.type == 'unknown'
    let indent_type = g:autoindent_expandtab ? 'tab' : 'space'
    
    if indent_type == 'tab'
      let indent_size = 1
    else
      let indent_size = g:autoindent_indent_space_size
    endif
    
    let indent = {'type': indent_type, 'size': indent_size} 
  endif

  call autoindent#set_indent(indent)

  if exists('*AutoIndentCallback')
    call AutoIndentCallback(indent)
  endif
endfunction
