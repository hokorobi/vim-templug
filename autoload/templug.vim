let s:jobs = {}
function! s:gitclone_end(ch) abort
  let l:j = ch_getjob(a:ch)
  echomsg s:jobs[l:j] .. ' installed.'
  " FIXME: Can't packadd
  packadd split(s:jobs[l:j], '/')[-1]
endfunction

function! s:echo(_, msg) abort
  echo a:msg
endfunction

function! templug#gitclone_temp(url) abort
  let l:plugdir = expand('~/_vim/pack/temp/opt/' .. split(a:url, '/')[-1])
  let l:cmd = ['cmd', '/c', 'git', 'clone', '--depth=1', a:url, l:plugdir]
  let l:j = job_start(cmd, {
        \ 'out_cb': funcref('s:echo'),
        \ 'close_cb': funcref('s:gitclone_end'),
        \ })
  let s:jobs[l:j] = a:url
endfunction

