if has("gui_running")
    "タブを常に表示
    set showtabline=2
    "自動IMをOFF
    set imdisable
    "起動時のウィンドウサイズ
    set lines=80 columns=200
    "アンチエイリアス
    set antialias
    "フォント
    set guifont=DejaVu\ Sans\ Mono\ 12
    "バックアップを取らない
    set nobackup
    "ツールバーを非表示
    set guioptions-=T
    "ビープ音なし
    set visualbell t_vb=
    "カラースキーム
    "colorscheme Tomorrow-Night
    colorscheme inkpot
    let g:indent_guides_auto_colors = 0
    let g:indent_guides_guide_size = 1 
    let g:indent_guides_start_level = 2
endif
