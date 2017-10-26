set nocompatible

"display line numbers
set number
"indent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

"enable file type detection, plugin, indent
filetype plugin indent on
"enable syntax highlight
if has('syntax')
    syntax on
endif

" font
"if has('gui')
"    set guifont=Ricty\ 12
"endif

"show matching brackets
set showmatch

"show search results while typing
set incsearch
"ignore case when pattern contains only lowercase
set ignorecase
set smartcase
"searches wrap around the end of the file
set wrapscan
"highlight all matches
set hlsearch
"stop highlighting by pushing <ESC> twice
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

"move cursor by display lines
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" Better command-line completion
if has('wildmenu')
    set wildmenu
    set wildmode=list:longest,full
endif

"copy to clipboard
if has('clipboard')
    set clipboard&
    set clipboard^=unnamed,unnamedplus
endif

"encoding
"set encoding=utf-8
"set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
"Japanese related setting: https://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-japanese
if has('multi_byte')
    "Use twice the width for multi-byte characters
    set ambiwidth=double
endif
" don't insert space when multi-byte
set formatoptions+=mMj
"as much as possible of the last line will be displayed.
set display+=lastline

"do not make a backup
set nobackup

"http://vim.wikia.com/wiki/Example_vimrc
"buffer becomes hidden when abandoned
set hidden
"automatically read changed file again
set autoread
" Show partial commands in the last line of the screen
set showcmd
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
" Display the cursor position 
set ruler
" Always display the status line, even if only one window is displayed
set laststatus=2
" raise a dialogue asking if you wish to save changed files.
set confirm
 
" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

"restore undo history
if has('persistent_undo')
    if !isdirectory(expand('~/.vim/undo'))
        call mkdir(expand('~/.vim/undo'))
    endif
	set undodir=~/.vim/undo
	set undofile
endif

"if buffer is already open, focus the window
if has('gui')
  packadd! editexisting
endif

"settings for binary mode
augroup vimrc
    autocmd!
    autocmd BufReadPre  *.bin let &bin=1
    autocmd BufReadPost *.bin if &bin | %!xxd
    autocmd BufReadPost *.bin set ft=xxd | endif
    autocmd BufWritePre *.bin if &bin | %!xxd -r
    autocmd BufWritePre *.bin endif
    autocmd BufWritePost *.bin if &bin | %!xxd
    autocmd BufWritePost *.bin set nomod | endif
augroup END
