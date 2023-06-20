let g:coc_global_extensions = ['coc-markdown-preview-enhanced', 'coc-webview', 'coc-css', 'coc-docker', 'coc-go', 'coc-html', 'coc-json', 'coc-pyright', 'coc-rust-analyzer', 'coc-sh', 'coc-solargraph', 'coc-sumneko-lua', 'coc-toml', 'coc-tsserver', 'coc-yaml']
nmap <silent> <leader><space>mf :<C-u>CocCommand prettier.formatFile<cr>
" 逗号 空格 mp  这四个键打开markdown preview
nmap <silent> <leader><space>mp :<C-u>CocCommand markdown-preview-enhanced.openPreview<cr>
nmap <silent> <leader><space>mi :<C-u>CocCommand markdown-preview-enhanced.openImageHelper<cr>
nmap <silent> <leader><space>mI :<C-u>CocCommand markdown-preview-enhanced.showUploadedImages<cr>
nmap <silent> <leader><space>mr :<C-u>CocCommand markdown-preview-enhanced.runCodeChunk<cr>
nmap <silent> <leader><space>mR :<C-u>CocCommand markdown-preview-enhanced.runAllCodeChunks<cr>
