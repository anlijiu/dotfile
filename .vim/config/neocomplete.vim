    let g:EclimCompletionMethod = 'omnifunc' 
    let g:neocomplete#enable_at_startup = 1
    "ユーザー定義スニペット保存ディレクトリ
    let g:neocomplcache_snippets_dir=$HOME.'/.vim/snippets'
    "大文字が入力されるまで大文字小文字を無視する
    let g:neocomplete#enable_smart_case = 1
    "補完をキャンセル
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<BS>"
    "Enterで補完を確定(endwiseとの関係でおかしくなる対策）
    function! s:my_crinsert()
        return pumvisible() ? neocomplete#close_popup() : "\<Cr>"
    endfunction
    inoremap <silent> <CR> <C-R>=<SID>my_crinsert()<CR>
    "TABで補完を選択
    inoremap <expr><TAB> pumvisible() ? "<C-N>" : "<TAB>"

    let g:neocomplete#min_keyword_length = 3
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'javascript' : $HOME.'/.vim/dict/javascript.dict',
        \ 'scala' : $HOME.'/.vim/dict/scala.dict',
        \ 'ruby' : $HOME.'/.vim/dict/ruby.dict',
        \ 'c' : $HOME.'/.vim/dict/c.dict',
        \ 'cpp' : $HOME.'/.vim/dict/cpp.dict'
        \ }
