
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd


  " 見た目系
  " 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 現在の行を強調表示（縦）
set cursorcolumn
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" leaderキーをカンマに設定
let mapleader=","

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable

colorscheme molokai

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" -laのような表示になります
let g:netrw_liststyle=1
" ヘッダを非表示にする
let g:netrw_banner=0
" サイズを(K,M,G)で表示する
let g:netrw_sizestyle="H"
" 日付フォーマットを yyyy/mm/dd(曜日) hh:mm:ss で表示する
let g:netrw_timefmt="%Y/%m/%d(%a) %H:%M:%S"
" プレビューウィンドウを垂直分割で表示する
let g:netrw_preview=1
" コピペの時にF3で実行できるようにする。
set pastetoggle=<F3>
" ファイル検索時にEnterを押した時に右側にファイルを開くように分割する
let g:netrw_browse_split = 4

set backspace=indent,eol,start

let g:snipMate = { 'snippet_version' : 1 }

" { などの括弧を書いたときに閉じ括弧を補完する。
function! MyInsertPair(open, close)
  if &paste
    return a:open
  else
    return a:open. a:close . "\<Left>"
  endif
endfunction

inoremap { <C-R>=MyInsertPair('{', '}')<CR>
inoremap [ <C-R>=MyInsertPair('[', ']')<CR>
inoremap ( <C-R>=MyInsertPair('(', ')')<CR>
inoremap " <C-R>=MyInsertPair('"', '"')<CR>
inoremap ' <C-R>=MyInsertPair("'", "'")<CR>

" change cmd to powershell
if has("win64") || has("win32")
	set shell=pwsh
endif

" key mapping
inoremap <silent> jj <ESC>

" :w で保存した時にformatする
function! FormatOnSave()
    let l:ext = expand('%:e')
    let l:curr_file = expand('%:p')

    if (l:ext == 'pl' || l:ext == 'pm' || l:ext == 't')
        execute '!perltidy -b ' . l:curr_file
    endif
endfunction


" Create an autocmd to call the function on saving a file
command! -nargs=0 Format call FormatOnSave()
nnoremap <leader>f :call FormatOnSave()<CR>

" 現在のファイルを保存して、そのファイルを実行する関数
function! ExecuteFile()
    " 現在のファイルを保存
    write

    " ファイルの拡張子を取得
    let l:filetype = expand('%:e')

    " 拡張子に応じたコマンドを実行
    if l:filetype ==# 'py'
        execute '!python3' shellescape(@%, 1)
    elseif l:filetype ==# 'pl'
        execute '!perl' shellescape(@%, 1)
    else
        echo "Unsupported file type: " . l:filetype
    endif
endfunction

" leaderキー + eでExecuteFile関数を実行
nnoremap <leader>e :call ExecuteFile()<CR>

" ExecuteコマンドでExecuteFile関数を実行
command! Execute call ExecuteFile()


