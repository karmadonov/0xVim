" Use Vim improvements
set nocompatible

" Set Insert Mode by default
start

" Allows use of the X11 clipboard
set clipboard=unnamedplus

" Disable swaping and backup (.swp и ~)
set nobackup
set noswapfile

" Enable file type detection
filetype on
" Enable loading the plugin files for specific file types
filetype plugin on
" Enable loading the indent file for specific file types
filetype indent on

syntax on  " Syntax highlighting ON
set autoread  " Watch for file changes by other programs


" PEP8: Style Guide for Python Code -------------------------------------------
" Use 4 spaces per indentation level
set tabstop=4
set shiftwidth=4
set smarttab
" For new projects, spaces-only are strongly recommended over tabs
set expandtab
set softtabstop=4
" Copy indent from current line when starting a new line
set autoindent

" Use all possible Python highlighting
let python_highlight_all = 1
" Set number of available colors
set t_Co=256

" Remove trailing white space on save (only in .py files)
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

" Limit all lines to a maximum of 79 characters
:match ErrorMsg '\%>79v.\+'


" Omni completion provides smart autocompletion for programs ------------------
set ofu=syntaxcomplete#Complete

" Smart mapping for tab completion VimTip102
function! Smart_TabComplete()
  let line = getline('.')                       " current line
  let substr = strpart(line, -1, col('.')+1)    " from the start of the current
                                                " line to one character right
                                                " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")     " word till cursor
  if (strlen(substr)==0)                    " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1    " position of period, if any
  let has_slash = match(substr, '\/') != -1     " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                       " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                       " file matching
  else
    return "\<C-X>\<C-O>"                       " plugin matching
  endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Make Vim completion popup menu work just like in an IDE VimTip1386
:set completeopt=longest,menuone,preview
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" Set copy and paste using Ctrl+C/Ctrl+V --------------------------------------
vmap <C-C> "+yi
imap <C-V> "+gPi

set backspace=2 " make backspace work like most other apps


" Theme and Appearance --------------------------------------------------------
set bg=dark
let g:zenburn_high_Contrast = 1
let g:liquidcarbon_hight_contrast = 1
let g:molokai_original = 1
colorscheme molokai

" Show line numbers
set nu

" Word wrapping
set wrap
set linebreak
set nolist  " list disables linebreak
" Mouse settings
set mouse=a  " enable mouse
set mousehide  " hide the mouse when typing text

" Working with Unicode: Tip 246
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" Disable beep and flash: Tip 418
set noerrorbells visualbell t_vb=

" Removes tabline
set showtabline=0

" Folding
"set foldmethod=indent
"set foldcolumn=1

" pathogen.vim: manage your runtimepath
call pathogen#infect()

