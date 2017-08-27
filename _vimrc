"
" JeffyVim configuration
"

set nocompatible " out of Vi compatible mode

" Vundle configuration: {{{
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugins
Plugin 'jlanzarotta/bufexplorer'
Plugin 'vim-scripts/CmdlineComplete'
Plugin 'vim-scripts/Mark'
Plugin 'vim-scripts/mru.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/taglist.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'

" end of Vundle
call vundle#end()
filetype plugin indent on
" }}}

" Global configuration: {{{
set number                          " show line number
set numberwidth=3                   " minimal culumns for line numbers
set textwidth=0                     " do not wrap words (insert)
set nowrap                          " do not wrap words (view)
set showcmd                         " show (partial) command in status line
set ruler                           " line and column number of the cursor position
set wildmenu                        " enhanced command completion
set wildmode=list:longest,full      " command completion mode
set laststatus=2                    " always show the status line
set mouse=a                         " use mouse in all mode
set foldenable                      " fold lines
set foldmethod=indent               " fold as indent
set foldlevel=99                    " don't fold by default
set noerrorbells                    " do not use error bell
set novisualbell                    " do not use visual bell
set t_vb=                           " do not use terminal bell

set wildignore=.svn,.git,*.swp,*.bak,*~,*.o,*.a
set autowrite                       " auto save before commands like :next and :make
set hidden                          " enable multiple modified buffers
set history=100                     " record recent used command history
set autoread                        " auto read file that has been changed on disk
set backspace=indent,eol,start      " backspace can delete everything
set completeopt=menuone,longest     " complete options (insert)
set pumheight=10                    " complete popup height
set scrolloff=5                     " minimal number of screen lines to keep beyond the cursor
set autoindent                      " automatically indent new line
set cinoptions=:0,l1,g0,t0,(0,(s    " C kind language indent options

set tabstop=4                       " number of spaces in a tab
set softtabstop=4                   " insert and delete space of <tab>
set shiftwidth=4                    " number of spaces for indent
set expandtab                       " expand tabs into spaces
set incsearch                       " incremental search
set hlsearch                        " highlight search match
set ignorecase                      " do case insensitive matching
set smartcase                       " do not ignore if search pattern has CAPS
set nobackup                        " do not create backup file
set noswapfile                      " do not create swap file
set backupcopy=yes                  " overwrite the original file
set clipboard=unnamed               " use system clipboard

" Set file encoding
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=gb2312,utf-8,gbk
set fileformat=unix

" Set face showing
syntax on                           " highlight syntax
if has("gui_running")
    set guioptions-=T               " no toolbar
    set guioptions-=r               " no right-hand scrollbar
    set guioptions-=R               " no right-hand vertically scrollbar
    set guioptions-=l               " no left-hand scrollbar
    set guioptions-=L               " no left-hand vertically scrollbar
    autocmd GUIEnter * simalt ~x    " maximum window on startup
    source $VIMRUNTIME/delmenu.vim  " the original menubar has an error on win32, so
    source $VIMRUNTIME/menu.vim     " use this menubar
    language messages zh_CN.utf-8   " use chinese messages if has
    colorscheme evening             " set color scheme
else
    colorscheme default
endif

" Restore the last quit position when open file.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g'\"" |
    \ endif
" }}}

" Key Bindings: {{{
let mapleader = ","
let maplocalleader = "\\"

" map : -> toggle fold
map <Space> za

" move between windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Don't use Ex mode, use Q for formatting
map Q gq

" make Y consistent with C and D
nnoremap Y y$

" toggle highlight trailing whitespace
nmap <silent> <leader>l :set nolist!<CR>

" Ctrl-E to switch between 2 last buffers
nmap <C-E> :b#<CR>

" ,e to fast finding files. just type beginning of a name and hit TAB
nmap <leader>e :e **/

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" ,n to get the next location (compilation errors, grep etc)
"nmap <leader>n :cn<CR>
"nmap <leader>p :cp<CR>

" Ctrl-N to disable search match highlight
nmap <silent> <C-N> :silent noh<CR>

" center display after searching
nnoremap n   nzz
nnoremap N   Nzz
nnoremap *   *zz
nnoremap #   #zz
nnoremap g*  g*zz
nnoremap g#  g#z
" }}}

" Plugin Settings: {{{
" mru
let MRU_Window_Height = 10
nmap <Leader>h :MRU<cr>

" taglist
let g:Tlist_WinWidth = 25
let g:Tlist_Use_Right_Window = 0
let g:Tlist_Auto_Update = 1
let g:Tlist_Process_File_Always = 1
let g:Tlist_Exit_OnlyWindow = 1
let g:Tlist_Show_One_File = 1
let g:Tlist_Enable_Fold_Column = 0
let g:Tlist_Auto_Highlight_Tag = 1
let g:Tlist_GainFocus_On_ToggleOpen = 1
nmap <Leader>t :TlistToggle<cr>

" nerdcommenter
let g:NERDDefaultAlign = 'left'
let g:NERDCustomDelimiters = { 'c': { 'left': '//' } }

" nerdtree
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize = 30
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeIgnore = ['\.o$', '\~$']
nmap <Leader>f :NERDTreeToggle<CR>
nmap <Leader>F :NERDTreeFind<CR>

" man.vim - view man page in VIM
source $VIMRUNTIME/ftplugin/man.vim

" SimpylFold
let g:SimpylFold_docstring_preview = 1

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_invoke_completion = '<C-x>'
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let python_highlight_all=1
