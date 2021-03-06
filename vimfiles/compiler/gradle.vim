" Vim Compiler File
" " Compiler: gradle
"
if exists("current_compiler")
  finish
endif

let current_compiler = "gradle"

if exists(":CompilerSet") != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=gradlew -a test
CompilerSet errorformat=%A%f:\ %l:\ %m,%-G%.%#

