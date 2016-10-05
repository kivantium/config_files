"既に開いているGVIMがあるときはそのVIMを前面にもってくる
if has('gui')
  runtime macros/editexisting.vim
endif

"行番号の表示	
set number
"yankしたテキストがクリップボードにも入るようにする
set clipboard=unnamed,autoselect
"検索対象を打っている間から検索する
set incsearch
"大文字小文字を無視する、大文字が入力されると区別する
set ignorecase
set smartcase
" 検索がファイルの末尾に達したら最初に戻る
set wrapscan
" 検索文字列をハイライトする
set hlsearch
"対応する括弧を表示
set showmatch
" フォントの設定
set guifont=Ricty\ 12
"見かけ上の行で移動
nnoremap j gj
nnoremap k gk
" エンコーディングの優先順位
set fileencodings=utf-8,cp932,euc-jisx0213
"日本語入力関連 https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-japanese
"□や○の文字があってもカーソル位置がずれないようにする。
set ambiwidth=double
"画面最後の行をできる限り表示する。
set display+=lastline
" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full

"インデント
set smarttab
set expandtab
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=0
" set Filetype of .sv file
au BufNewFile,BufRead *.sv setf systemverilog
" indentation set to 2.
autocmd FileType html,xhtml,css,xml set shiftwidth=2 softtabstop=2
autocmd FileType vhdl,verilog,systemverilog set shiftwidth=2 softtabstop=2
" in makefiles, do not expand tabs to spaces
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0

"バックアップファイルを作らない
set nobackup
" ファイルを閉じてもundoできるようにする
if has('persistent_undo')
	set undodir=~/.vim/undo
	set undofile
endif

autocmd BufNewFile *.cpp 0r $HOME/.vim/template/cpp.txt

"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif
" Required:
set runtimepath+=/home/kivantium/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('/home/kivantium/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
" Bundles
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Yggdroot/indentLine'
" Required:
call neobundle#end()
filetype plugin indent on
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" vim -b : edit binary using xxd-format!
    augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

" indentLineを高速に
let g:indentLine_faster = 1
" これを入れないとLaTeXで数式を打つときに平文で表示されなくなる
let g:tex_conceal=''
" neocomlete関連の設定
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {'default' : ''}
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Enable omni completion.
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"インクルードパスの指定
let g:neocomplete#include_paths = {
  \ 'c'    : '.,/usr/include',
  \ 'cpp'    : '.,/usr/include',
  \ }
"インクルード文のパターンを指定
let g:neocomplete#include_patterns = {
  \ 'c' : '^\s*#\s*include',
  \ 'cpp' : '^\s*#\s*include',
  \ }
