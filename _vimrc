execute pathogen#infect()
syntax on
filetype plugin indent on

set tabstop=2
set shiftwidth=2
set expandtab

nmap <F4> :w<CR>:! jslint --white --node %<CR>
nmap <F4> :w<CR>:make<CR>:cw<CR>

noremap <silent> ]l :lnext<CR>
noremap <silent> [l :lprev<CR>
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
set wildignore+=*.class
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_custom_ignore = {'dir':'\v[\/](node_modules|target|build|bin)$'}

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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

if filereadable(glob('./.vimrc.local'))
  so ./.vimrc.local
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

