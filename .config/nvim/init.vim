"reference
"https://github.com/Shougo/dein.vim
"https://www.lisz-works.com/entry/vim-deinvim

let s:dein_dir = expand('$HOME/.nvim/plugins')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

"Install dein if not installed
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

"Manage plugins by dein
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    
    "Put plugins here!
    call dein#add('tomasr/molokai')
    call dein#add('scrooloose/nerdtree')
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('scrooloose/syntastic')
    call dein#add('https://github.com/github/copilot.vim') # Exec `:Copilot setup` after install

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif


"File type
autocmd BufNewFile,BufRead *.asm set filetype=nasm

"Plugin settings

"ColorScheme(molokai)
"colorscheme molokai
"let g:rehash256 = 1
"set background=dark


"NredTree
nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap <silent><C-n> :NERDTree<CR>
let g:NERDTreeWinSize=40


"vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=237


"syntastic
let g:syntastic_python_checkers = ["flake8"]
"let g:syntastic_python_checkers = ["pep8"]
let g:syntastic_asm_checkers = ["nasm"]

let g:syntastic_c_config_file = ".syntastic_c_config"

"recomend setting: https://github.com/vim-syntastic/syntastic#3-recommended-settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"Vim settings

"backspaceで消す文字
set backspace=start,eol,indent

"検索ハイライト
set hlsearch

"行番号表示
set number

"折り返し
set nowrap

"下部に表示される情報
set laststatus=2
set statusline=%F%m%r%h%w\ [%{&fileencoding},\ %{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]

"インデント関連
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab
set autoindent

"ハイライト
syntax on

"最後にカーソルがあった行で開く
augroup vimrcEx
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END "

"Ctrl+h, Ctrl+lで1単語戻る・進む
nnoremap <silent><C-h> b
nnoremap <silent><C-l> w

"各種ディレクトリ
let s:vim_dir = '~/.vim'
let s:swap_dir = s:vim_dir . '/swp'
let s:backup_dir = s:vim_dir . '/back'
let s:undo_dir = s:vim_dir . '/undo'

if !isdirectory(s:swap_dir)
    execute 'silent !mkdir -p' s:swap_dir
endif
if !isdirectory(s:backup_dir)
    execute 'silent !mkdir -p' s:backup_dir
endif
if !isdirectory(s:undo_dir)
    execute 'silent !mkdir -p' s:undo_dir
endif

set swapfile
"set backup
"set undofile
execute 'set directory=' . s:swap_dir
execute 'set backupdir=' . s:backup_dir
execute 'set undodir=' . s:undo_dir



"Python autopep8(Format python code at save)
function! RunAutopep8()
    call execute(":silent %!autopep8 -")
endfunction

if executable('autopep8')
    "Format automatically at save file
    "autocmd FileType python autocmd! BufWritePre *.py call RunAutopep8()
    
    "Format manualy on normal mode
    autocmd FileType python nnoremap <S-f> :call RunAutopep8() <CR>
endif



"極力最後に置くといいらしい？
filetype plugin indent on

