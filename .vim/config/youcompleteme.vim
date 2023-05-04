" log太占空间， 关闭绝大部分log
let g:ycm_server_log_level = 'critical'

let g:ycm_global_ycm_extra_conf='/home/anlijiu/.vim/config/.ycm_extra_conf.py'
let g:ycm_clangd_binary_path = "/home/anlijiu/.vim/bundle/repos/github.com/ycm-core/YouCompleteMe/third_party/ycmd/third_party/clangd/output/bin/clangd"
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_confirm_extra_conf=0
let g:ycm_autoclose_preview_window_after_completion = 1 

set completeopt=longest,menu
let g:ycm_confirm_extra_conf = 0
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_warning_symbol = '**'
let g:ycm_error_symbol = '->'
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration <CR>
" inoremap pumvisible()?"":""
" inoremap pumvisible()?"":""
" inoremap pumvisible()?"":""
" inoremap pumvisible()?"":""
nmap <F5> :YcmDiags
let g:ycm_server_use_stdout = 1
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.','re![_a-zA-z0-9]'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::','re![_a-zA-Z0-9]'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

filetype plugin indent on
