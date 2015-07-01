function! GradlewTest()
  let s:curfile = expand("%:t:r")
  if has("win32")
    exe "w"
    exe "!gradlew -a -Dtest.single=" . s:curfile . " test"
  else
    exe "w"
    exe "!./gradlew -a -Dtest.single=" . s:curfile . " test"
  endif
endfunction

function! GradleTest()
  let s:curfile = expand("%:t:r")
  exe "w"
  exe "!gradle -Dtest.single=" . s:curfile . " test"
endfunction

set smartindent

nmap <Leader>t :w<CR>:call GradleTest()<CR>
nmap <Leader>t :w<CR>:call GradlewTest()<CR>


