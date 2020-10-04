if exists('g:loaded_templug')
  finish
endif
let g:loaded_templug = 1

command! -nargs=1 Templug call templug#gitclone_temp(<f-args>)
