let s:jobs = {}
function! s:gitclone_end(ch) abort
  let j = ch_getjob(a:ch)
  echomsg s:jobs[j] .. ' installed.'
  " FIXME: Can't packaddd
  packadd split(s:jobs[j], '/')[-1]
endfunction

function! s:echo(_, msg) abort
  echo a:msg
endfunction

function! templug#gitclone_temp(url) abort
  let plugdir = expand('~/_vim/pack/temp/opt/' .. split(a:url, '/')[-1])
  let cmd = ['cmd', '/c', 'git', 'clone', '--depth=1', a:url, plugdir]
  let j = job_start(cmd, {
        \ 'out_cb': funcref('s:echo'),
        \ 'close_cb': funcref('s:gitclone_end'),
        \ })
  let s:jobs[j] = a:url
endfunction

