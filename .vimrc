"バックスペースで消える文字
set backspace=start,eol,indent


"はじめにfiletype無効化（初期化）
"filetype off

set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent

"yank clipbord share
set clipboard=unnamed,autoselect

"タブ文字、スペース、行末などに表示される文字指定
set list
set listchars=tab:>-,extends:<,trail:-,eol:\ 

"Pythonのためのインデント設定
"autocmd FileType python setl autoindent
"autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

autocmd FileType html :setlocal indentexpr=""

"シンタックスハイライト
syntax on

"自動で認識してくれるので明示的に書かなくていいらしい？

"set t_Co=256
"終了するときに戻さないと何故か抜けたあとのshellの色がおかしくなる
autocmd VimLeave * let &t_Co = 8

"検索ハイライト
set hlsearch

"行番号
set number

"折り返さない
set nowrap

"vimの下部に表示される情報
set laststatus=2
set statusline=%F%m%r%h%w\ [%{&fileencoding},\ %{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]

" vim-indent-guides
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=237
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1

"最後にカーソルが合った行に移動
augroup vimrcEx
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END "


"------------------------------------------------------------------------------
"プラグイン管理(NeoBundle)
"neobundle 自動インストール
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'


"neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

"追加プラグイン
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-jp/vim-go-extra'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'kana/vim-submode'
NeoBundle 'Vimjas/vim-python-pep8-indent'

"Color
NeoBundle 'tomasr/molokai'

call neobundle#end()

"Required:
filetype plugin indent on

NeoBundleCheck
"//---------------------------------------------------------------------

"molokai設定
if isdirectory(expand("~/.vim/bundle/molokai/"))
    "全角スペースの可視化
    autocmd ColorScheme * hi link TwoByteSpace Error
    autocmd VimEnter,WinEnter * let w:m_tbs = matchadd("TwoByteSpace", '　')
    
    "molokai色設定
    colorscheme molokai
    let g:molokai_original = 1
    let g:rehash256 = 1
    set background=dark
endif

if isdirectory(expand("~/.vim/bundle/vim-submode/"))
    call submode#enter_with('bufmove', 'n', '', '<C-w>>', '<C-w>>')
    call submode#enter_with('bufmove', 'n', '', '<C-w><', '<C-w><')
    call submode#enter_with('bufmove', 'n', '', '<C-w>+', '<C-w>+')
    call submode#enter_with('bufmove', 'n', '', '<C-w>-', '<C-w>-')
    call submode#map('bufmove', 'n', '', '>', '<C-w>>')
    call submode#map('bufmove', 'n', '', '<', '<C-w><')
    call submode#map('bufmove', 'n', '', '+', '<C-w>+')
    call submode#map('bufmove', 'n', '', '-', '<C-w>-')
endif

"NERDTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap <silent><C-n> :NERDTree<CR>

let g:NERDTreeWinSize=40

"Ctrl+h, Ctrl+lで1単語戻る・進む
nnoremap <silent><C-h> b
nnoremap <silent><C-l> w

"Ctrl+u, Ctrl+iで行頭・行末へ
nnoremap <silent><C-u> <C-0>
nnoremap <silent><C-i> <C-$>

"インデントだけの空行でインデントが削除されるのを防ぐ
nnoremap o oX<C-h>
nnoremap O OX<C-h>
inoremap <CR> <CR>X<C-h>

" 入力モード中でもctrk + h,j,k,lで移動できるようにする
imap <C-k> <Up>
imap <C-j> <Down>
imap <C-h> <Left>
imap <C-l> <Right>

"FileType Plugin有効化(~/.vim/ftpluginに拡張子ごとの設定ファイルを定義できる)
"filetype plugin on
