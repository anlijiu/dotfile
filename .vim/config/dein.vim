if &compatible
  set nocompatible " Be iMproved
endif

" Required:
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein

if dein#load_state('~/.cache/dein')
    " Required:
    call dein#begin('~/.vim/bundle')

    " Let dein manage dein
    call dein#add('~/.cache/dein')

    call dein#add('Shougo/neocomplete')
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')
"     call dein#add('Shougo/unite.vim' replaced by Shougo/denite.nvim
    call dein#add('Shougo/denite.nvim')
    call dein#add('neoclide/denite-git')
    call dein#add('thinca/vim-quickrun')
    call dein#add('vim-scripts/BufOnly.vim')
    call dein#add('scrooloose/syntastic')
    call dein#add('kchmck/vim-coffee-script')
    call dein#add('ujihisa/unite-colorscheme')
    call dein#add('scrooloose/nerdtree')
    call dein#add('tpope/vim-fugitive')
    call dein#add('vim-scripts/closetag.vim')
    call dein#add('tpope/vim-rails')
    call dein#add('vim-scripts/surround.vim')
    call dein#add('tpope/vim-endwise')
    call dein#add('violetyk/cake.vim')
    call dein#add('basyura/unite-rails')
    call dein#add('altercation/vim-colors-solarized')
    call dein#add('vim-scripts/AnsiEsc.vim')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('vim-scripts/ack.vim')
    call dein#add('kana/vim-fakeclip')
    call dein#add('estin/htmljinja')
    call dein#add('derekwyatt/vim-scala')
    call dein#add('Shougo/vimshell.vim')
    call dein#add('vim-scripts/vim-tags')
    call dein#add('tpope/vim-cucumber')
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('vim-ruby/vim-ruby')
    call dein#add('tpope/vim-haml')
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('Yggdroot/indentLine')
    call dein#add('othree/html5.vim')
    call dein#add('cakebaker/scss-syntax.vim')
    call dein#add('groenewege/vim-less')
    call dein#add('slim-template/vim-slim')
    call dein#add('tyru/caw.vim')
    call dein#add('majutsushi/tagbar')
    call dein#add('godlygeek/tabular')
    call dein#add('plasticboy/vim-markdown')
"sudo npm -g install instant-markdown-d
"gem install redcarpet pygments.rb
    call dein#add('suan/vim-instant-markdown')
    call dein#add('zenorocha/dracula-theme')
    call dein#add("airblade/vim-gitgutter")
    call dein#add("gregsexton/gitv")
    call dein#add("tpope/vim-commentary")
    call dein#add("morhetz/gruvbox")
    call dein#add("tfnico/vim-gradle")
    call dein#add("chriskempson/base16-vim")
    call dein#add('isRuslan/vim-es6-snippets')
    call dein#add('digitaltoad/vim-jade')
    call dein#add('fatih/vim-go')
    call dein#add('vim-scripts/a.vim')
"     call dein#add('artur-shaik/vim-javacomplete2')
    call dein#add("ervandew/supertab")
    call dein#add("gko/vim-coloresque")
    call dein#add("pangloss/vim-javascript")
    call dein#add("mxw/vim-jsx")
    call dein#add("tpope/vim-unimpaired")
    call dein#add("drmikehenry/vim-fixkey")
    call dein#add("udalov/kotlin-vim")
    call dein#add("dart-lang/dart-vim-plugin")
    call dein#add('leafgarland/typescript-vim')
    call dein#add('jparise/vim-graphql')
    call dein#add('mustache/vim-mustache-handlebars')
    call dein#add('wannesm/wmgraphviz.vim')
    call dein#add('lilydjwg/colorizer')
"    call dein#add('marijnh/tern_for_vim')

  call dein#end()
  call dein#save_state()
endif

"if dein#check_install():
"  call dein#install()
"endif
