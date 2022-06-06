vim-dotfile
===========

vim-dotfile

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh

sh ./installer.sh ~/.cache/dein

cd ~/.vim/bundle/repos/github.com/ycm-core
gitc ycm-core/YouCompleteMe
cd YouCompleteMe
python3 install.py --all
vim
:call dein#recache_runtimepath()

https://gitlab.gnome.org/hub/feedreader-export.git
cargo run -- --output feeds.opml ~/.local/share/feedreader/data/feedreader-7.db
导出 feedreader opml
