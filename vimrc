"==========================================
" Forkby:	    xuyu
" Author:	    wklken
" Base Version: 9.2
"==========================================

" leader key
let mapleader=','
let g:mapleader=','

" enable syntax
syntax on

" install bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
elseif filereadable(expand("~/.config/nvim/vimrc.bundles")) " neovim
  source ~/.config/nvim/vimrc.bundles
endif

" ensure ftdetect et al work by including this after the bundle stuff
filetype plugin indent on

" history capacity
set history=2000

" filetype setting
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" auto read when modified
set autoread
" disable ad prompt
set shortmess=atI

" no backspace
set nobackup
" no swap
set noswapfile

" cursor highlight
set cursorcolumn
set cursorline

" keep content on terminal after existing vim
set t_ti= t_te=

" disable mouse
set mouse-=a
" set mouse=a
" hide the mouse cursor while typing
" set mousehide

" include the char at cursor when selecting
set selection=inclusive
set selectmode=mouse,key

" change the title of terminal
set title
" no bell
set novisualbell
set noerrorbells
set t_vb=
set tm=500

" remember info about open buffers on close
set viminfo^=%

" enable magic for regular expressions
" \m：除了 $ . * ^ 之外其他元字符都要加反斜杠
" \M：除了 $ ^ 之外其他元字符都要加反斜杠
" \v（即 very magic 之意）：任何元字符都不用加反斜杠
" \V（即 very nomagic 之意）：任何元字符都必须加反斜杠
" examples
" /\v(a.c){3}$   # 查找行尾的abcaccadc
" /\m(a.c){3}$   # 查找行尾的(abc){3}
" /\M(a.c){3}$   # 查找行尾的(a.c){3}
" /\V(a.c){3}$   # 查找任意位置的(a.c){3}$
" default \v
set magic

" configure backspace so it acts as it should act
" eol
"   插入模式下在行开头，通过退格键合并两行
" indent
"   启用 :set indent, :set ai 等自动缩进；使用退格键删除字段缩进
" start
"   删除此次插入前的输入
set backspace=eol,start,indent
" corss-line (wrap) support for keys like <,>,h,l
set whichwrap+=<,>,h,l

" current row and column (ruler)
set ruler
" show cmd on status line
set showcmd
" show mode at left bottom corner
set showmode

" margin lines from up and bottom
set scrolloff=7

" min width
" set winwidth=79

" cmd height, default 1, here 2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" always show the status line - use 2 lines for the status bar
set laststatus=2

" show line number
set number
" disable cross-line (wrap)
set nowrap

" parentheses match
set showmatch
" how many tenths of a second to blink when matching brackets
set matchtime=2

" highlight search
set hlsearch
" search when typing
set incsearch
" case insensitive
set ignorecase
" case sensitive when there are more than one upper case
set smartcase

" code fold
set foldenable
" fold options
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=indent
set foldlevel=99
" hot key: code fold: <leader>zz
let g:FoldMethod=0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod=1
    else
        exe "zormal! zR"
        let g:FoldMethod=0
    endif
endfun

" indent setting
" smart indent
set smartindent
" auto indent
" never add copyindent, will case error
" copy the previous indentation on autoindenting
set autoindent

" tab setting
" tab width
set tabstop=4
" tab -> nr space
set shiftwidth=4
" delete tab -> nr space
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop
set smarttab
" expand tab to space
" use [Ctrl + V + Tab] to type tab
set expandtab
" use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" a buffer becomes hidden when it is abandoned
" hidden buffer
set hidden

set ttyfast

" 增减数字时使用十进制
" +- j/k with decimal
set nrformats=

" absolute line number
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
" hot key: toggle absolute/relative line number: <leader>n
nnoremap <leader>n :call NumberToggle()<cr>

" tmux vim background color issue
" ref: http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" newfile encoding
set encoding=utf-8
" try when auto-encoding
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn
"set langmenu=zh_CN.UTF-8
"set enc=2byte-gb18030
" for regular mode
set termencoding=utf-8

" use unix as the standard file type
set ffs=unix,dos,mac

" break line when meeting text with unicode larger than 255
set formatoptions+=m
" 合并两行中文时，不在中间加空格
" no extra space when merge 2 chinese lines
set formatoptions+=B

" autoload when modified, windows
autocmd! bufwritepost _vimrc source %
" autoload when modified, linux
autocmd! bufwritepost .vimrc source %

" auto complete
" ref: VimTip1228
set completeopt=longest,menu

" auto complete in enhanced mode
set wildmenu
set wildmode=list:longest
" ignore compiled and swap files
set wildignore=*.o,*~,*.pyc,*.class,*.swp,*.bak,.svn
" close preview when leaving insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" choose with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" command-line window
autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

" actions of up/down/pageup/pagedown in pumvisible or not
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" disable direction key
" map <Left> <Nop>
" map <Right> <Nop>
" map <Up> <Nop>
" map <Down> <Nop>

" treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" disable F1
" I can type :help on my own, thanks.
" protect your fat fingers from the evils of <F1>
noremap <F1> <Esc>

" F2: show (or not) line number
nnoremap <F2> :set number! number?<CR>
" F3 show (or not) printable character like tab/space/etc.
nnoremap <F3> :set list! list?<CR>
" F4 cross (or not) line
nnoremap <F4> :set wrap! wrap?<CR>

" F6 syntax on (or off)
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" F5 paste on (or off) in insert mode
set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

" automatically set paste mode in Vim when pasting in insert mode
" ref: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start="\<Esc>Ptmux;"
  let tmux_end="\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" smart way to move between windows
" need vim-tmux-navigator, and modify .tmux.conf
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" zoom / restore window
" ref: http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed=0
    else
        let t:zoom_winrestcmd=winrestcmd()
        resize
        vertical resize
        let t:zoomed=1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

" go to home and end using capitalized directions
noremap H ^
noremap L $

" map ; to : and save a million keystrokes 用于快速进入命令行
nnoremap ; :

" enhancement in cmd mode
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" search setting
" map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
" use sane regexes
nnoremap / /\v
vnoremap / /\v

" keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" 去掉搜索高亮
" disable search highlight
noremap <silent><leader>/ :nohls<CR>

" switch # *
nnoremap # *
nnoremap * #

" python: do not move to beginning of line for # indent
autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#


" selecting setting
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$

" copy to system clipboard
vnoremap <leader>y "+y

" select all
map <Leader>sa ggVG

" slect and highlight last insert content
nnoremap gv `[v`]

" select block
nnoremap <leader>v V`}

" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %

" replace esc with kj or Ctrl-c
inoremap kj <Esc>
inoremap <C-c> <Esc>

" speed up scrolling of the viewport slightly
nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>

" jump to start and end of line using the home row keys
" nmap t o<ESC>k
" nmap T O<ESC>j

" quickly close the current window
nnoremap <leader>q :q<CR>

" quickly save the current file
nnoremap <leader>w :w<CR>

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" filetype setting
autocmd FileType c,cpp,make set tabstop=8 shiftwidth=8 noexpandtab ai
autocmd FileType bash,sh,shell,awk set tabstop=4 shiftwidth=4 noexpandtab ai
autocmd FileType python,java set tabstop=4 shiftwidth=4 softtabstop=4 expandtab ai
autocmd FileType javascript,html,css,xml,markdown set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd

" disable showmatch when use > in php
" au BufWinEnter *.php set mps-=<:>

fun! <SID>StripTrailingWhitespaces()
    let l=line(".")
    let c=col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
" auto delete trailing spaces
" autocmd FileType java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" auto insert file header
autocmd BufNewFile *.sh,*.pl,*.py,*.c,*cpp,*.stp exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    if &filetype == 'sh'
        call setline(1, "#!/bin/bash")
    endif

    if &filetype == 'perl'
        call setline(1, "#!/usr/bin/perl")
    endif

    if &filetype == 'python'
        call setline(1, "#!/usr/bin/env python")
        call append(1, "# -*- coding: utf-8 -*-")
        " call setline(2, "# -*- coding: utf-8 -*-")
    endif

    if &filetype == 'c'
        call setline(1, "#include <stdio.h>")
    endif

    if &filetype == 'cpp'
        call setline(1, "#include <iostream>")
        call setline(2, "#include <vector>")
        call setline(3, "using namespace std;")
    endif

    if &filetype == 'stp'
        call setline(1, "#!/usr/bin/stap")
    endif

    normal G
    normal o
    normal o
endfunc

" highlight keywords
if has("autocmd")
  " highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  endif
endif

" redraw only when we need to
" ref: https://dougblack.io/words/a-good-vimrc.html
set lazyredraw

" set extra options when running in GUI mode
if has("gui_running")
    set guifont=Monaco:h14
    if has("gui_gtk2")
        set guifont=Monaco\ 12,Monospace\ 12
    endif
    set guioptions-=T
    set guioptions+=e
    set guioptions-=r
    set guioptions-=L
    set guitablabel=%M\ %t
    set showtabline=1
    set linespace=2
    set noimd
    set t_Co=256
endif

" color theme
colorscheme gruvbox
set background=dark
let g:airline_theme='gruvbox'

" set background color of signcolumn as numcolumn
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" error highlight
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" cscope setting
if has("cscope")
  " for linux
  set csprg=/usr/bin/cscope
  " for mac
  " set csprg=/usr/local/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif

nmap <C-\>h :cs help<CR>
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" ctags setting
set tags=tags;/

" highlight the display format of Tab and Space
set lcs=tab:>>,space:-,nbsp:%
highlight LeaderTab guifg=#666666
highlight LeaderSpace guifg=#666666
match LeaderTab /^\t/
match LeaderSpace /^\ /

" length 80 check
if exists('+colorcolumn')
    set colorcolumn=80
    highlight ColorColumn ctermbg=DarkCyan
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
