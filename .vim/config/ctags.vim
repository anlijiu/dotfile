" ctags
"let g:vim_tags_main_file = '.tags'
"let g:vim_tags_project_tags_command = "/usr/local/bin//ctags -f .tags -R {OPTIONS} {DIRECTORY} 2>/dev/null"
"let g:vim_tags_gems_tags_command = "/usr/local/bin/ctags -f .Gemfile.lock.tags -R {OPTIONS} `bundle show --paths` 2>/dev/null"

set tags=tags;
nmap <c-]> g<c-]> 
set tags+=~/disk/esp/esp-idf/components/tags

" sudo ctags -R --c++-kinds=+p --fields=+iaS -I G_GNUC_NULL_TERMINATED -I G_GNUC_CONST  -f tags /usr/include/
set tags+=/usr/include/tags

" cd ~/workspace/flutter/flutter/bin/cache/artifacts/engine/linux-x64-release
" ctags -R --c++-kinds=+p --fields=+iaS -I G_GNUC_NULL_TERMINATED -I G_GNUC_CONST
set tags+=~/workspace/flutter/flutter/bin/cache/artifacts/engine/linux-x64-release/tags
"set tags+=.Gemfile.lock.tags

"nnoremap <silent> ,tg :TagsGenerate<CR>
