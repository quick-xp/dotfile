scriptencoding utf-8
set nocompatible
syntax on
set t_Co=256

" ----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/neobundle.vim.git
endif

" Required:
call neobundle#begin(expand('/Users/chato/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

let g:neobundle#log_filename = $HOME."/neobundle.log"

" ----------------------------
" clip board 共有
set clipboard+=autoselect
set clipboard+=unnamed

"basic setting
set number
set autoindent
set showmatch
set smartcase
set smarttab
set softtabstop=2
set expandtab
set tabstop=2
set shiftwidth=2
set noswapfile


" plugin
NeoBundle 'Shougo/vimproc'

" ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neomru.vim'
" Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'

" ファイルをtree表示してくれる
NeoBundle 'scrooloose/nerdtree'

filetype plugin on
filetype indent on
" NERDTree の設定
""""""""""""""""""""""""""""""
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" タブ移動
nnoremap <C-n> gt
nnoremap <C-p> gT
""""""""""""""""""""""""""""""

" ----- color scheme ------
"NeoBundle 'jpo/vim-railscasts-theme'
"colorscheme railscasts
NeoBundle 'nanotech/jellybeans.vim'

" -----ctagsの非同期生成-----
NeoBundle 'alpaca-tc/alpaca_tags'
" alpaca_tags 設定
augroup AlpacaTags
	autocmd!
	if exists(':Tags')
		autocmd BufWritePost Gemfile TagsBundle
		autocmd BufEnter * TagsSet
		" 毎回保存と同時更新する場合はコメントを外す
		autocmd BufWritePost * TagsUpdate
	endif
augroup END

" -----Powerline-----
NeoBundle 'alpaca-tc/alpaca_powertabline'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}

" ---- 補完 -----
NeoBundle 'Shougo/neocomplcache'

"neocomplecacheの設定

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplcache#close_popup()
" inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

"neocomplecache ここまで


"Align : 高機能整形・桁揃えプラグイン
NeoBundle 'Align'

"フィルタリングと整形
NeoBundle 'godlygeek/tabular'

"マルチバイト対応の整形
NeoBundle 'h1mesuke/vim-alignta'
" -- でメソッドチェーン整形
NeoBundle 'c9s/cascading.vim'

" -----for rails-----
filetype off

" --vim-rails--
NeoBundle 'tpope/vim-rails'
NeoBundle 'scrooloose/syntastic'
" syntasticの設定
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:rails_syntax=1

function! SetUpRailsSetting()
	nnoremap <buffer><Space>rr :R<CR>
	nnoremap <buffer><Space>a :A<CR>
	nnoremap <buffer><Space>m :Rmodel<Space>
	nnoremap <buffer><Space>c :Rcontroller<Space>
	nnoremap <buffer><Space>v :Rview<Space>
	nnoremap <buffer><Space>p :Rpreview<CR>
endfunction

aug MyAutoCmd
	au User Rails call SetUpRailsSetting()
aug END

aug RailsDictSetting
	au!
aug END

" --- vim ruby ----
NeoBundle 'vim-ruby/vim-ruby'
"--rubocop--"
NeoBundle 'ngmy/vim-rubocop'

" rubocop
let g:vimrubocop_keymap = 0
nnoremap ,rr <ESC>:RuboCop<CR>

"--unite-rails--"
"-- Usage [:Unite rails/xxx] 
NeoBundle 'basyura/unite-rails'

"-----vim-endwise-----
NeoBundle 'tpope/vim-endwise'

"-----comment on/off-----
NeoBundle 'tomtom/tcomment_vim'

"-----インデントの色付け
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1

" ログファイルを色づけしてくれる
NeoBundle 'vim-scripts/AnsiEsc.vim'

" 行末の半角スペースを可視化
NeoBundle 'bronson/vim-trailing-whitespace'

"coffee script
NeoBundle 'kchmck/vim-coffee-script'

" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

" タブ移動
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>

"erb インデント
NeoBundle 'othree/html5.vim'
NeoBundle 'nono/vim-handlebars'
"-----sphinx-------"
NeoBundle 'Rykka/riv.vim'
NeoBundle 'Rykka/InstantRst'
let g:riv_fold_level = 1
let g:riv_web_browser = '"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"'
let g:riv_temp_path = 0
let g:riv_html_code_hl_style = "friendly"

"一時ファイルを無視"
set directory=~/.vim/tmp
set backupdir=~/.vim/tmp
set undodir=~/.vim/tmp

" Required:
call neobundle#end()

filetype plugin indent on
filetype on

colorscheme jellybeans

" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-B> :Unite buffer<CR>
" ファイル一覧
noremap <C-M> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" Tabで開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
au FileType unite inoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""


""""""""""unite rails-settting
nnoremap :rc :<C-u>Unite rails/controller<CR>
nnoremap :rm :<C-u>Unite rails/model<CR>
nnoremap :rv :<C-u>Unite rails/view<CR>
nnoremap :rh :<C-u>Unite rails/helper<CR>
nnoremap :rrs :<C-u>Unite rails/stylesheet<CR>
nnoremap :rs :<C-u>Unite rails/serializers<CR>
nnoremap :rj :<C-u>Unite rails/javascript<CR>
nnoremap :ro :<C-u>Unite rails/route<CR>
nnoremap :rg :<C-u>Unite rails/gemfile<CR>
nnoremap :rt :<C-u>Unite rails/spec<CR>

nnoremap :jc :<C-u>Unite<CR>rails/javascript controller
nnoremap :jmm :<C-u>Unite<CR>rails/javascript models
nnoremap :jmc :<C-u>Unite<CR>rails/javascript collection
nnoremap :jr :<C-u>Unite<CR>rails/javascript router
nnoremap :jt :<C-u>Unite<CR>rails/javascript template
nnoremap :jv :<C-u>Unite<CR>rails/javascript view
""""""""""


NeoBundleCheck
