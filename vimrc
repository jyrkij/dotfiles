" vim: set sw=4 ts=4 sts=4 et tw=78:

" Some of this is based on spf13-vim

set nocompatible

let mapleader=','

set history=1000
set backup
if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set textwidth=80
set autoindent

set number
set showmatch
set ignorecase
set smartcase

set ttymouse=xterm2
set mouse=a

function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    let common_dir = parent . '/.' . prefix

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()

" Hex read
nmap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>
" Hex write
nmap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" Load vim-plug
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'vim-scripts/Vimchant'
Plug 'godlygeek/tabular'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeTabsToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeTabsToggle' }
Plug 'slim-template/vim-slim'
Plug 'deviantfero/wpgtk.vim'
call plug#end()

map <C-e> :NERDTreeTabsToggle<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

" More frequent (1s) updates to vimchant
set updatetime=1000

" Automatically use Finnish spell checking on md files
augroup FinnishSpell
    autocmd!
    autocmd BufRead,BufNewFile *.{md,markdown} VimchantSpellCheckOn
augroup END

" The following is based on
" https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
function! CustomColors() abort
    highlight SpellBad cterm=underline ctermbg=NONE ctermfg=Red gui=undercurl guisp=Red
endfunction
augroup CustomColors
    autocmd!
    autocmd ColorScheme * call CustomColors()
augroup END
colorscheme wpgtk

let NERDTreeQuitOnOpen=0
let g:nerdtree_tabs_open_on_gui_startup=1

" I want to have UTF-8 and UNIX line endings everywhere.
set fileencoding=utf8
set encoding=utf8
set termencoding=utf8
set ffs=unix,dos

autocmd FileType gitcommit set textwidth=72
set colorcolumn=+1
autocmd FileType gitcommit set colorcolumn+=51
highlight ColorColumn ctermbg=236 guibg=#575757
