
" syn include /home/anlijiu/.vim/bundle/repos/github.com/gko/vim-coloresque/after/syntax/css/vim-coloresque.vim

let $HTTP_PROXY = "http://127.0.0.1:8099"
let $HTTPS_PROXY = "http://127.0.0.1:8099"

" "语法高亮
syntax on

set encoding=utf-8

"色彩
set background=dark
"set background=light
" colorscheme pablo
" colorscheme inkpot
" colorscheme solarized8
" colorscheme gruvbox 
" colorscheme atom-dark
" colorscheme onedark
colorscheme PaperColor

"enable true color 开启16bit真彩色
if has("termguicolors")
    " Force transparency 透明
    hi! Normal ctermbg=NONE guibg=NONE
    " hi! NonText ctermbg=NONE guibg=NONE
    " hi! VertSplit ctermbg=NONE guibg=NONE
    " hi! LineNr ctermbg=NONE guibg=NONE
    " " Ale
    " hi! ALEErrorSign ctermbg=NONE guibg=NONE
    " hi! ALEWarningSign ctermbg=NONE guibg=NONE
    " " GitGutter
    " hi! GitGutterAdd ctermbg=NONE guibg=NONE
    " hi! GitGutterChange ctermbg=NONE guibg=NONE
    " hi! GitGutterDelete ctermbg=NONE guibg=NONE
    " hi! GitGutterChangeDelete ctermbg=NONE guibg=NONE
    set termguicolors
endif

" copilot.vim
imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" autocmd BufEnter,FileType *
"             \   elseif &ft ==? 'r' | colorscheme  Tomorrow-Night |
"             \   else | colorscheme inkpot|
"             \   endif
"
" set guifont=Ricty-RegularForPowerline:h16
set guifont="Fantasque Sans Mono 17"
" set guifont="Literation Mono Powerline h16"

set helplang=zh

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add csope.out 
  elseif $CSCOPE_DB  != ""
      cs add $CSCOPE_DB 
  endif
  set csverb
endif
" s：查找C代码符号
" g：查找本定义
" d：查找本函数调用的函数
" c：查找调用本函数的函数
" t：查找本字符串
" e：查找本egrep模式
" f：查找本文件
" i：查找包含本文件的文件
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
 
" 折叠， markdown不折叠
let g:markdown_folding = 0
let g:fastfold_savehook = 0
let g:vim_markdown_folding_disabled = 1

let g:denops_disable_version_check = 1
" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

if dein#tap('ultisnips')
  " let g:UltiSnipsSnippetsDir        = $HOME.'/.vim/bundle/repos/github.com/SirVer/ultisnips/'
  " let g:UltiSnipsSnippetDirectories = ['ultisnips']
  " better key bindings for UltiSnipsExpandTrigger
  let g:UltiSnipsExpandTrigger = "<tab>"
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
  let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
endif

" vim-svelte
let g:svelte_preprocessor_tags = [
  \ { 'name': 'postcss', 'tag': 'style', 'as': 'scss' }
  \ ]
let g:svelte_preprocessors = ['typescript', 'postcss', 'scss']

" tagbar 适配typescript
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }

"vim 打开多个文件用tab方式显示buffer
set switchbuf=useopen,usetab,newtab
" tab buffer 快捷键 :bfirst, :blast, :sbuffer, :sbnext, :sbprevious
nnoremap <C-Left> :bprevious<CR>
nnoremap <C-Right> :bnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

"dart
let g:dart_style_guide = 2
let g:loaded_syntastic_dart_dartanalyzer_checker = 0

" let g:neocomplcache_enable_at_startup = 1 "打开vim时自动打开
" let g:neocomplcache_force_overwrite_completefunc = 1 "解决Another plugin set completefunc! Disabled neocomplcache这个错误

"Sudow 命令在vim里面进入root 保存
command -nargs=? Sudow :w !sudo tee %

"让js文件也和jsx文件一样对react jsx缩进高亮
let g:jsx_ext_required = 0

"swp文件
set swapfile
set directory=~/.vim/tmp

"备份文件
set nobackup

"这些模式的文件不备份
set backupskip=/tmp/*,/private/tmp/*

"剪切板作为无名编辑器
set clipboard=unnamed

"命令行高度
set cmdheight=1

"无unodofile
set noundofile

"行号
set number

"复制代码时不要自动换行注释
set pastetoggle=<F9>

"光标行高亮
set cursorline
autocmd VimEnter,Colorscheme * :hi CursorLine cterm=NONE ctermbg=238 guibg=#303030

"搜索结果高亮
set hlsearch
"忽略大小写
"set ignorecase
"esc2次取消搜索结果显示
nmap <ESC><ESC> :nohlsearch<CR><ESC>
"Insertモードを抜けたら日本語入力OFF
"inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

"窗口标题显示
set title

"状态栏显示命令
set showcmd

"ステータスラインを常に表示
"set laststatus=2

set tabstop=4
set softtabstop=4
set shiftwidth=4
"将tab替换成空格
set expandtab
"set list 显示非打印字符，如tab，空格，行尾等。如果tab无法显示，请确定用set
"lcs=tab:>-命令设置了.vimrc文件，并确保你的文件中的确有tab，如果开启了expendtab，那么tab将被扩展为空格。
"set lbr
"set list
"set lcs=tab:▸\ ,trail:-

"自动缩进
set autoindent
"オートインデントの文字数
set shiftwidth=4

"----------------------------------------------------------------
"编码设置
"----------------------------------------------------------------
"Vim 在与屏幕/键盘交互时使用的编码(取决于实际的终端的设定)        
set encoding=utf-8
set langmenu=zh_CN.UTF-8
" 设置打开文件的编码格式  
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1 
set fileencoding=utf-8
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
set termencoding=utf-8
"设置中文提示
language messages zh_CN.utf-8 
"设置中文帮助
set helplang=cn
"设置为双字宽显示，否则无法完整显示如:☆
set ambiwidth=double

"缩进指示  需要安装vim-indent-guides
let g:indent_guides_auto_colors = 1
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=#404040 ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#3a3a3a ctermbg=233
autocmd ColorScheme * highlight Normal ctermbg=None
autocmd ColorScheme * highlight NonText ctermbg=None

let g:indent_guides_enable_on_vim_startup = 1

let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
map <leader>il :IndentLinesToggle<CR>
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)
let g:indentLine_bgcolor_term = 102
let g:indentLine_bgcolor_gui = '#FF5F00'
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'
let g:indentLine_enabled = 1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_setColors = 0
"let g:indentLine_char = '¦'

"css 
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
"scss-syntax.vim
au BufRead,BufNewFile *.scss set ft=scss syntax=scss
autocmd FileType scss set iskeyword+=-

"mustache
autocmd BufRead,BufNewFile *.template setfiletype mustache

"svelte
autocmd BufRead,BufNewFile *.svelte setfiletype svelte

"es6
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

"https://github.com/weirongxu/coc-markdown-preview-enhanced
"https://github.com/neoclide/coc.nvim/wiki/Using-the-configuration-file
autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
autocmd BufNewFile,BufRead *.json set filetype=json
autocmd FileType json syntax match Comment +\/\/.\+$+

"android hal
" autocmd BufRead,BufNewFile *.hal setfiletype c

autocmd BufRead,BufNewFile *._rb setfiletype ruby

"java
" autocmd FileType java setlocal omnifunc=javacomplete#Complete

" 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
set splitbelow
set splitright

"nnoremap <silent> ,1 :!ruby %<CR>
map <F4> :w<CR> :!ruby %<CR>
"noremap <Leader><F4> <ESC>:!ruby %<CR>     "leader 键默认'\' 可通过let mapleader = , 设置
"
" :set foldmethod=indent
" F10 隐藏 或者 显示 注释
nmap <silent> <F10> :call HideComments() <CR>
let s:hide_comments = 0
function! HideComments()
    if (s:hide_comments == 0)
        :set fdm=expr
        :set fde=getline(v:lnum)=~'^\\s#'?1:getline(prevnonblank(v:lnum))=~'^\\s#'?1:getline(nextnonblank(v:lnum))=~'^\\s*#'?1:0
        let s:hide_comments = 1
        set foldenable
        " :hi! link Comment Ignore
        echo "Hide comments"
    else
        let s:hide_comments = 0
        " :hi! link Comment Comment
        :set fdm=syntax
        set nofoldenable
        " set foldenable
        echo "Show comments"
    endif
endfunction

" 検索結果を中心へ
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" CTRL-hjklでウィンドウ移動
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l
" nnoremap <C-h> <C-w>h

" 挿入モードでのカーソル移動
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>

" カーソル位置の単語をyankする
nnoremap vy vawy

"バッファを閉じる
noremap <C-Q> :bdel<CR>

"保存
noremap <C-S> :w<CR>
"連続ペースト
noremap <silent> <C-p> "0p<CR>

".vimrc .gvimrc編集
nnoremap <silent> ,ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> ,eg  :<C-u>edit $MYGVIMRC<CR>

".vimrc .gvimrcリロード
nnoremap <silent> ,rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> ,rg :<C-u>source $MYGVIMRC<CR>

" :tabmove
nnoremap <silent> ,tm :tabmove

"vim 背景透明
hi Normal  ctermfg=252 ctermbg=none

"自动打开nerdtree 文件管理器
" autocmd vimenter * NERDTree
"自动关闭nerdtree 当关闭vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"git gvimdiff
set laststatus=2 "show the status line
set statusline=%-10.3n  "buffer number
 
"FOR VIMDIFF MERGE
let mapleader="," 
map <silent> <leader>1 :diffget 1<CR> :diffupdate<CR>
map <silent> <leader>2 :diffget 2<CR> :diffupdate<CR>
map <silent> <leader>3 :diffget 3<CR> :diffupdate<CR>
map <silent> <leader>4 :diffget 4<CR> :diffupdate<CR>

"Vim中快速移动行文本 
"Alt + k ： 上移
"Alt + j ： 下移
" nnoremap <M-j> :m-2<CR>
" nnoremap <M-k> :m+<CR>
" nnoremap <M-j> :m .+1<CR>==
" nnoremap <M-k> :m .-2<CR>==
" vnoremap <M-j> :m '>+1<CR>gv=gv
" vnoremap <M-k> :m '<-2<CR>gv=gv


" resize horzontal split window
nmap <S-Right> <C-W>><C-W>>
nmap <S-Left> <C-W><<C-W><
" resize vertical split window
nmap <S-Up> <C-W>-<C-W>-
nmap <S-Down> <C-W>+<C-W>+

"for gradle
"
"C++ Class Generator                                                                                                    
function! Class(ClassName)                                                                                              
    "==================  editing header file =====================
    let header = a:ClassName.".hpp"
    :vsp %:h/.hpp
    call append(0, "#ifndef __".toupper(a:ClassName)."_H__")
    call append(1, "#define __".toupper(a:ClassName)."_H__")
    call append(2, " ")                                                                                                  
    call append(3, "class ".a:ClassName." {")                                                                                
    call append(4, "public:")                                                                                        
    call append(5, "    ".a:ClassName."();")                                                                          
    call append(6, "    virtual ~".a:ClassName."();")                                                                 
    call append(7, "protected:")
    call append(8, "private:")
    call append(9, "};")
    call append(11,"")
    call append(10,"#endif // __".toupper(a:ClassName)."_H__")                                                              
    :execute 'write' header                                                                                             
    "================== editing source file ========================                                                      
    let src    = a:ClassName.".cpp"                                                                                     
    :vsp %:h/.cpp
    call append(0,"#include \"".a:ClassName.".hpp\"")                                                                          
    call append(1," ")                                                                                                   
    call append(2,a:ClassName."::".a:ClassName."()")                                                                           
    call append(3,"{")                                                                                                   
    call append(4,"//ctor ")                                                                                             
    call append(5,"}")                                                                                                   
    call append(6," ")                                                                                                   
    call append(7," ")                                                                                                   
    call append(8,a:ClassName."::~".a:ClassName."()")                                                                         
    call append(9,"{")                                                                                                   
    call append(10,"//dtor ")                                                                                            
    call append(11,"}")                                                                                                  
    :execute 'write' src
endfunction    
