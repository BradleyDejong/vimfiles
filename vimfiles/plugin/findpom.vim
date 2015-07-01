
"if exists("find_pom")
	"finish
"endif
"let find_pom = 1

" windowdir
"  Gets the directory for the file in the current window
"  Or the current working dir if there isn't one for the window.
"  Use tr to allow that other OS paths, too
function! s:windowdir()
  if winbufnr(0) == -1
    let unislash = getcwd()
  else 
    let unislash = fnamemodify(bufname(winbufnr(0)), ':p:h')
  endif
    return tr(unislash, '\', '/')
endfunc

function! s:Find_in_parent(fln,flsrt,flstp)
  let here = a:flsrt
  echo 'starting from ' . here
  while ( strlen( here) > 0 )
    if filereadable( here . "/" . a:fln )
      return here
    endif
    let fr = match(here, "/[^/]*$")
    if fr == -1
      break
    endif
    let here = strpart(here, 0, fr)
    if here == a:flstp
      break
    endif
  endwhile
  return "Nothing"
endfunc

function! FindPom()
  let curdir = s:windowdir()

  "echo 'Current directory: ' . curdir

  let pomdir = s:Find_in_parent('pom.xml', curdir, '/')
  "echo 'pomdir: ' . pomdir

  return pomdir
endfunc

function! s:Make_no_footprint(prg)
  echo "Found make prg: " . a:prg
  call SaveOldMake()
  call SetMavenErrorFormat()
  let &makeprg=a:prg
  make
  call RestoreOldMake()
endfunc

function! s:Maven_install()
  call s:Make_no_footprint('mvn install')
endfunction

function! InstallMavenFromParentPom()
  let pomdir = FindPom()
  "echo 'Found pom: ' . pomdir

  let olddir = getcwd()
  exe "lcd " . pomdir

  call s:Maven_install()

  exe "lcd " . olddir
endfunc

function! EditPom()
  let pomfile = FindPom() . '/pom.xml'
  execute 'sp ' . pomfile
endfunc

:map <Leader>p :call EditPom()<CR>

function! EnableInstall()
  nmap <F5> :call InstallMavenFromParentPom()<CR>
endfunction


