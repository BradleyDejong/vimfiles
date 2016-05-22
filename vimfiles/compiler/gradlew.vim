
"if exists("current_compiler")
  "finish
"endif
"let current_compiler = "gradlew"

"if exists(":CompilerSet") != 2
  "command -nargs=* CompilerSet setlocal <args>
"endif

"CompilerSet makeprg=\(\(./gradlew\ $*\ 1>/dev/null)\ 2>&1\)\ \\\|\ grep\ error
" swap stderr and stdout, then dump stderr, so we're only left with the
" stream originally on stderr (which is now stdout)
" CompilerSet makeprg=\(\(./gradlew\ $*\ 3>&2\ 2>&1\ 1>&3\)\ 2>/dev/null\ \)\ \\\|\ grep\ error
"CompilerSet errorformat=%f:%l:%m

let s:gradlew = escape(findfile('gradlew', '.;') . " -b " . findfile('build.gradle', '.;'), ' \')

echo s:gradlew

if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2      " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let current_compiler = s:gradlew
execute "CompilerSet makeprg=" . s:gradlew
" copied from javac.vim + added the :compileJava bits
"CompilerSet errorformat=%f:\ %m

CompilerSet errorformat=
    \%E[ant:scalac]\ %f:%l:\ error:\ %m,
    \%W[ant:scalac]\ %f:%l:\ warning:\ %m,
    \%E%f:\ %\\d%\\+:\ %m\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
    \%E%>%f:\ %\\d%\\+:\ %m,%C\ @\ line\ %l\\,\ column\ %c.,%-C%.%#,%Z%p^,
    \%-G\\s%#,
    \%-GBUILD\ SUCCESSFUL#,
    \%-GTotal\ \time:\ %.%#,
    \%E%f:%l:\ %m,
    \%-G%.%#
"
":\ %m\ @\ line\ %l\,\ column\ %c

