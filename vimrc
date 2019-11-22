"==========================================
" Forkby:	xuyu
" Author:	wklken
" Base Version: 9.2
" Sections:
"       -> Initial Plugin 加载插件
"       -> General Settings 基础设置
"       -> Display Settings 显示界面格式设置
"       -> FileEncode Settings 文件编码设置
"       -> Others 其它配置
"       -> HotKey Settings  自定义快捷键
"       -> FileType Settings  针对文件类型的设置
"       -> Theme Settings  主题设置
"       -> Personal Settings 个人设置
"       -> 插件配置和具体设置在vimrc.bundles中
" Note: Don't put anything in your .vimrc you don't understand!
"==========================================

"==========================================
" Initial Plugin 加载插件
"==========================================

" 修改 leader 键
let mapleader = ','
let g:mapleader = ','

" 开启语法高亮
syntax on

" install bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
elseif filereadable(expand("~/.config/nvim/vimrc.bundles")) " neovim
  source ~/.config/nvim/vimrc.bundles
endif

" ensure ftdetect et al work by including this after the bundle stuff
filetype plugin indent on

"==========================================
" General Settings 基础设置
"==========================================

" history 存储容量
set history=2000

" 检测文件类型
filetype on
" 针对不同的文件类型采用不同的缩进格式
filetype indent on
" 允许插件
filetype plugin on
" 启动自动补全
filetype plugin indent on

" 文件修改之后自动载入
set autoread
" 启动的时候不显示援助乌干达儿童的提示
set shortmess=atI

" 备份到另一个位置，防止误删，目前是取消备份
"set backup
"set backupext=.bak
"set backupdir=/tmp/vimbk/

" 取消备份
set nobackup
" 关闭交换文件
set noswapfile

" 突出显示当前列
set cursorcolumn
" 突出显示当前行
set cursorline

" 退出vim后，内容显示在终端屏幕, 可以用于查看和复制
set t_ti= t_te=

" 鼠标暂不启用, 键盘党....
set mouse-=a
" 启用鼠标
" set mouse=a
" Hide the mouse cursor while typing
" set mousehide

" 选中时包括光标所在的字符
" 修复 ctrl+m 多光标操作选择的 bug
" ctrl+v 进行字符选中时将包含光标下的字符
set selection=inclusive
set selectmode=mouse,key

" change the terminal's title
set title
" 去掉输入错误的提示声音
set novisualbell
set noerrorbells
set t_vb=
set tm=500

" Remember info about open buffers on close
" 记录上次打开的位置等信息
set viminfo^=%

" For regular expressions turn magic on
" 默认情况下，正则表达式的元字符必须用反斜杠进行转义
" \m：除了 $ . * ^ 之外其他元字符都要加反斜杠
" \M：除了 $ ^ 之外其他元字符都要加反斜杠
" \v（即 very magic 之意）：任何元字符都不用加反斜杠
" \V（即 very nomagic 之意）：任何元字符都必须加反斜杠
" /\v(a.c){3}$   # 查找行尾的abcaccadc
" /\m(a.c){3}$   # 查找行尾的(abc){3}
" /\M(a.c){3}$   # 查找行尾的(a.c){3}
" /\V(a.c){3}$   # 查找任意位置的(a.c){3}$
" 默认使用 \v
set magic

" Configure backspace so it acts as it should act
" eol：如果插入模式下在行开头，想通过退格键合并两行，需要设置eol
" indent：如果用了 :set indent, :set ai 等自动缩进，想用退格键将字段缩进的删掉，必须设置这个选项，否则不响应
" start：要想删除此次插入前的输入，需设置这个选项
set backspace=eol,start,indent
" 对 <,>,h,l 按键开启跨行功能k
set whichwrap+=<,>,h,l

"==========================================
" Display Settings 显示界面格式设置
"==========================================

" 显示当前的行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7

" 窗口最小宽度
" set winwidth=79

" 命令行（在状态行下）的高度，默认为1，这里是2
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
" Always show the status line - use 2 lines for the status bar
set laststatus=2

" 显示行号
set number
" 取消换行
set nowrap

" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" 设置文内智能搜索提示
" 高亮 search 命中的文本
set hlsearch
" 打开增量搜索模式,随着键入即时搜索
set incsearch
" 搜索时忽略大小写
set ignorecase
" 有一个或以上大写字母时仍大小写敏感
set smartcase

" 代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=indent
set foldlevel=99
" 代码折叠自定义快捷键 <leader>zz
let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "zormal! zR"
        let g:FoldMethod = 0
    endif
endfun

" 缩进配置
" Smart indent
set smartindent
" 打开自动缩进
" never add copyindent, will case error
" copy the previous indentation on autoindenting
set autoindent

" Tab 相关设置
" 设置 Tab 键的宽度        [等同的空格个数]
set tabstop=4
" 每一次缩进对应的空格数
set shiftwidth=4
" 按退格键时可以一次删掉 8 个空格
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop
" 按退格键时可以一次删掉 8 个空格
set smarttab
" 将 Tab 自动转化成空格[需要输入真正的 Tab 键时，使用 Ctrl + V + Tab]
" 在内核开发时，Tab 不能转换为空格
set expandtab
" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" A buffer becomes hidden when it is abandoned
" hidden buffer，隐藏的缓冲区，正在被编辑但没有显示在屏幕上
set hidden

set ttyfast

" 增减数字时使用十进制
set nrformats=

" 使用绝对行号，但是保留NumberToggle方法
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
nnoremap <leader>n :call NumberToggle()<cr>

" 防止tmux下vim的背景色显示异常
" Ref: http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

"==========================================
" FileEncode Settings 文件编码,格式
"==========================================
" 设置新文件的编码为 UTF-8
set encoding=utf-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn
"set langmenu=zh_CN.UTF-8
"set enc=2byte-gb18030
" 下面这项只影响普通模式 (非图形界面) 下的 Vim
set termencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B

"==========================================
" others 其它设置
"==========================================
" vimrc文件修改之后自动加载, windows
autocmd! bufwritepost _vimrc source %
" vimrc文件修改之后自动加载, linux
autocmd! bufwritepost .vimrc source %

" 自动补全配置
" 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu

" 增强模式中的命令行自动完成操作
set wildmenu
set wildmode=list:longest
" Ignore compiled and swap files
set wildignore=*.o,*~,*.pyc,*.class,*.swp,*.bak,.svn
" 离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" 回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" quickfix window  s/v to open in split window,  ,gd/,jd => quickfix window => open it
autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><Enter><C-w>L
autocmd BufReadPost quickfix nnoremap <buffer> s <C-w><Enter><C-w>K

" command-line window
autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

" 上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"==========================================
" HotKey Settings  自定义快捷键设置
"==========================================

" 主要按键重定义

" 关闭方向键
" map <Left> <Nop>
" map <Right> <Nop>
" map <Up> <Nop>
" map <Down> <Nop>

" Treat long lines as break lines (useful when moving around in them)
" set swap之后，同物理行上线直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" F1 - F6 设置

" F1 废弃这个键,防止调出系统帮助
" I can type :help on my own, thanks.
" Protect your fat fingers from the evils of <F1>
noremap <F1> <Esc>

" F2 行号开关，用于鼠标复制代码用
" 为方便复制，用<F2>开启/关闭行号显示:
nnoremap <F2> :set number! number?<CR>
" F3 显示可打印字符开关
nnoremap <F3> :set list! list?<CR>
" F4 换行开关
nnoremap <F4> :set wrap! wrap?<CR>

" F6 语法开关，关闭语法可以加快大文件的展示
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented

" disbale paste mode when leaving insert mode
au InsertLeave * set nopaste

" F5 set paste 问题已解决, 粘贴代码前不需要按F5了
" F5 粘贴模式 paste_mode 开关,用于有格式的代码粘贴
" Automatically set paste mode in Vim when pasting in insert mode
" Ref: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

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

" 分屏窗口移动, Smart way to move between windows
" 配合 vim-tmux-navigator, 同时需要修改 .tmux.conf 文件
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>

" Go to home and end using capitalized directions
noremap H ^
noremap L $

" Map ; to : and save a million keystrokes 用于快速进入命令行
nnoremap ; :

" 命令行模式增强，ctrl + a 到行首，ctrl + e 到行尾
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" 搜索相关
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
" 进入搜索Use sane regexes"
nnoremap / /\v
vnoremap / /\v

" Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" 去掉搜索高亮
noremap <silent><leader>/ :nohls<CR>

" switch # *
nnoremap # *
nnoremap * #

" for # indent, python 文件中输入新行时 # 号注释不切回行首
autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#

" 选中及操作改键

" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$

" 复制选中区到系统剪切板中
vnoremap <leader>y "+y

" select all
map <Leader>sa ggVG

" 选中并高亮最后一次插入的内容
nnoremap gv `[v`]

" select block
nnoremap <leader>v V`}

" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %

" kj 替换 Esc
inoremap kj <Esc>
inoremap <C-c> <Esc>

" 滚动Speed up scrolling of the viewport slightly
nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>

" Jump to start and end of line using the home row keys
" nmap t o<ESC>k
" nmap T O<ESC>j

" Quickly close the current window
nnoremap <leader>q :q<CR>

" Quickly save the current file
nnoremap <leader>w :w<CR>

" 交换 ' `, 使得可以快速使用'跳到marked位置
" nnoremap ' `
" nnoremap ` '

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" Quickly edit/reload the vimrc file
" nnoremap <leader>ev :vsp $MYVIMRC<CR>
" nnoremap <leader>ez :vsp ~/.zshrc<CR>
" nnoremap <leader>sv :source $MYVIMRC<CR>

"==========================================
" FileType Settings  文件类型设置
"==========================================

" 具体编辑文件类型的一般设置，比如不要 tab 等
autocmd FileType c,cpp,make set tabstop=8 shiftwidth=8 noexpandtab ai
autocmd FileType python,java set tabstop=4 shiftwidth=4 softtabstop=4 expandtab ai
autocmd FileType bash,sh,shell,awk set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType javascript,html,css,xml,markdown set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd

" disable showmatch when use > in php
" au BufWinEnter *.php set mps-=<:>

" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
" 在写C的时候，一般都是开源项目，因此不要自动删除多余空格，其他随意
" autocmd FileType java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.pl,*.py,*.c,*cpp,*.stp exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为 sh
    if &filetype == 'sh'
        call setline(1, "#!/bin/bash")
    endif

    "如果文件类型为 pl
    if &filetype == 'perl'
        call setline(1, "#!/usr/bin/perl")
    endif

    "如果文件类型为 py
    if &filetype == 'python'
        call setline(1, "#!/usr/bin/env python")
        call append(1, "# -*- coding: utf-8 -*-")
        " call setline(2, "# -*- coding: utf-8 -*-")
    endif

    "如果文件类型为 c
    if &filetype == 'c'
        call setline(1, "#include <stdio.h>")
    endif

    "如果文件类型为 cpp
    if &filetype == 'cpp'
        call setline(1, "#include <iostream>")
        call setline(2, "#include <vector>")
        call setline(3, "using namespace std;")
    endif

    "如果文件类型为 stp
    if &filetype == 'stp'
        call setline(1, "#!/usr/bin/stap")
    endif

    normal G
    normal o
    normal o
endfunc

" 设置可以高亮的关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  endif
endif

"==========================================
" TEMP 设置, 尚未确定要不要
"==========================================

" https://dougblack.io/words/a-good-vimrc.html
" redraw only when we need to
set lazyredraw

"==========================================
" Theme Settings  主题设置
"==========================================

" Set extra options when running in GUI mode
if has("gui_running")
    set guifont=Monaco:h14
    if has("gui_gtk2")   "GTK2
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

" theme主题
colorscheme gruvbox
set background=dark
set t_Co=256

" 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

"==========================================
" Personal Settings
"==========================================

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
