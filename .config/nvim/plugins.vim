call plug#begin('~/.local/share/nvim/site/plugged')
" Completer
" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'uiiaoo/java-syntax.vim', {'for': 'java'} "better java syntax
Plug 'rhysd/vim-clang-format'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'rhysd/vim-clang-format'
Plug 'vim-syntastic/syntastic'

" Syntax and highlighting shit
Plug 'mattn/emmet-vim'
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'cmcaine/vim-uci'

" UI junk
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
" Plug 'lambdalisue/fern-git-status.vim'
Plug 'antoinemadec/FixCursorHold.nvim'

" Git shit
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'

" Vim stuff
" Plug 'embear/vim-localvimrc'
" Plug 'vimwiki/vimwiki'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-surround' "Allows me to change { to [ and what not
Plug 'tpope/vim-commentary'
Plug 'ludovicchabant/vim-gutentags' "Tags Generate
" You might want to look at
Plug 'wellle/targets.vim' "adds more targets like [ or ,
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Themes
Plug 'fatih/molokai'

" All of your Plugins must be added before the following line
call plug#end()            " required

" Minor plugin settings
let g:AutoPairsMapCh = 0

let g:fern#renderer = "nerdfont"

" neovim only
set inccommand=split "for incsearch while sub

" Vim Colorscheme Settings
" colorscheme nord
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai
hi Normal guibg=NONE ctermbg=NONE

" Signify Settings
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

" Lightline settings
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
let g:vim_json_syntax_conceal = 0


" Vim Wiki Settings
let g:vimwiki_list = [{'path': '~/doc/wiki/', 'path_html': '~/doc/wiki/html/'}]

" Gutentag
let g:gutentags_add_default_project_roots = '0'
let g:gutentags_project_root = ['package.json', '.git', 'tags']
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
let g:gutentags_generate_on_new = '1'
let g:gutentags_generate_on_missing = '1'
let g:gutentags_generate_on_write = '1'

