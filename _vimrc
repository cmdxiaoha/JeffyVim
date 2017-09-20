""""""""""""""""""""""""""
" JeffyVim configuration "
""""""""""""""""""""""""""

set nocompatible " out of Vi compatible mode

" Plugin Management: {{{
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" graceful status line
Plugin 'Lokaltog/vim-powerline'
let g:Powerline_colorscheme = 'solarized256'
" color scheme for gui version
Plugin 'altercation/vim-colors-solarized'
" color scheme for console version
Plugin 'tomasr/molokai'

" file,MRU,buffer serching
Plugin 'kien/ctrlp.vim'
" buffer explorer
Plugin 'jlanzarotta/bufexplorer'
" file explorer
Plugin 'scrooloose/nerdtree'
" tag explorer
Plugin 'majutsushi/tagbar'
let g:tagbar_width = 30
let g:tagbar_autofocus = 1

" highlight word in different colors
Plugin 'vim-scripts/Mark'
" easy motion
Plugin 'easymotion/vim-easymotion'
" quick [un]comment lines
Plugin 'scrooloose/nerdcommenter'
" syntax check
Plugin 'scrooloose/syntastic'
" auto completion
Plugin 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_invoke_completion = '<C-x>'
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" snippets completion
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
" command line completion
Plugin 'vim-scripts/CmdlineComplete'
" highlight tailing whitespace
Plugin 'bronson/vim-trailing-whitespace'
" auto closing of quotes, parenthesis, bracket, etc.
Plugin 'Raimondi/delimitMate'
autocmd FileType python let b:delimitMate_nesting_quotes = ['"']
" align text
Plugin 'godlygeek/tabular'

" git migration
Plugin 'tpope/vim-fugitive'

" syntax check for python
Plugin 'nvie/vim-flake8'
" better fold for python
Plugin 'tmhedberg/SimpylFold'
" better indent for python
Plugin 'vim-scripts/indentpython.vim'

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
set noerrorbells                    " do not use error bell
set novisualbell                    " do not use visual bell
set t_vb=                           " do not use terminal bell
set t_Co=256                        " tell terminal supports 256 colors
set foldenable                      " fold lines
set foldmethod=marker               " default use marker to fold
set foldlevel=99                    " don't fold at startup
set cursorline                      " highlight current line
set cursorcolumn                    " highlight current column

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

" file encoding setting
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=gb2312,utf-8,gbk
set fileformat=unix

" set colorscheme
syntax on                           " highlight syntax
set background=dark                 " I link dark background
try
    if has("gui_running")
        colorscheme solarized
    else
        colorscheme molokai
    endif
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme desert
endtry

" set gui interface
if has("gui_running")
    set guioptions-=T               " no toolbar
    set guioptions-=r               " no right-hand scrollbar
    set guioptions-=R               " no right-hand vertically scrollbar
    set guioptions-=l               " no left-hand scrollbar
    set guioptions-=L               " no left-hand vertically scrollbar
    autocmd GUIEnter * win 110 32   " maximum window on startup
    source $VIMRUNTIME/delmenu.vim  " the original menubar has an error on win32, so
    source $VIMRUNTIME/menu.vim     " use this menubar
    language messages zh_CN.utf-8   " use chinese messages if has
    set guifont=consolas:h12        " set font
endif

" set folder method independently
autocmd FileType c,cpp,python setlocal foldmethod=indent

" restore the last quit position when open file.
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     exe "normal g'\"" |
            \ endif

" close vim if the only window left open is a NERDTree
autocmd BufEnter *
            \ if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") |
            \     q |
            \ endif

" }}}

" Key Bindings: {{{
let mapleader = ","
let maplocalleader = "\\"

" map space -> toggle fold
map <Space> za

" move between windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" switch between 2 last buffers
nmap <leader>bb :b#<CR>

" make shift-insert as paste in insert mode
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" disable search match highlight
nmap <leader>l :silent noh<CR>

"  open CtrlP to search file to edit
let g:ctrlp_map = '<leader>sf'
let g:ctrlp_cmd = 'CtrlP'
nmap <leader>sr :CtrlPMRUFiles<CR>
nmap <leader>sb :CtrlPBuffer<CR>

" open file explorer
nmap <leader>f :NERDTreeToggle<CR>

" open tag bar
nmap <leader>t :TagbarToggle<cr>

" goto definition
nmap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" delete tailing whitespace
nmap <leader><space> :FixWhitespace<CR>
vmap <leader><space> :FixWhitespace<CR>

" align text with tabularize
nmap <leader>a :Tab /
vmap <leader>a :Tab /

" }}}

