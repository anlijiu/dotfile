if &compatible
  set nocompatible " Be iMproved
endif

" Required:
" Add the dein installation directory into runtimepath
set runtimepath^=~/.cache/dein/repos/github.com/Shougo/dein.vim

" 手动清除cache: call dein#recache_runtimepath()
" 位置: .vim/config/bundle/.cache/.vimrc/.dein/
if dein#load_state('~/.cache/dein')
    " Required:
    call dein#begin('~/.vim/bundle')

    " Let dein manage dein
    call dein#add('~/.cache/dein')

    """""""""""""""  color theme """"""""""""""  
    call dein#add("morhetz/gruvbox")
    call dein#add("lifepillar/vim-solarized8")
    call dein#add('joshdick/onedark.vim')
    call dein#add('NLKNguyen/papercolor-theme')
    " call dein#add('dracula/dracula-theme')
    " call dein#add('altercation/vim-colors-solarized')
    
    call dein#add('thinca/vim-quickrun')

    """"""""""""""" Delete all the buffers except the current/named buffer
    call dein#add('vim-scripts/BufOnly.vim')

    """"""""""""""" 折叠 fold """"""""""""""""""""""""""
    call dein#add('Konfekt/FastFold')
    
    """"""""""""""" copilot """"""""""""""""""""""""""
    " call dein#add('github/copilot.vim')
    
    """""""""""""""  file explore """"""""""""""  
    call dein#add('scrooloose/nerdtree')
    " git
    call dein#add('tpope/vim-fugitive')
    " git viewer
    call dein#add('rbong/vim-flog')
    " diff git hunks
    call dein#add('airblade/vim-gitgutter')

    " add <html></html> <xml></xml> end tag
    call dein#add('alvan/closetag.vim')
    call dein#add('vim-scripts/surround.vim')

    " add yaml support
    call dein#add('stephpy/vim-yaml')

    "ifend/endif/more, add 'end'
    call dein#add('tpope/vim-endwise')

    "让vim懂ascii颜色
    call dein#add('vim-scripts/AnsiEsc.vim')

    "vim 底部状态栏
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    
    "perl ack like mode in vim
    " call dein#add('vim-scripts/ack.vim')
 
    " cpp helper generate .hpp/.cpp skeleton
    " call dein#add('LucHermitte/lh-vim-lib')
    " call dein#add('LucHermitte/lh-style')
    " call dein#add('LucHermitte/lh-brackets')
    " call dein#add('LucHermitte/mu-template')
    " call dein#add('LucHermitte/lh-dev')
    " call dein#add('LucHermitte/alternate-lite')
    " call dein#add('LucHermitte/lh-cpp', { 'rev': 'gotoimpl_with_libclang' })

    " 增强cpp 高亮
    call dein#add('octol/vim-cpp-enhanced-highlight')

    " 使系统粘贴板和y通用
    call dein#add('kana/vim-fakeclip')

    " mustache&handlebars模板
    call dein#add('mustache/vim-mustache-handlebars')
    " jinja2 模板
    call dein#add('Glench/Vim-Jinja2-Syntax')
    "jade 模板
    call dein#add('digitaltoad/vim-pug')

    " scala语言
    " call dein#add('derekwyatt/vim-scala')

    "dark powered shell interface for vim
    call dein#add('Shougo/deol.nvim')

    " replace vim-tags with vim-gutentags 
    " call dein#add('szw/vim-tags')
    call dein#add('ludovicchabant/vim-gutentags')
    call dein#add('skywind3000/vim-quickui')

    " EditorConfig plugin for Vim
    call dein#add('editorconfig/editorconfig-vim')

    call dein#add('vim-ruby/vim-ruby')

    " Vim runtime files for Haml, Sass, and SCSS
    call dein#add('tpope/vim-haml')
 

    " 缩进图形化
    call dein#add('nathanaelkane/vim-indent-guides')
    " 另一个缩进图形化, 上面那个启用之后，这个就不好使了，也没必要用了
    " call dein#add('Yggdroot/indentLine')

    " html5 & svg
    call dein#add('othree/html5.vim')
    
    " less
    call dein#add('groenewege/vim-less')

    "gc/gci/gca/gcb/gco/等注释
    call dein#add('tyru/caw.vim')

    call dein#add('majutsushi/tagbar')

    " :Tab /=  用于程序文件中的等号对齐， :Tab/|用于markdown里面的表格对齐
    " http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
    call dein#add('godlygeek/tabular')

    " markdown fold
    call dein#add('plasticboy/vim-markdown')

    " markdown 浏览器
    "npm -g install instant-markdown-d@next
    " call dein#add('suan/vim-instant-markdown')
    " cd ~/.vim/bundle/repos/github.com/iamcco/
    " gitc iamcco/markdown-preview.nvim
    " cd markdown-preview.nvim/app
    " yarn install
    " call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					"\ 'build': 'sh -c "cd app && yarn install"' })

    " 对于markdown-preview-enhanced 来说 ，需要依赖coc.nvim 和 coc-webview
    " cd ~/.deno/bin 
    " 下载 https://github.com/denoland/deno/releases/latest/download/deno-x86_64-unknown-linux-gnu.zip 到 ~/.deno/bin
    " unzip deno-x86_64-unknown-linux-gnu.zip
    call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'master', 'build': 'npm ci' })
    call dein#add('weirongxu/coc-webview')
    call dein#add('weirongxu/coc-markdown-preview-enhanced')
    call dein#add('neoclide/jsonc.vim')
    
    "vim识别rgb,hsl,named colors颜色
    call dein#add("gko/vim-coloresque")
    " call dein#add("ap/vim-css-color")

    " 让.命令支持map集合
    " call dein#add('tpope/vim-repeat')


    """""""""""""""  code complete """"""""""""""  
    " call dein#add('ycm-core/YouCompleteMe', {'build': 'python3 install.py --clangd-completer', 'merged': 1})
    " 受不了这个补全enter就直接选择了
    " call dein#add('Shougo/ddc.vim')
    " call dein#add('Shougo/ddu.vim')
    " call dein#add('vim-denops/denops.vim')
    " call dein#add('Shougo/deoppet.nvim')
    " call dein#add('artur-shaik/vim-javacomplete2')
    " call dein#add("ervandew/supertab")

    " gradle file type
    call dein#add("tfnico/vim-gradle")

    " snippets
    call dein#add('honza/vim-snippets')

    call dein#add('isRuslan/vim-es6')

    call dein#add('fatih/vim-go')

    call dein#add('vim-scripts/a.vim')

    " javascript
    call dein#add("pangloss/vim-javascript")

    " JSX highlighting
    call dein#add("MaxMEllon/vim-jsx-pretty")
    
    " 括号成对 映射
    "call dein#add("tpope/vim-unimpaired")

    "svelte 语法
    call dein#add("evanleck/vim-svelte")

    "就是这个fixkey的插件导致每次打开一个有内容的新文件都会直接将第一行的最后一个字符替换成0, 不知道为什么，也不知道怎么找原因
    "call dein#add("drmikehenry/vim-fixkey")

    "kotlin
    call dein#add("udalov/kotlin-vim")

    "dart
    call dein#add("dart-lang/dart-vim-plugin")

    " flutter
    call dein#add("thosakwe/vim-flutter")

    " highlight for gtk glib
    " call dein#add("vim-scripts/gtk-vim-syntax")

    " typescript
    call dein#add('leafgarland/typescript-vim')

    " astrojs
    call dein#add('wuelnerdotexe/vim-astro')

    " graphql
    call dein#add('jparise/vim-graphql')

    "  Graphviz
    call dein#add('wannesm/wmgraphviz.vim')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
 call dein#install()
endif
