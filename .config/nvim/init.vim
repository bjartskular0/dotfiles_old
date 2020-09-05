set nocompatible              " be iMproved, required

au FileType sh let g:sh_fold_enabled=5
au FileType sh let g:is_bash=1

call plug#begin('~/.local/share/nvim/site/plugged')
" Completer
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'artur-shaik/vim-javacomplete2'
" Plug 'uplus/deoplete-solargraph'

" Syntax and highlighting shit
Plug 'vim-syntastic/syntastic'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'mattn/emmet-vim'
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'vim-scripts/indentpython.vim', { 'for': 'py' }
Plug 'preservim/nerdcommenter'

" UI junk
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'lambdalisue/fern.vim'
Plug 'antoinemadec/FixCursorHold.nvim'

" Git shit
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Vim stuff
Plug 'vimwiki/vimwiki'
Plug 'AndrewRadev/splitjoin.vim'

" Themes
Plug 'fatih/molokai'

" All of your Plugins must be added before the following line
call plug#end()            " required

augroup vimconfig
  autocmd!
  " Vim settings
  set syntax=enable
  set hlsearch
  set ignorecase
  set showmatch
  set number
  "set autowrite
  set showcmd
  set splitright
  set splitbelow
  set cursorline

  " Enable syntax completion
  filetype plugin indent on  
  set omnifunc=syntaxcomplete#Complete

  let mapleader = ","

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
  set colorcolumn=140
  highlight ColorColumn ctermbg=darkgray
augroup END

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

" Vim Colorscheme Settings
" colorscheme nord
augroup color_settings
  autocmd!
  let g:rehash256 = 1
  let g:molokai_original = 1
  colorscheme molokai
  hi Normal guibg=NONE ctermbg=NONE
augroup END

" Keybindings
augroup keybindings
  autocmd!
  noremap <A-h> :tabp <CR>
  noremap <A-l> :tabn <CR>
  noremap <F8> gg=G
  tnoremap <Esc> <C-\><C-n>
  inoremap jj <ESC>
  inoremap <C-h> <Left>
  inoremap <C-j> <Down>
  inoremap <C-k> <Up>
  inoremap <C-l> <Right>
  cnoremap <C-h> <Left>
  cnoremap <C-j> <Down>
  cnoremap <C-k> <Up>
  cnoremap <C-l> <Right>

  nnoremap <C-h> zc
  nnoremap <C-l> zv
augroup END

" noremap <A-h> <lt>gv
" noremap <A-l> >gv

" Deoplete
augroup deoplete
  autocmd!
  let g:deoplete#enable_at_startup = 1

  set completeopt+=noselect
  call deoplete#custom#option('omni_patterns', {
        \ 'java': '[^. *\t]\.\w*',
        \})

  call deoplete#custom#option('sources', {
        \ '_': [],
        \})

  " use tab to forward cycle
  inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
  " use tab to backward cycle
  inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
augroup END

augroup deoplete_rust
  autocmd!
  " Quickhelp: https://github.com/sebastianmarkow/deoplete-rust
  let g:deoplete#sources#rust#racer_binary='/home/shadowninja404/.cargo/bin/racer'
  let g:deoplete#sources#rust#rust_source_path='/home/shadowninja404/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'
  let g:deoplete#sources#rust#documentation_max_height=20

  nmap <buffer> gd <plug>DeopleteRustGoToDefinitionDefault
  nmap <buffer> K  <plug>DeopleteRustShowDocumentation
augroup END

" javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" let g:deoplete#omni_patterns = {}
" let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
" let g:deoplete#auto_completion_start_length = 2
" let g:deoplete#sources = {}
" let g:deoplete#sources._ = []

" Syntastic Settings
augroup syntastic
  autocmd!
  " let g:syntastic_java_checkers = []
  " set statusline+=%#warningmsg#
  " set statusline+=%{SyntasticStatuslineFlag()}
  " set statusline+=%*

  " let g:syntastic_always_populate_loc_list = 1
  " let g:syntastic_auto_loc_list = 1
  " let g:syntastic_check_on_open = 1
  " let g:syntastic_check_on_wq = 0

  " let g:syntastic_go_checkers = ["go"]
augroup END

" Signify Settings
augroup signify
  autocmd!
  set updatetime=100
  let g:signify_sign_add = '+'
  let g:signify_sign_change = '~'
  let g:signify_sign_delete = '-'

  function! LightlineSignify()
    let l:branch = fugitive#head()
    if !exists('b:sy')
      if !empty(l:branch)
        return printf('%s', l:branch)
      endif
      return ''
    endif

    let l:sy_vcs = get(b:sy, 'updated_by', '')

    let [added, modified, removed] = sy#repo#get_stats()
    let l:sy = ''
    for [flag, fcount] in [
          \   [g:signify_sign_add, added],
          \   [g:signify_sign_change, modified],
          \   [g:signify_sign_delete, removed]
          \ ]
      if fcount > 0
        let l:sy .= printf('%s%d ', flag, fcount)
      else
        let l:sy .= printf('%s0 ', flag)
      endif
    endfor

    if !empty(l:sy_vcs)
      let l:sy_vcs .= printf('%s ', l:sy_vcs)
    endif
    return printf('%s%s%s', l:sy_vcs, l:sy, l:branch)
  endfunction
augroup END

" Lightline settings
augroup lightline
  autocmd!
  let g:lightline = {
        \   'colorscheme': 'nord',
        \   'active': {
        \     'left':[ [ 'mode', 'paste' ],
        \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
        \     ]
        \   },
        \   'inactive': {
        \     'left':[ [ 'mode', 'paste' ],
        \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
        \     ]
        \   },
        \   'component': {
        \     'lineinfo': ' %3l:%-2v',
        \   },
        \   'component_function': {
        \     'gitbranch': 'LightlineSignify',
        \     'filename': 'LightlineFilename',
        \   },
        \   'tab_component_function': {
        \     'filename': 'LightlineTabname',
        \   },
        \ }
  let g:lightline.separator = {
        \   'left': '', 'right': ''
        \}
  let g:lightline.subseparator = {
        \   'left': '', 'right': '' 
        \}

  let g:lightline.tabline = {
        \   'left': [ ['tabs'] ],
        \ }
  set showtabline=2
augroup END

function! LightlineFilename()
  let path = substitute(expand('%:p:h'), '\(/.\{-}\w\)[^/]*', '\=submatch(1)', 'g') . '/' . expand('%:t')
  return path
endfunction

function! LightlineTabname(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufnum = buflist[winnr - 1]
  let path = substitute(expand('#'.bufnum.':p:h'), '\(/.\{-}\w\)[^/]*', '\=submatch(1)', 'g') . '/' . expand('#'.bufnum.':t')
  return path
endfunction



" Vim-Json Settings
augroup vimjson
  autocmd!
  let g:vim_json_syntax_conceal = 0
augroup END


" Vim Wiki Settings
augroup vimwiki
  autocmd!
  let g:vimwiki_list = [{'path': '~/doc/wiki/', 'path_html': '~/doc/wiki/html/'}]
augroup END




" #####################
" # FILETYPE SETTINGS #
" #####################

augroup filetypes
  autocmd!
  autocmd FileType go call GoSettings()
  autocmd FileType sh call SHSettings()
  autocmd FileType java call JavaSettings()
augroup END

" ###############
" # SH SETTINGS #
" ###############

function SHSettings()
  set tabstop=8
  set softtabstop=0
  set expandtab
  set shiftwidth=2
  set smarttab
endfunction

" ###############
" # GO SETTINGS #
" ###############

function GoSettings()
  " Key mappings
  map <C-n> :cnext<CR>
  map <C-m> :cprevious<CR>
  nnoremap <leader>a :cclose<CR>

  nmap <leader>r  <Plug>(go-run)
  nmap <leader>t  <Plug>(go-test)
  nmap <Leader>c  <Plug>(go-coverage-toggle)
  nmap <leader>b  :<C-u>call <SID>build_go_files()<CR>

  " Utility settings
  let g:go_fmt_command = "goimports"
  let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
  let g:go_metalinter_autosave = 1
  let g:go_metalinter_autosave_enabled = ['vet', 'golint']
  let g:go_metalinter_deadline = "5s"

  " Highlight Settings
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_generate_tags = 1

  " Tab Settings
  set tabstop=2
  set shiftwidth=2
  set softtabstop=0
  set noexpandtab
endfunction

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" #################
" # JAVA SETTINGS #
" #################
"

function JavaSettings()
  setlocal foldmethod=syntax
  setlocal foldlevel=2
  setlocal foldcolumn=1
endfunction
