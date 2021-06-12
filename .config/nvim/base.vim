set nocompatible              " be iMproved, required

filetype plugin on

set syntax=enable
set hidden "work with multiple unsaved buffers.

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2
set showcmd

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set number
set relativenumber number "sets line numbers

set hlsearch
set showmatch
set incsearch "highlights as you search

set ignorecase
set smartcase
set splitbelow splitright

" Tabsize settings
set autoindent
set expandtab
set tabstop=8
set softtabstop=0
set shiftwidth=2
set smarttab

" Folding
set foldmethod=syntax
set foldlevel=7
set foldcolumn=1

" Colorcolumn Indicator
set cursorline
set colorcolumn=140
highlight ColorColumn ctermbg=darkgray

" Underline current line
augroup underline
  autocmd!
  autocmd ColorScheme * hi clear CursorLine
  autocmd ColorScheme * hi CursorLine gui=underline cterm=underline
augroup END

" Popup menu color
augroup init
  autocmd!
  autocmd ColorScheme * hi Pmenu ctermbg=black ctermfg=cyan
  autocmd ColorScheme * hi PmenuSel ctermbg=cyan ctermfg=black
augroup END


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Enable syntax completion
filetype plugin indent on  
set omnifunc=syntaxcomplete#Complete

