# AutoIndent.vim
Vim plug-in that automatically recognizes and sets indentation level

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

" Fallback indentation type.
" If you are using a tab indent, set it to 1.
" (default is 0)
let g:autoindent_expandtab = 0

" Fallback indent size
" (default is 2)
let g:autoindent_indent_size = 2
```

### Callback

Define the callback function `AutoIndentCallback` if you want to do additional work with the detected indentation information.
                                                                            |
```vim
function! AutoIndentCallback(indent)
  echom a:indent " {'type': 'tab': 'size': 4}
endfunction
```

#### Arguments
| Arugment | Type    | Description |
|----------|---------|-------------|
| indent   | `{'type': 'space' \| 'tab', 'size': number}` | If `g:autoindent_expandtab` is `1`, `indent.size` is always the same as `g:autoindent_indent_size`. |

