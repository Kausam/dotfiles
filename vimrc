" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
"filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" plugin from http://v...content-available-to-author-only...s.org/vim/scripts.html
" Plugin 'L9'
Plugin 'valloric/YouCompleteMe'
Plugin 'wincent/command-t'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'NLKNguyen/papercolor-theme'
" Personal note-taking tool
Plugin 'vimwiki/vimwiki'
Plugin 'tpope/vim-surround'
Plugin 'tommcdo/vim-kangaroo'
" All of your Plugins must be added before the following line
call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
"inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else


endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

"save and load folds automatically when opening and closing files
augroup AutoSaveFolds
    autocmd!
    " nested is needed by bufwrite* (if triggered via other autocmd)
   autocmd BufWinLeave,BufWritePost,BufLeave ?* nested silent! mkview!
   autocmd BufWinEnter,BufEnter ?* silent! loadview
augroup end

" xml settings
"augroup xml_settings " {
"    autocmd!
"    autocmd FileType xml,xsd set iskeyword+=-,. foldmethod=indent shiftwidth=4 expandtab
"augroup END " }

func BackgroundAutoSwitch(timer) 
    if has('macunix') && trim(system('defaults read -g AppleInterfaceStyle')) ==# "Dark"
        set background=dark
    else
        set background=light
    endif
endfunc
"Automatically switch to dark/light mode depending on the OS config
let _ = timer_start(3600000, 'BackgroundAutoSwitch', {'repeat': -1})

colorscheme PaperColor 
" let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
set backupdir=~/.vim/backup,.
set undodir=~/.vim/undo,.
set number
set clipboard=unnamed
set relativenumber
set tabstop=4 shiftwidth=4 expandtab
set autoindent smartindent
set cursorline
"set autochdir
"set t_Co=256   " This is may or may not needed.
"hi StatusLine ctermfg=231 ctermbg=231. 231 is the color white 
"fold according to indent
"set foldmethod=indent
"open file for the first time with folds
set foldlevelstart=1
"When forward search fails, don't start searching from the beginning of file
"Like wise for backward search too
set nowrapscan
"store fold and cursor information in the view
set viewoptions=folds,cursor
"data to store in a session
set sessionoptions=folds,buffers,tabpages,winpos,winsize,resize
"let g:LanguageClient_serverCommands = {
"    \ 'java': ['/usr/local/bin/jdtls', '-data', getcwd()],
"    \ }
set lsp=1
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set incsearch		" do incremental searching
set hidden
set splitbelow splitright
"set tags=./tags;

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
set wildignore+=*/.git/*,*.class
let g:CommandTWildIgnore=&wildignore . ",*/target/*,*.zip,*.jar"
let g:CommandTTraverseSCM='pwd'

"Easy split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set cscopetag cscopetagorder=0

let mapleader = ' '
"Cscope mappings
"edit filename stored in clipboard
nnoremap <leader>ef	:cs find f <C-R>*<CR>
"find text stored in clipboard
nnoremap <leader>ft	:cs find t <C-R>"<CR>
"search for the implementation of the interface under the cursor
nnoremap <leader><C-I> :cs f t implements <cword><CR>
"open the filename the cursor's currently on
nnoremap <leader>g :cs find f <cfile><CR>

"Misc file path utilities
"yank the current filename along with relative path
nnoremap <leader>yf :let @* = expand("%")<cr>
"yank the current file's directory
nnoremap <leader>yd :let @* = expand("%:p:h")<cr>

"Clear search highlighting as well as refresh the screen
nnoremap <silent> <leader><C-L> :nohlsearch <bar> redraw<cr>

