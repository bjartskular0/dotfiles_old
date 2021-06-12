setlocal foldmethod=syntax
setlocal foldlevel=2
setlocal foldcolumn=1

compiler javac
setlocal makeprg=javac\ %\ -g
setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
noremap <buffer> <leader>8 :make<cr>:copen<cr>
noremap <buffer> <leader>9 :!echo %\|awk -F. '{print $1}'\|xargs java<cr>
noremap <buffer> <leader>i :CocCommand java.action.organizeImports<cr>

let g:coc_global_extensions = [
      \ 'coc-java',
      \ 'coc-snippets',
      \ 'coc-java-debug',
      \ 'coc-lists'
      \ ]
