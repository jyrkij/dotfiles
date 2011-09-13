" os x backspace fix
set backspace=indent,eol,start
"set t_kb
fixdel

" tabs -> spaces
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" turn mouse on
" set mouse=a

" misc
"set ai
set nohls
set incsearch
set showcmd
set nowrap

syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

call pathogen#infect()

" :alias
com VR :vertical resize 80
