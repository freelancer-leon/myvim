set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"https://github.com/Valloric/YouCompleteMe
"Plugin 'Valloric/YouCompleteMe'
"https://github.com/bling/vim-airline
Plugin 'bling/vim-airline'
"https://github.com/kien/tabman.vim
Plugin 'kien/tabman.vim'
"https://github.com/plasticboy/vim-markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tomasr/molokai'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'mhinz/vim-signify'

" All of your Plugins must be added before the following line
call vundle#end()             " required
filetype plugin indent off    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

set nocompatible        " Use Vim defaults (much better!)
set bs=2                " allow backspacing over everything in insert mode
set noai                " always set autoindenting off
set cindent             " enable cindent
set nosmartindent       " autoindenting smartly off
"set backup             " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=150         " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set number              " show the number of lines
set showcmd             " show the cmd
set showmode            " show mode info
set whichwrap=b,s,<,>   " can use Backspace Space <Left> <Right> wrap
"set mouse=a            " use mouse in terminal
set helplang=cn         " set the vim helpdoc language
set ignorecase          " set case not sensitivity
set smartcase           " set smart case
"set cursorcolumn        " set the cursorcolumn highlight
"set cursorline          " set the cursorline highlight
"set textwidth=80        " set the width of column is 80
"set expandtab           " use <SPACE> instead of <TAB> when using <TAB>
set shiftwidth=2        " set shift move width as 2 <SPACE>
set tabstop=8           " set <TAB> space as 4
set laststatus=2        " always show statusline
"set foldmethod=syntax   " fold the code by syntax file
set wildmenu            "show wild menu
set modeline            " set modeline on
set wrapscan            " search wrap around the end of file

if has("statusline")
 set statusline=%<%f\ %h%m%r%y%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %b\ 0x%B\ \ %-14.(%l,%c%V%)\ %P
endif

" fix chinese encoding issue
let &termencoding=&encoding
set fileencodings=utf-8,gb18030,ucs-bom,cp936

" can paste in the VISUAL mode
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

filetype plugin on
filetype indent on

" don't use <TAB> instead of <SPACE> when editing Makefile
au FileType make set noexpandtab
au FileType make set list
au FileType make set lcs=tab:>-,trail:~,nbsp:%

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 77 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  if has("gui_running")
    colorscheme molokai
  endif
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=^[4%dm
     set t_Sf=^[3%dm
endif

if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
	    cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
	    cs add $CSCOPE_DB
	endif
	set csverb
endif

if has('multi_byte') && v:version > 601
  if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
    set ambiwidth=double
  endif
endif

" cscope keymap from cscope homepage
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" improved cscope keymap,use quickfix browser result
nmap <C-\>s :set cscopequickfix=s-,g-,c-,d-,i-,t-,e-,f-<CR>
\:cs find s <C-R>=expand("<cword>")<CR><CR><C-o>:copen<CR>:set cscopequickfix=<CR>
nmap <C-\>g :set cscopequickfix=s-,g-,c-,d-,i-,t-,e-,f-<CR>
\:cs find g <C-R>=expand("<cword>")<CR><CR><C-o>:copen<CR>:set cscopequickfix=<CR>
nmap <C-\>c :set cscopequickfix=s-,g-,c-,d-,i-,t-,e-,f-<CR>
\:cs find c <C-R>=expand("<cword>")<CR><CR><C-o>:copen<CR>:set cscopequickfix=<CR>
nmap <C-\>t :set cscopequickfix=s-,g-,c-,d-,i-,t-,e-,f-<CR>
\:cs find t <C-R>=expand("<cword>")<CR><CR><C-o>:copen<CR>:set cscopequickfix=<CR>
nmap <C-\>e :set cscopequickfix=s-,g-,c-,d-,i-,t-,e-,f-<CR>
\:cs find e <C-R>=expand("<cword>")<CR><CR><C-o>:copen<CR>:set cscopequickfix=<CR>
nmap <C-\>f :set cscopequickfix=s-,g-,c-,d-,i-,t-,e-,f-<CR>
\:cs find f <C-R>=expand("<cfile>")<CR><CR><C-o>:copen<CR>:set cscopequickfix=<CR>
nmap <C-\>i :set cscopequickfix=s-,g-,c-,d-,i-,t-,e-,f-<CR>
\:cs find i <C-R>=expand("<cfile>")<CR><CR><C-o>:copen<CR>:set cscopequickfix=<CR>
nmap <C-\>d :set cscopequickfix=s-,g-,c-,d-,i-,t-,e-,f-<CR>
\:cs find d <C-R>=expand("<cword>")<CR><CR><C-o>:copen<CR>:set cscopequickfix=<CR>

" Open preview define window
nmap <C-\><C-\> <C-w>}<C-w>P<C-w>J<C-w>p

"" Open a file managers with <F12>
" map <F12> <ESC>:vsplit<ENTER>:edit `pwd`<ENTER>i
" set browsedir=buffer
" map <F12> <ESC>:browse 25vsplit .<CR><C-w>ri
"" Need winmanager plugin
" map <F12> <ESC>:WMToggle<CR><C-w>r
"" Need NERDTree plugin
map <F12> <ESC>:NERDTreeToggle<CR>

" Open Tlist with <F8>
"map <F8> <ESC>:Tlist<CR>
" Close Tlist with resize
let Tlist_Inc_Winwidth=0

" Open quickfix window
map <F8> :call QuickFixWin()<CR>

" Toggle Tagbar
nmap <silent> <F11> <ESC>:TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 30

let s:bQuick=0
function! QuickFixWin()
  if s:bQuick==0
    let s:bQuick=1
    copen
  elseif s:bQuick==1
    let s:bQuick=0
    cclose
  endif
endfunction

" use Alt+; add comment,like emacs
autocmd FileType cpp,java map <Esc>; $a<tab><tab>//
autocmd FileType cpp,java imap <Esc>; <End><tab><tab>//
autocmd FileType c map <Esc>; $a<tab><tab>/*  */<Esc>2hi
autocmd FileType c imap <Esc>; <End><tab><tab>/*  */<Left><Left><Left>
autocmd FileType sh map <Esc>; O#

" use Alt+' comment current line
autocmd FileType cpp,java map <Esc>' ^i//<Esc>
autocmd FileType cpp,java imap <Esc>' <C-O>^//
autocmd FileType c map <Esc>' ^i/* <C-O>$ */<Esc>
autocmd FileType c imap <Esc>' <C-O>^/* <C-O>$ */
autocmd FileType sh map <Esc>' ^i#<Esc>
autocmd FileType sh imap <Esc>' <C-O>^#

" use Ctrl+x+[l|n|p|cc] to list|next|previous|jump to count the result
map <C-x>l <ESC>:cl<ENTER>
map <C-x>n <ESC>:cn<ENTER>
map <C-x>p <ESC>:cp<ENTER>
map <C-x>c <ESC>:cc

" Find content be selected in VISUAL mode
vmap <C-x>f y/<C-R>"<CR>
" Grep keyword under cursor in NORMAL mode
nmap <C-x>g :grep -rin <C-R>=expand("<cword>")<CR> *<CR><CR><CR><C-o>:copen<CR>
" Grep content be selected in VISUAL mode
vmap <C-x>g y:grep -rin "<C-R>"" *<CR><CR><CR><C-o>:copen<CR>

" MultipleSearch plugin setting
let g:MultipleSearchMaxColors = 10
" Highlight the word under cursor
nmap \m :Search <C-R>=expand("<cword>")<CR><CR>
" Clear highlight
nmap \c :SearchReset<CR>

" Save file
imap <C-x>s <C-o>:w<CR>
map <C-x>s <ESC>:w<CR>

" Split window and open a bash term (need Conque Shell support)
nmap <C-x>sh :ConqueTermSplit bash<CR>

" Diff a file in vertical split windown
nmap <C-x>vd :vertical diffsplit

" Highlight and kill all tailing space
nmap <C-x>hs /\s\+$<CR>
nmap <C-x>ks :%s/\s\+$//g<CR>
nmap <C-x>kl :%s/^\s*\n//g<CR>

" Thomson Dev Env Setting
"set makeprg=/usr/atria/bin/clearmake\ -C\ GNU
" set cscopeverbose               " don't display message when add cscope DB
" cscope add /local/indexdir/cscope.out
set tags=./tags,tags
set tags+=/local/indexdir/kernel/tags
au BufNewFile,BufRead *.map set filetype=lua
au BufNewFile,BufRead *.bbclass set filetype=sh

" prevent the preview window while used omnicppcomplete
set completeopt=menu

"ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
let OmniCpp_DefaultNamespaces = ["std"]
let OmniCpp_GlobalScopeSearch = 1 " 0 or 1
let OmniCpp_NamespaceSearch = 1 " 0 , 1 or 2
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1

" abbreviate list
ab dgebid document.getElementById(
ab dgesbtn document.getElementsByTagName(

" add this line to ~/.vim/syntax/c.vim
"syn keyword cTodo TAG

"nmap <C-\>x :call Window_Close("CCTree-Preview")<CR>
" Close the window
function! Window_Close(window_title)
    " Make sure the window exists
    let winnum = bufwinnr(a:window_title)
    if winnum == -1
        echohl WarningMsg
        echomsg 'Error: '.a:window_title.' is not open'
        echohl None
        return
    endif

    if winnr() == winnum
        " Already in the window. Close it and return
        if winbufnr(2) != -1
            " If a window other than the window is open,
            " then only close the window.
            close
        endif
    else
        " Goto the window, close it and then come back to the
        " original window
        let curbufnr = bufnr('%')
        exe winnum . 'wincmd w'
        close
        " Need to jump back to the original window only if we are not
        " already in that window
        let winnum = bufwinnr(curbufnr)
        if winnr() != winnum
            exe winnum . 'wincmd w'
        endif
    endif
endfunction

" DirDiff settings
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp" "Sets default exclude pattern
let g:DirDiffIgnore = "Id:,Revision:,Date:" "Sets default ignore pattern
let g:DirDiffSort = 1  "If DirDiffSort is set to 1, sorts the diff lines.
let g:DirDiffWindowSize = 14 "Sets the diff window (bottom window) height (rows)
let g:DirDiffIgnoreCase = 0 "Ignore case during diff


" Enable pathogen plugin runtime path manipulation
execute pathogen#infect()

" Moved to the end to take effect
set t_Co=256            "set termcap-colors as 256 color

" set the color of cursorline highlighting
" term=reverse|underline|bold|standout
" cterm=reverse|underline|bold|standout
" ctermfg=
" ctermbg=
" colorscheme darkblue
" highlight Normal      ctermbg=Black
highlight CursorColumn term=reverse ctermfg=1 ctermbg=3 guibg=Grey90
highlight CursorLine  term=reverse cterm=bold ctermbg=6
highlight LineNr      term=underline ctermfg=3 guifg=Brown
highlight Search      term=reverse ctermfg=0 ctermbg=3 guibg=Yellow
highlight Visual      term=reverse cterm=reverse ctermbg=0 guibg=LightGrey
highlight Pmenu       ctermbg=5 guibg=LightMagenta
highlight PmenuSel    term=standout ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
highlight Statement   term=bold ctermfg=3 gui=bold guifg=Brown
highlight link Conditional Statement
highlight link Repeat      Statement
highlight link Label       Statement
highlight link Operator    Statement
highlight link Keyword     Statement
highlight link Exception   Statement

" redefine diff highlight
highlight DiffAdd     term=bold ctermbg=1 guibg=LightBlue
highlight DiffChange  term=bold ctermbg=5 guibg=LightMagenta
highlight DiffDelete  term=bold cterm=bold ctermfg=4 ctermbg=6 gui=bold guifg=Blue guibg=LightCyan
highlight DiffText    term=reverse cterm=bold ctermbg=1 gui=bold guibg=Red

"highlight the 80th column
" * only highlight the exist character
highlight col80 term=reverse ctermfg=6 cterm=reverse
match col80 /\%<81v.\%>80v/
" * highlight the whole column
"highlight ColorColumn term=reverse ctermbg=6 guibg=LightRed
"set colorcolumn=80

" airline setup
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

" vim-markdown setup
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1

" Molokai colorscheme setup
let g:molokai_original = 1
let g:rehash256 = 1

" Indent guides setup
" '\ig' to toggle it
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
