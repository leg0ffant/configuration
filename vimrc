syntax enable

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
let g:vundle_default_git_proto='git'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

" ----------------------------------------------
"             Plugin List here
" ----------------------------------------------
Plugin 'gmarik/Vundle.vim'
Plugin 'molokai'
Plugin 'lokaltog/vim-powerline'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'kien/ctrlp.vim'
Plugin 'sjl/gundo.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'Gundo'

call vundle#end()
filetype plugin indent on    " required
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" -----------------------------------------------
"           + Settings 
" -----------------------------------------------

colorscheme molokai
set background=dark
set laststatus=2
set encoding=utf-8
set t_Co=256

set number " Display line numbers
set background=dark " We are using dark background in vim
set title " show title in console title bar
set wildmenu " Menu completion in command mode on <Tab>
set wildmode=full " <Tab> cycles between all matching choices.

" don't bell or blink
set noerrorbells
set vb t_vb=

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**
