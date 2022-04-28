" begin plugin section
call plug#begin()

Plug 'VonHeikemen/midnight-owl.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
if (has("termguicolors"))
 set termguicolors
endif
syntax on
set background=dark
colorscheme midnight-owl
let g:airline_theme='minimalist'
set nocompatible
set number
set nobackup
set showmode
set noerrorbells
filetype on
filetype plugin on
filetype indent on
