"setlocal makeprg=mvn\ compile\ -q\ -f\ ./pom.xml
"setlocal makeprg=mvn\ -am\ -pl\ \ -Dtest=%:t:r\ -q\ -DfailIfNoTests=false\ test

"function! SetProject(proj)
  "let &makeprg="mvn -am -pl ".a:proj." -Dtest=".expand('%:t:r')." -q -DfailIfNoTests=false test"
"endfunction

if exists("current_compiler")
  finish
endif

let current_compiler = "maven"

set makeprg=mvn\ clean\ install
set errorformat=\[ERROR]\ %f:%l:\ %m,%-G%.%#

nmap <F3> :w<CR>:call doTest()<CR>:cw<CR>

setlocal efm=[ERROR]\ %f:[%l%.%c]\ %m

