execute pathogen#infect()
syntax on
filetype plugin indent on

set tabstop=2
set shiftwidth=2
set expandtab

nmap <F4> :w<CR>:! jslint --white --node %<CR>
nmap <F4> :w<CR>:make<CR>:cw<CR>

noremap <silent> ]q :cnext<CR>
noremap <silent> [q :cprev<CR>
noremap <silent> [Q :cfirst<CR>
noremap <silent> [Q :clast<CR>

nmap <F5> :ctags -R<CR>

if has("gui_running")
  colorscheme mustang
  colorscheme solarized
else
  colorscheme molokai
endif

set background=light

function! SaveOldMake()
  let s:oldmake = &makeprg
  let s:olderrformat=&errorformat
endfunction

function! RestoreOldMake()
  let &makeprg=s:oldmake
  set errorformat=s:olderrformat
endfunction

function! SetMavenErrorFormat()
  set errorformat=[ERROR]\ %f:[%l\\,%v]\ %m
endfunction

function! TestThisFile()
  call SaveOldMake()
  call SetMavenErrorFormat()
  let &makeprg="mvn -Dtest=%:t:r test"
  make
  call RestoreOldMake()
endfunction

function! EnableTests()
  nmap <F5> :call TestThisFile()<CR>
endfunction

"<Leader>n breaks apart the quote
:nmap <Leader>n i" +<CR>"<ESC>
:nmap <Leader>N i' +<CR>'<ESC>

:map <Leader>t <F5>
:map <Leader>d I✓<ESC>
:map <Leader>c I*<ESC>
:map <Leader>f :echo @%<CR>

set wildignore+=*/target/*
set wildignore+=*/reveal-javaweb/bin/*
set wildignore+=*/bin/*
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = {'dir':'\v[\/](node_modules|bower_components|target|build|dist|bin)$'}

highlight ColorColumn ctermbg=magenta
highlight ColorColumn guibg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0
endif

set ruler
set relativenumber

set backspace=2


