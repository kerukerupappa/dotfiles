"--------------------
" 基本的な設定
"--------------------
"新しい行のインデントを現在行と同じにする
set autoindent

"改行なし
set completeopt=menuone
set formatoptions=q

" クリップボードの共有
"set clipboard=unnamed,autoselect

"vi互換をオフする
set nocompatible

" スワップファイルを作成しない
set noswapfile
"set directory=$HOME/vimbackup

"バックアップファイルを作成しない
set nobackup
set noundofile
"set backupdir=$HOME/vimbackup

"タブの代わりに空白文字を指定する
set expandtab

"変更中のファイルでも、保存しないで他のファイルを表示する
set hidden

"インクリメンタルサーチを行う
set incsearch

"行番号を表示する
set number

"閉括弧が入力された時、対応する括弧を強調する
set showmatch

"新しい行を作った時に高度な自動インデントを行う
set smarttab

" grep検索を設定する
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh

" 検索結果のハイライトをEsc連打でクリアする
"nnoremap <ESC><ESC> :nohlsearch<CR>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" タブバーを表示
set showtabline=2

" タブを表示するときの幅
set tabstop=4

" タブを挿入するときの幅
set shiftwidth=4

" タブの可視化
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

" 行末の空白を削除
autocmd BufWritePre * :%s/\s\+$//e

" 別名
command VF VimFiler
let g:vimfiler_edit_action = 'tabopen'
"autocmd VimEnter * VimFiler -split -simple -winwidth=40

" 別名
nmap bd :bdelete!

" キーマッピング
nmap OA gi<Up>
nmap OB gi<Down>
nmap OC gi<Right>
nmap OD gi<Left>

" 「コピーした文字で、繰り返し上書きペーストしたい
vnoremap <silent> <C-p> "0p<CR>

" ESCでIMEを確実にOFF
inoremap <ESC> <ESC>:set iminsert=0<CR>

" 置換
nmap gs :<C-u>%s//g<Left><Left>
vnoremap gs :s//g<Left><Left>

" 検索
nmap <Space>/ *<C-o>
nmap g<Space>/ g*<C-o>

" エスケープ
inoremap <silent> jj <ESC>

"
" NeoBundle関係
"
" NeoBundle がインストールされていない時、
" もしくは、プラグインの初期化に失敗した時の処理
function! s:WithoutBundles()
  colorscheme desert
  " その他の処理
endfunction

if has('mac')
    "let g:vimproc_dll_path = $HEME . '.vim/bundle/vimproc/autoload/vimproc_mac.so'
endif
" NeoBundle よるプラグインのロードと各プラグインの初期化
function! s:LoadBundles()
  " 読み込むプラグインの指定
  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/neocomplete'
  NeoBundle 'Shougo/vimfiler'
  NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
  NeoBundle 'Shougo/vimshell.vim'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'nathanaelkane/vim-indent-guides'
  NeoBundle 'tomtom/tcomment_vim'
  NeoBundle 'jceb/vim-hier'
  NeoBundle 'kana/vim-operator-user'
  NeoBundle 'itchyny/lightline.vim'
  NeoBundle 'vim-scripts/taglist.vim'

endfunction


" NeoBundle がインストールされているなら LoadBundles() を呼び出す
" そうでないなら WithoutBundles() を呼び出す
function! s:InitNeoBundle()
  if isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    filetype plugin indent off
    if has('vim_starting')
      set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif
    try
      call neobundle#begin(expand('~/.vim/bundle/'))
      NeoBundleFetch 'Shougo/neobundle.vim'
      call neobundle#end()
      call s:LoadBundles()
  catch
      call s:WithoutBundles()
    endtry
  else
    call s:WithoutBundles()
  endif

  filetype indent plugin on
  syntax on
endfunction

call s:InitNeoBundle()

"
" neocomplete
"
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
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
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" 複数の補完ワードがあった場合に 0 が設定されていれば1つのみ表示する
let g:marching_enable_dup = 1

" 通信のタイムアウトを秒数で設定
let g:marching#sync_wandbox#timeout = "10"


" neocomplete.vim と併用して使用する場合
let g:marching_enable_neocomplete = 1

" 処理のタイミングを制御する
" 短いほうがより早く補完ウィンドウが表示される
set updatetime=200

" オムニ補完時に補完ワードを挿入したくない場合
imap <buffer> <C-x><C-o> <Plug>(marching_start_omni_complete)

" キャッシュを削除してからオムに補完を行う
imap <buffer> <C-x><C-x><C-o> <Plug>(marching_force_start_omni_complete)


"
" vim-indent-guides
"
colorscheme desert
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_color_change_percent=30
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2


"
" TagList
"
let Tlist_Show_One_File = 1                   " 現在表示中のファイルのみのタグしか表示しない
let Tlist_Use_Right_Window = 1                " 右側にtag listのウインドうを表示する
let Tlist_Exit_OnlyWindow = 1                 " taglistのウインドウだけならVimを閉じる

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }


