"====================================
" FileName: .vimrc
" Author: shane
" Version: 2.5.0
" Email: dongshuai@sia.cn
" Blog: http://blog.csdn.net/z_h_s
" Date: 2015-1-18
"====================================


"""""""""""""""""""""""""""""""""""
" 判断操作系统及vim类型
"""""""""""""""""""""""""""""""""""
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


"""""""""""""""""""""""""""""""""""
" 字符编码及语言设置 
"""""""""""""""""""""""""""""""""""
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
if(g:iswindows==1)
	set langmenu=zh_CN.GBK         " 语言设置
    language messages zh_CN.GBK    " 防止菜单乱码,解决consle输出乱码 
	set encoding=GBK               " 设置 vim 内部使用的编码	
else
	set langmenu=zh_CN.UTF-8       " 语言设置
    language messages zh_CN.utf-8  " 防止菜单乱码,解决consle输出乱码 
	set encoding=utf-8             " 设置 vim 内部使用的编码
endif

if (g:iswindows)
    let &termencoding=&encoding                                                      " 通常win默认中文编码是GBK,set tenc=GBK(termencoding即tenc)
    set fileencodings=ucs-bom,utf-8,gb18030,chinese,latin1,ansi,big5                 " Vim 在打开文件时会根据其选项来识别文件编码(fileencodings即fencs)
	set fileencoding=GBK                                                             " Vim 在保存新建文件时会根据其设置编码来保存(fileencoding即fenc)
	set fileformats=dos                                                              " 保存文件的格式
else
	let &termencoding=&encoding                                                      " linux默认中文编码是utf-8,set tenc=utf-8(termencoding即tenc)
    set fileencodings=utf-8,ucs-bom,gb18030,chinese,latin1,ansi,big5                 " Vim 在打开文件时会根据其选项来识别文件编码(fileencodings即fencs)
	set fileencoding=utf-8                                                           " Vim 在保存新建文件时会根据其设置编码来保存(fileencoding即fenc)
	set fileformats=unix                                                             " 保存文件的格式
endif

if has('gui_gtk2')
	set guifont=Courier_New:h12:w7
	set guifontwide=NSimSun-18030,NSimSun                                            " Gvim 要求等宽字体，其指定字宽是 guifont 的两倍
endif

if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
    set ambiwidth=double           " 让vim能够默认以双字节处理那些特殊字符，例如显示中文引号
endif

set iminsert=0
set imsearch=0
set imcmdline                      " 让 ex(:) mode 时可以输入中文(gvim)
set imdisable                      " 让 xcin 在 insert mode 不自动出现(gvim)


"""""""""""""""""""""""""""""""""""
" edit && file setting
"""""""""""""""""""""""""""""""""""
set nocompatible             " 不设置vi兼容兼容键盘模式
set helplang=cn              " 如帮助文档没能正确显示中文，让其显示中文
set backspace=2              " 使回格键（backspace）正常处理indent, eol, start等
set iskeyword+=_,$,@,%,#,-   " 带有如下符号的单词不要被换行分割
set whichwrap+=<,>,h,l       " 允许backspace和光标键跨越行边界 
set viminfo+=!               " 保存全局变量
set clipboard+=unnamed       " 与windows共享剪贴板
set scrolloff=3              " 光标移动到buffer的顶部和底部时保持3行距离 

set mouse=a                  " 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set selection=exclusive 
set selectmode=mouse,key

set history=100              " history文件中需要记录的行数
filetype on                  " 侦测文件类型
filetype plugin on           " 载入文件类型插件
filetype indent on           " 为特定文件类型载入相关缩进文件
syntax enable                " 开启语法侦测
set hidden                   " 允许在有未保存的修改时切换缓冲区
set confirm                  " 在处理未保存或只读文件的时候，弹出确认

set nobackup                 " 不要备份文件（根据自己需要取舍）
set nowb
set noswapfile

setlocal noswapfile          " 不要生成swap文件，当buffer被丢弃的时候隐藏它 
set bufhidden=hide 

if exists("&autoread")       " 设置当文件被外部改变的时侯自动读入文件
	set autoread
endif
 
set report=0                 " 通过使用: commands命令，告诉我们文件的哪一行被改变过
set path=.,                  " 设置路径,多个路径用逗号分隔，例如："E:/Web/htdocs",
set nobomb                   " 让vim不要自动设置字节序标记，因为并不是所有编辑器都可以识别字节序标记的

" set viminfo='10,\"100,:20,%,n~/.viminfo                                       " 决定自动保存的viminfo文件中保存的信息
" set sessionoptions+=blank,buffers,curdir,folds,help,options,tabpages,winsize  " 会话文件恢复当前编辑环境的空窗口、所有的缓冲区、当前目录、
                                                                                " 折叠(fold)相关的信息、帮助窗口、所有的选项和映射、所有的标签页(tab)、
                                                                                " 窗口大小


"""""""""""""""""""""""""""""""""""
" display && voise setting
"""""""""""""""""""""""""""""""""""
if(g:iswindows==1)
	au GUIEnter * simalt ~x              " Windows下Vim启动后最大化
endif

if (g:isGUI)
	set guioptions=                                                             " 隐藏全部的gui选项，使用 F4 隐藏和显示菜单栏、工具栏、右边滚动条
	map <silent> <F4> :    if &guioptions =~# 'T' <bar>
	                           \set guioptions-=T <bar>
	                           \set guioptions-=m <bar>
	                           \set guioptions-=r <bar>
	                       \else <Bar>
	                           \set guioptions+=T <bar>
	                           \set guioptions+=m <bar>
	                           \set guioptions+=r <bar>
	                       \endif<CR>
endif

set shortmess=atI                        " 启动的时候不显示那个援助索马里儿童的提示
set t_Co=256                             " 开启256颜色支持
set nu                                   " 显示行号
set nolist                               " 隐藏对齐竖线     
" set listchars=tab:>-,trail:-           " 显示TAB健 
syntax on                                " 语法高亮
set visualbell                           " 闪烁 
set cmdheight=2                          " 命令行（在状态行下）的高度，默认为1，这里是2
set winminwidth=8                        " 非当前窗口的最小宽度
set fillchars=stl:\ ,stlnc:-,vert:\|,fold:-,diff:-                                             " 填充状态行和垂直分割线的字符

highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white                          " 高亮字符，让其不受100列限制
match OverLength '\%101v.*'

set ruler                                " 显示光标状态
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)                                          " 在状态行上显示光标所在位置的行号和列号

set laststatus=2                         " 显示状态栏(默认值为1, 无法显示状态栏),显示内容如下
set statusline=%F%m%r%h%w,\ [%n],\ %Y,\ %{&fileformat}\ \ ASCII=\%b,HEX=\0x\%B,%{((&fenc==\"\")?\"\":\"\".&fenc)}%=
set statusline+=[POS=%l,%c%V][%p%%]\ [%{strftime(\"%H:%M\ %d/%m/%y\")}\ %{$USER}@%{hostname()}]

highlight StatusLine guifg=SlateBlue guibg=Yellow cterm=bold ctermfg=yellow ctermbg=blue      " 状态行颜色
highlight StatusLineNC guifg=Gray guibg=White

set cursorline                                  " 行高亮当前行
" set cursorcolumn                              " 列高亮当前列
hi cursorline guibg=#666666                     " 行高亮颜色设置
hi CursorColumn guibg=#666666                   " 列高亮颜色设置

set errorbells                                  " 让vim发出讨厌的滴滴声
" set vb t_vb=                                  " 去掉警告声音


"""""""""""""""""""""""""""""""""""
" search && match setting
"""""""""""""""""""""""""""""""""""
set matchtime=5              " 匹配括号高亮的时间（单位是十分之一秒）
set showmatch                " 高亮显示匹配的括号
set hlsearch                 " 高亮被搜索的对象
set ignorecase               " 在搜索的时候忽略大小写 

set incsearch                " 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$   " 输入:set list命令时应该显示些啥？


"""""""""""""""""""""""""""""""""""
" typesetting(排版)
"""""""""""""""""""""""""""""""""""
set tabstop=4                " 制表符为4 
set softtabstop=4            " 软制表符宽度为4，统一缩进为4 
set shiftwidth=4             " 设置缩进的空格数为4
set noexpandtab              " 不要用空格代替制表符
set nowrap                   " 不要换行
set smarttab                 " 在行和段开始处使用制表符
set formatoptions=tcrqn      " 自动格式化
set formatoptions+=mM        " 正确地处理中文字符的折行和拼接 
set autoindent               " 继承前一行的缩进方式，特别适用于多行注释 
set smartindent              " 为C程序提供自动缩进 
set cindent                  " 使用C样式的缩进
" set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s      " 设置C/C++语言的具体缩进方式（以windows风格为例）

set linespace=0              " 字符间插入的像素行数目
set wildmenu                 " 增强模式中的命令行自动完成操作

if has("gui_running")  
	set paste                " 设置粘贴模式，这样粘贴过来的程序代码不会错位(在终端下使用vimim时要将 set paste 注释掉，否则根本无法使用vimim)
endif                 
set pastetoggle=<C-H>        " 方便使用vimim中的五笔打英文时的切换
 
" set textwidth=100          " 设置超过100字符自动换行
" au BufWinEnter * let w:m2=matchadd('Underlined','\%>100v.\+', -1)  " 第100列往后加下划线
" syn match out80 /\%80v./ containedin=ALL 
" hi out80 guifg=white guibg=red


"""""""""""""""""""""""""""""""""""
" 代码折叠
"""""""""""""""""""""""""""""""""""
set foldmethod=syntax        " 代码折叠
set foldmethod=marker        " 依标记折叠
set foldlevel=100            " 启动 vim 时不要自动折叠代码
set foldcolumn=4             " 设置折叠模式 
"set foldopen=all            " 光标遇到折叠，折叠就打开 
"set foldclose=all           " 移开折叠时自动关闭折叠

" zf zo zc zd zr zm zR zM zn zi zN
" za  打开/关闭在光标下的折叠
" zA  循环地打开/关闭光标下的折叠
" zo  打开 (open) 在光标下的折叠
" zO  循环打开 (Open) 光标下的折叠
" zc  关闭 (close) 在光标下的折叠
" zC  循环关闭 (Close) 在光标下的所有折叠
" zM  关闭所有折叠
" zR  打开所有的折叠
 
" 6种折叠方式
" manual   手工定义折叠 
" indent   更多的缩进表示更高级别的折叠 
" expr     用表达式来定义折叠 
" syntax   用语法高亮来定义折叠 
" diff     对没有更改的文本进行折叠 
" marker   对文中的标志折叠  
 

"""""""""""""""""""""""""""""""""""
" 目录设置
"""""""""""""""""""""""""""""""""""
autocmd BufEnter *exec "cd %:p:h"      " 进入当前编辑的文件的目录 
set bsdir=buffer                       " 自动设定文件浏览器目录为当前目录 
set autochdir                          " 自动切换当前目录为当前文件所在的目录  


"""""""""""""""""""""""""""""""""""
" 编译
"""""""""""""""""""""""""""""""""""
map <F6> :make<CR>                     " 设置一键编译

"""""""""""""""""""""""""""""""""""
" ctags setting
"""""""""""""""""""""""""""""""""""
set tags=tags;                         " 开启ctags(有分号),后面的路径是使用ctags -R 后生成的tags文件所在目录
                                       " Vim搜索tags文件时，如果在当前目录中没有查找到，会到父级目录中查找tags文件，依次类推

if exists("tags")                      " 启动vim时如果存在tags则自动加载
    set tags=..\tags
endif


""""""""""""""""""""""""""""""
" cscope setting
""""""""""""""""""""""""""""""
set cscopequickfix=s-,c-,d-,i-,t-,e-   " 设定是否使用quickfix窗口显示cscope结果
" 所有配置均在 .vim/bundle/cscope_maps/plugin/cscope_maps.vim 中完成
nmap <C-/>s :cs find s <C-R>=expand("<cword>")<CR><CR>          " 查找C语言符号，即查找函数名、宏、枚举值等出现的地方，s或者用0表示
nmap <C-/>g :cs find g <C-R>=expand("<cword>")<CR><CR>          " 查找函数、宏、枚举等定义的位置，类似ctags的功能，g或者用1表示
nmap <C-/>d :cs find d <C-R>=expand("<cword>")<CR><CR>          " 查找本函数调用的函数，d或者用2表示
nmap <C-/>c :cs find c <C-R>=expand("<cword>")<CR><CR>          " 查找调用本函数的函数，c或者用3表示
nmap <C-/>t :cs find t <C-R>=expand("<cword>")<CR><CR>          " 查找指定的字符串，t或者用4表示
nmap <C-/>e :cs find e <C-R>=expand("<cword>")<CR><CR>          " 查找egrep模式，相当于egrep功能，但查找速度快多了，e或者用6表示
nmap <C-/>f :cs find f <C-R>=expand("<cfile>")<CR><CR>          " 查找并打开文件，类似vim的find功能，f或者用7表示
nmap <C-/>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>        " 查找包含本文件的文件，i或者用8表示


"""""""""""""""""""""""""""""""""""
" taglist setting
"""""""""""""""""""""""""""""""""""
if g:iswindows              "设定windows系统中Exuberant ctags程序的位置
 	let Tlist_Ctags_Cmd = 'ctags'
else                        "设定linux系统中Exuberant ctags程序的位置
	let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif

let Tlist_Auto_Open=1                  " 在启动VIM后，自动打开taglist窗口
let Tlist_Sort_Type = "name"           " 按照名称排序
let Tlist_Compart_Format = 1           " 压缩方式 
let Tlist_Enable_Fold_Column = 0       " 不要显示折叠树 
let Tlist_Show_One_File = 1            " 不同时显示多个文件的tag，只显示当前文件的
" let Tlist_Use_Right_Window = 1       " 在右侧窗口中显示taglist窗口 
" let Tlist_Use_SingleClick= 1         " 缺省情况下，在双击一个tag时，才会跳到该tag定义的位置，设置后单击tag跳转
let Tlist_Exit_OnlyWindow = 1          " 如果taglist窗口是最后一个窗口，kill窗口也kill掉buffer ，则退出vim
let Tlist_Process_File_Always=1        " taglist始终解析文件中的tag，不管taglist窗口有没有打开
let Tlist_File_Fold_Auto_Close=1       " 同时显示多个文件中的tag时，可使taglist只显示当前文件tag，其它文件的tag都被折叠起来
" let Tlist_File_Fold_Auto_Close = 0   " 不要关闭其他文件的tags
let Tlist_GainFocus_On_ToggleOpen=1    " 打开taglist时获得输入焦点
"let Tlist_Display_Prototype = 0
"let Tlist_Close_On_Select = 1


""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""
let g:netrw_winsize = 30
let g:netrw_timefmt='%Y-%m-%d %H:%M:%S' 
nmap <silent> <leader>fe :Sexplore!<cr> 


""""""""""""""""""""""""""""""
" BufExplorer setting
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0         " Do not show default help.
let g:bufExplorerShowRelativePath=1    " Show relative paths.
let g:bufExplorerSortBy='mru'          " Sort by most recently used.
let g:bufExplorerSplitRight=0          " Split left.
let g:bufExplorerSplitVertical=1       " Split vertically.
let g:bufExplorerSplitVertSize = 30    " Split width
let g:bufExplorerUseCurrentWindow=1    " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber


""""""""""""""""""""""""""""""
" minibufexpl setting
""""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 


""""""""""""""""""""""""""""""
" winManager setting  整合各个窗口
""""""""""""""""""""""""""""""
let g:AutoOpenWinManager = 1
let g:winManagerWidth = 30
let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"  " 此处double quotation marks 也可以使用 single quotation marks
let g:defaultExplorer = 0
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <leader>wu :wa<cr>:TlistUpdate<cr>:FirstExplorerWindow<cr>
nmap <silent> <leader>wm :WMToggle<cr>  " 打开关闭Explorer


""""""""""""""""""""""""""""""
" a setting
""""""""""""""""""""""""""""""
nnoremap <silent> <F12> :A<CR>


""""""""""""""""""""""""""""""
" grep setting
""""""""""""""""""""""""""""""
nnoremap <silent> <F3> :Grep<CR>


""""""""""""""""""""""""""""""
" new-omni-completion setting
""""""""""""""""""""""""""""""
filetype plugin indent on          " 打开文件类型检测
set complete=.,w,b,k,t,i
set completeopt=longest,menu       " 关掉智能补全时的预览窗口


""""""""""""""""""""""""""""""
" supertab setting
""""""""""""""""""""""""""""""
" let g:SuperTabRetainCompletionType=2
" let g:SuperTabDefaultCompletionType="<C-X><C-o>"
" let g:SuperTabDefaultCompletionType="context"


""""""""""""""""""""""""""""""
" visual mark setting
""""""""""""""""""""""""""""""
" For gvim, use "Ctrl + F2" to toggle a visual mark. 
" For both vim and gvim, use "mm" to toggle a visual mark. 
" Use "F2" to navigate through the visual marks forward in the file. 
" Use "Shift + F2" to navigate backwards. 
" If you do not like the highlighting scheme, you could change "SignColor" in the script.  Feedbacks are welcome. :-)


""""""""""""""""""""""""""""""
" vimim setting
""""""""""""""""""""""""""""""
let g:vimim_cloud = 'google,baidu'  
let g:vimim_map = 'tab_as_gi'  
let g:vimim_mode = 'dynamic'
if(g:iswindows==1)
	let g:vimim_mycloud = 0
	let g:vimim_plugin = 'C:\Program Files(x86)\Vim\vimfiles\bundle\vimim\plugin'	
else
	let g:vimim_mycloud = "dll:".$HOME."/.vim/bundle/vimim/plugin/libvimim64.so"  
	let g:vimim_plugin = '~/.vim/bundle/vimim/plugin'
endif
" let g:vimim_punctuation = 2
" let g:vimim_shuangpin = 0
" let g:vimim_toggle = 'wubijd,pinyin,google,baidu'


""""""""""""""""""""""""""""""
" colorscheme setting
""""""""""""""""""""""""""""""
set background=dark
set t_Co=256                             " 开启256颜色支持
colors molokai
