let mapleader = ","

" Keybindings
" Comment line
nmap <C-_> gcc
vmap <C-_> gc
" Tabs
noremap <S-h> :tabp <CR>
noremap <S-l> :tabn <CR>
" Format
noremap <F8> gg=G
" Escape to exit terminal mode
tnoremap <Esc> <C-\><C-n>
inoremap jj <ESC>
" Window movement
noremap <space>h <C-w>h
noremap <space>j <C-w>j
noremap <space>k <C-w>k
noremap <space>l <C-w>l
" Insert movement
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
" Commandline movement
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
" Folding
nnoremap <C-h> zc
nnoremap <C-l> zv

noremap <leader>f :Fern . -drawer -toggle<CR>
nmap <silent> ga <Plug>(coc-definition)

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
