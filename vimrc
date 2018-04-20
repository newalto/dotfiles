" .vimrc
"
" HINT: Type zR/zM/zo/zc if you don't know how to use folds
let g:vimsyn_noerror = 1

" {{{ general setting
set nocompatible "Get out of VI's compatible mode..
silent! call pathogen#infect()
set history=300  " Number of things to remember in history.
filetype plugin on "Enable filetype plugin

set shortmess+=I

set cf  " Enable error files & error jumping.
set autowrite  " Writes on make/shell commands
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
"set clipboard+=unnamed  " Yanks go on clipboard instead.

" Highlight search terms...
set hlsearch
set incsearch
set smartcase

" be careful: tabs may look different on other systems
" width of a tab character in spaces
set tabstop=4
" defines number of spaces for when adding/remving tabs
set softtabstop=4
" number of spaces to use for autoindent
set shiftwidth=4
set textwidth=78
set wrap
set linebreak
set noexpandtab
set autoindent

" recognize lines as you can see at the bottom
set modeline
set modelines=3

set laststatus=2
set cmdheight=2
" show the command being typed
set showcmd
set title

set scrolloff=2

if has("statusline")
    set statusline=\ %F%m%r%h\ [%Y]\ [%{&ff}]\ %w\ \ \ \ \ Encoding:\ %{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\"[BOM]\":\"\")}\ \ \ \ \ Line:\ %l\|%L:%c\ [%p%%-%P]
endif

" Backups & Files
set backup                     " Enable creation of backup file.
set backupdir=~/.vim_backup " Where backup will go.
set directory=~/.vim_tmp     " Where temporary files will go.

" recognize  files
"set textauto

" always show current position
set ruler
" display also the hexcode of the char under the cursor
set rulerformat=0x%02B\ %3p%%\ %l,%c%V

if has('mouse')
    set mouse-=a
endif

"Set mapleader
"let mapleader = ","
"let g:mapleader = ","

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

" Files to ignore
set wildignore=*.o,*.lo,*.la,#*#,.*.rej,*.rej,.*~,*~,.#*,*.class
set tag+=/usr/include/tags
" }}}
" {{{ color setting
if &t_Co > 2 || has("gui_running")
    " ...then use highlighting
    syntax on "Enable syntax hl
endif

if $TERM =~ '^xterm' || $TERM =~ '^screen'
    set t_Co=256
    " xterm backspace settings
    "set t_kb=
    "fixdel
else
    "colorscheme tango
endif

try
    colorscheme DevC++
catch
    silent! colorscheme tango
endtry


"if has("gui_running")
"    colorscheme inkpot
"else
"    colorscheme dark-ruby
"end

"hi StatusLine ctermfg=black ctermbg=white

"Omni menu colors
hi Pmenu guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff

"map <silent><F3> :NEXTCOLOR<cr>
"map <silent><F2> :PREVCOLOR<cr>

if exists('+colorcolumn')
"    set cc=+1,+2,+3
else
    " Emulate
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%80v.\+', -1)
endif
" }}}
" {{{ encoding settings
" 配置多语言环境
if has("multi_byte")
    " Set fileencoding priority
    if getfsize(expand("%")) > 0
        set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    else
        set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    endif

    " Detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with multi_byte"
endif

if has('multi_byte') && v:version > 601
    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif
" }}}
" {{{ filetype setting
" {{{ruby setting
augroup ruby
    function! SKEL_rb()
        0r ~/.vim/skeletons/skeleton.rb
    endfunction
    "autocmd BufNewFile *.java 0r ~/.vim/skeletons/skeleton.rb
    autocmd BufNewFile *.rb	call SKEL_rb()
    au FileType ruby setlocal autoindent tabstop=2 shiftwidth=2 expandtab
augroup END
" }}}

" {{{python setting
augroup python
    function! SKEL_py()
        0r ~/.vim/skeletons/skeleton.py
    endfunction
    autocmd BufNewFile *.py call SKEL_py()
    au FileType python setlocal autoindent tabstop=4 shiftwidth=4 expandtab
augroup END
" }}}

" {{{java setting
augroup java
    function! SKEL_java()
        0r ~/.vim/skeletons/skeleton.java
    endfunction
    autocmd BufNewFile *.java call SKEL_java()
    au FileType java setlocal autoindent tabstop=4 shiftwidth=4 expandtab
augroup END
" }}}

" {{{ c/cpp setting
augroup c
    function! SKEL_c()
        0r ~/.vim/skeletons/skeleton.c
    endfunction
    autocmd BufNewFile *.c,*.cpp call SKEL_c()
    au FileType c,cpp setlocal cindent tabstop=4 shiftwidth=4 formatoptions=croq expandtab
augroup END
" }}}

" {{{ shell setting
augroup shell
    function! SKEL_sh()
        0r ~/.vim/skeletons/skeleton.sh
    endfunction
    autocmd BufNewFile *.sh call SKEL_sh()
    au FileType sh setlocal autoindent tabstop=4 shiftwidth=4 expandtab
augroup END
" }}}

" {{{ spec setting
function! SKEL_spec()
    0r ~/.vim/skeletons/skeleton.spec
    language time en_US
    if $USER != ''
        let login = $USER
    elseif $LOGNAME != ''
        let login = $LOGNAME
    else
        let login = 'unknown'
    endif
    let newline = stridx(login, "\n")
	if newline != -1
		let login = strpart(login, 0, newline)
	endif
	if $HOSTNAME != ''
		let hostname = $HOSTNAME
	else
		let hostname = system('hostname -f')
		if v:shell_error
			let hostname = 'localhost'
		endif
	endif
	let newline = stridx(hostname, "\n")
	if newline != -1
		let hostname = strpart(hostname, 0, newline)
	endif
	"let myname = system('getent passwd $USER|cut -d ":" -f5')
	"if v:shell_error
	"	let myname = login
	"endif
	exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
	"exe "%s/specRPM_CREATION_AUTHOR_NAME/" . myname . "/ge"
	exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
	exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
	setf spec
endfunction
autocmd BufNewFile *.spec call SKEL_spec()
" }}}

" {{{html setting
" mhtml files 
"au BufNewFile *.html 0r ~/.vim/skeleton/html.skel | let IndentStyle = "html" | $,$d | normal gg
"au FileType html setlocal ai tw=120 sts=2 sw=2 ts=2 sta et fo+=tl
" }}}

" {{{css setting
"au FileType css setlocal ai tw=80 sts=2 sw=2 ts=2 sta et fo+=tl
" }}}
" }}}
" {{{ map: date,dict
"My information
iab xdate <C-R>=strftime("%Y-%m-%d %T %Z")<cr>
iab xname Percy Lau
iab logdate <C-R>=strftime("%Y-%m-%d  Percy Lau <percy.lau@gmail.com>")<CR>

"let g:winManagerWindowLayout = "FileExplorer" 
"nmap <C-\> :!clear;dict.py <C-R>=expand("<cword>")<CR><CR>

"command! Q  quit
"command! W  write
"command! Wq wq
"command! WQ wq

" \tt insert date
nmap <Leader>tt :execute "normal i" . strftime("%Y-%m-%d")<Esc>
"nmap <Leader>tt :execute "normal i" . strftime("%Y-%m-%d-%H-%M")<Esc>
"nmap <Leader>tt :execute "normal i" . strftime("%a, %d %b %Y %H:%M:%S %Z")<Esc>

nnoremap <Leader>u :setlocal nobomb<Return>:setlocal fileencoding=utf-8<Return>

nmap <F8> :TagbarToggle<CR>         " mapping f8 to TagbarToggle
nmap <F2> :NERDTreeToggle<CR>       " mapping f2 to NERDTreeToggle
" }}}
" {{{ other setting
" Define a function that can tell me if a file is executable
function! FileExecutable (fname)
    execute "silent! ! test -x" a:fname
    return v:shell_error
endfunction
" Automatically make Perl and Shell scripts executable if they aren't already
" au BufWritePost *.sh,*.pl,*.cgi,*.py if FileExecutable("%:p") | :!chmod u+x % endif

"let g:vimwiki_home = "$HOME/vimwiki/"
let g:vimwiki_list = [{'path' : '$HOME/vimwiki',
                    \ 'path_html' : '$HOME/public_html'},
                    \ {'path': '$HOME/Dropbox/Documents/vimwiki',
                    \ 'path_html': '$HOME/Dropbox/Public/vimwiki',
                    \ 'html_header': '$HOME/Dropbox/Documents/vimwiki/template/header.tpl',
                    \ 'html_footer': '$HOME/Dropbox/Documents/vimwiki/template/footer.tpl'}
                    \ ]
" }}}
" {{{ func
function! EnsureDirExists (dir)
  if !isdirectory(a:dir)
    if exists("*mkdir")
      call mkdir(a:dir,'p')
      echo "Created directory: " . a:dir
    else
      echo "Please create directory: " . a:dir
    endif
  endif
endfunction

call EnsureDirExists($HOME . '/.vim_backup')
call EnsureDirExists($HOME . '/.vim_tmp')
" }}}

"autocmd vimenter * if argc() | NERDTree | endif
" vim:ft=vim:fdm=marker:
