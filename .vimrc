call pathogen#infect()

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

syntax enable         " Enable syntax highlighting

" Use Solarized colors
set background=dark
colorscheme solarized

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" :alias
com VR :vertical resize 80
