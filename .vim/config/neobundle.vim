set nocompatible

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

NeoBundle has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'BufOnly.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'closetag.vim'
NeoBundle 'tpope/vim-rails'
NeoBundle 'surround.vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'violetyk/cake.vim'
NeoBundle 'basyura/unite-rails'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'AnsiEsc.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'ack.vim'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'estin/htmljinja'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'vim-tags'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-haml'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'othree/html5.vim'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'godlygeek/tabular'
NeoBundle 'plasticboy/vim-markdown'
"sudo npm -g install instant-markdown-d
"gem install redcarpet pygments.rb
NeoBundle 'suan/vim-instant-markdown'
NeoBundle 'zenorocha/dracula-theme'
NeoBundle "airblade/vim-gitgutter"
NeoBundle "gregsexton/gitv"
NeoBundle "tpope/vim-commentary"
NeoBundle "morhetz/gruvbox"
NeoBundle "tfnico/vim-gradle"
NeoBundle "chriskempson/base16-vim"
NeoBundle 'isRuslan/vim-es6-snippets'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'fatih/vim-go'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'artur-shaik/vim-javacomplete2'
NeoBundle "ervandew/supertab"
NeoBundle "gko/vim-coloresque"
NeoBundle "pangloss/vim-javascript"
NeoBundle "mxw/vim-jsx"
NeoBundle "tpope/vim-unimpaired"
NeoBundle "drmikehenry/vim-fixkey"
NeoBundle "udalov/kotlin-vim"
NeoBundle "dart-lang/dart-vim-plugin"
"NeoBundle 'marijnh/tern_for_vim'
call neobundle#end()
" NeoBundleInstall
" NeoBundleCheck
