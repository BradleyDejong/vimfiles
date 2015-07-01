let s:jshintroot="."

function s:CustomMake(custommake)
  call SaveOldMake()
  echo 'Setting makeprg: ' . a:custommake
  let &makeprg=a:custommake
  make
  call RestoreOldMake()
endfunction

function SetJSHintRoot(jshintroot)
  echo 'set jshintroot: ' . a:jshintroot
  let s:jshintroot=a:jshintroot
endfunction

function JsHintAll()
  echo 'Running JSHint on ' . s:jshintroot
  call s:CustomMake('jshint ' . s:jshintroot)
endfunction
