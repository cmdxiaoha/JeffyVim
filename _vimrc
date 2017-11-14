"=============================================================================
" Vim configuration.
"=============================================================================

""" Basic Settings: {{{

" out of Vi compatible mode
set nocompatible

" search setting
set incsearch                       " incremental search
set hlsearch                        " highlight search match
set ignorecase                      " do case insensitive matching
set smartcase                       " do not ignore if search pattern has CAPS

" backup setting
set nobackup                        " do not create backup file
set noswapfile                      " do not create swap file
set backupcopy=yes                  " overwrite the original file

" tab setting
set tabstop=4                       " number of spaces in a tab
set softtabstop=4                   " insert and delete space of <tab>
set shiftwidth=4                    " number of spaces for indent
set expandtab                       " expand tabs into spaces

" file encoding setting
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=gb2312,utf-8,gbk
set fileformat=unix

" folder setting
set foldenable                      " fold lines
set foldmethod=marker               " default use marker to fold
set foldlevel=99                    " don't fold at startup
autocmd FileType c,cpp,python setlocal foldmethod=syntax

" misc setting
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
set clipboard=unnamed               " use system clipboard

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
    if has("win32")
        set guifont=consolas:h12    " set font for windows
    else
        set guifont=DejavuSansMono\ 12 " set font for unix
    endif
endif

" restore the last quit position when open file.
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     exe "normal g'\"" |
            \ endif

" move between windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" swtich between last two buffers
nmap <C-e> :b#<CR>
" don't highlight current search
nmap <C-c> :silent noh<CR>
" navigate in quickfix window
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>

"}}}

""" Plugin Settings: {{{

" Use Vundle to manage plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'Lokaltog/vim-powerline'
Plugin 'kien/ctrlp.vim'
Plugin 'dkprice/vim-easygrep'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'aceofall/gtags.vim'
Plugin 'vim-scripts/Mark'
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'honza/vim-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'vim-scripts/CmdlineComplete'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'Raimondi/delimitMate'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-fugitive'
call vundle#end()
filetype plugin indent on

" set map leader for all plugin bindings
let mapleader = ","
let maplocalleader = "\\"

" set colorscheme
syntax on                           " highlight syntax
set background=dark
try
    if has("gui_running")
        colorscheme solarized
    else
        colorscheme molokai
    endif
    set cursorline                  " highlight current line
    set cursorcolumn                " highlight current column
catch
    colorscheme desert
endtry

" use graceful power line
let g:Powerline_colorscheme = 'solarized256'

" tagbar setting
nmap <leader>t :TagbarToggle<cr>
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_autofocus = 1

" NERDTree setting
nmap <leader>f :NERDTreeToggle<CR>
let g:NERDTreeWinPos = 'right'
let g:NERDTreeWinSize = 30
let g:NERDTreeNaturalSort = 1
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeAutoDeleteBuffer = 1
" close vim if the only window left open is a NERDTree
autocmd BufEnter *
            \ if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") |
            \     q |
            \ endif

" CtrlP setting: search file, mru, buffer
let g:ctrlp_map = '<leader>pf'
let g:ctrlp_cmd = 'CtrlP'
nmap <leader>pr :CtrlPMRUFiles<CR>
nmap <leader>pb :CtrlPBuffer<CR>

" EasyGrep setting
let g:EasyGrepMode = 2
let g:EasyGrepRecursive = 1

" YouCompleteMe setting
nmap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_invoke_completion = '<leader>;'
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1

" UltiSnips setting
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" delete tailing whitespace
nmap <leader><space> :FixWhitespace<CR>
vmap <leader><space> :FixWhitespace<CR>

" align text with tabularize
nmap <leader>a :Tab /
vmap <leader>a :Tab /

" delimitMate setting: auto close quotes
let delimitMate_expand_cr = 1
autocmd FileType python let b:delimitMate_nesting_quotes = ['"']

" gtags setting
set cscopetag
set cscopeprg='gtags-cscope'
let g:Gtags_Auto_Update = 1
let g:GtagsCscope_Auto_Load = 1
let g:GtagsCscope_Quiet = 1
let g:GtagsCscope_Auto_Map = 0
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>si :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>sn :tn<CR>
nmap <leader>sp :tp<CR>
nmap <C-LeftMouse> :cs find d <C-R>=expand("<cword>")<CR>:<C-R>=line('.')<CR>:%<CR>

" }}}

