call pathogen#infect()

set nocompatible

" os x backspace fix
set backspace=indent,eol,start
"set t_kb
fixdel

" tabs -> spaces
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" force unix-style line breaks
set fileformat=unix

" Tell vim to remember certain things when we exit
"  '10 : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20 : up to 20 lines of command-line history will be remembered
"  % : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='100,\"100,:20,%,n~/.viminfo
" This autocommand jumps to the last known position in a file
" just after opening it, if the '"' mark is set:
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

filetype on           " Enable filetype detection

if has("autocmd")
  filetype plugin indent on " indents behaviour depends on type
else
  set autoindent        " auto indents next new line
endif

" turn mouse on
" set mouse=a

" searching
set nohlsearch          " dont highlight all search results
set incsearch           " increment search
set ignorecase          " case-insensitive search
set smartcase           " upper-case sensitive search

" formatting
set backspace=2         " full backspacing capabilities
set history=100         " 100 lines of command line history
set cmdheight=1         " command line height
set laststatus=1        " occasions to show status line, 2=always.
set ruler               " ruler display in status line
set showmode            " show mode at bottom of screen
set showcmd             " display some infos (in visual)
set number              " show line numbers
set showmatch           " show matching brackets (),{},[]
set ww=<,>,[,]          " whichwrap -- left/right keys can traverse up/down

" backup handling
set backup
set backupdir=~/.vim/.backup
set directory=~/.vim/.swp

" wrapping
set textwidth=75
set linebreak
set wrap

" syntax highlighting
syntax enable         " Enable syntax highlighting
" Use Solarized colors
set background=dark
colorscheme solarized

" strip ^M linebreaks from dos formatted files
map M :%s/$//g

" highlight redundant whitespaces and tabs.
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t\|\t/

" gvim settings
"set guioptions-=T" Disable toolbar icons
set guifont=Dejavu\ Sans\ Mono\ 10 " backslash spaces
"set lines=30
"set columns=95

" F5 toggles spell checking
:map <F5> :setlocal spell! spelllang=en<cr>
:imap <F5> <C-o>:setlocal spell! spelllang=en<cr>

" insert new line
map <S-Enter> O<ESC> " inserts new line [before the current line] without
                     " entering insert mode
map <Enter> o<ESC>   " and after

" cursor highlight
set cursorline

" cursor movement
" make cursor move by visual lines instead of file lines (when wrapping)
map <up> gk
map k gk
imap <up> <C-o>gk
map <down> gj
map j gj
imap <down> <C-o>gj
map E ge

" tabs
nnoremap <C-N> :tabn<CR>
nnoremap <C-P> :tabp<CR>

" quick way to source vimrc
nmap ,s :source ~/.vimrc<cr>

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

