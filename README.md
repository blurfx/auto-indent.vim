# auto-indent.vim
Vim plug-in that automatically detects and sets indentation level

## Installtion

### Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
" .vimrc

Plug 'blurfx/auto-indent.vim'
```

## Customization

### Options

```vim
" The plugin follows the detected indentation.
" but if it's not detected, it follows fallback configuration.

" Fallback indentation type. (0: space, 1: tab)
" If you are using a tab indent, set it to 1.
" (default value: 0)
let g:autoindent_expandtab = 0

" Indent space size / tab width
" (default value: 2 for spaces, 4 for tab width)
let g:autoindent_indent_space_size = 2
let g:autoindent_indent_tab_size = 4
```

### Callback

If you want to do additional work with the detected indentation, define the callback function `AutoIndentCallback`.

```vim
function! AutoIndentCallback(indent)
  " {'type': 'tab': 'size': 1}
  echom a:indent
endfunction
```

#### Arguments

| Arugment | Type    | Description |
|----------|---------|-------------|
| indent   | `{'type': 'space' \| 'tab', 'size': number}`| - |

