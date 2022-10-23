"Vundle

set nocompatible
filetype off

set rtp+=$HOME/.vim/bundle/vundle
call vundle#rc()

" Vundle gère vundle, c'est obligatoire.
Plugin 'vundle'
Plugin 'LustyExplorer'
Plugin 'Solarized'
Plugin 'syntastic'
Plugin 'PyChimp'
Plugin 'salt-vim'
Plugin 'tabman'
Plugin 'ctrlp'
Plugin 'python-mode'
Plugin 'vim-fugitive'
Bundle 'vim-ruby/vim-ruby'
Plugin 'Puppet-Syntax-Highlighting'
Plugin 'commentary.vim'

let g:LustyExplorerSuppressRubyWarning = 1
let g:syntastic_yaml_checkers = ['yamlxs']

set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim
set laststatus=2

syntax on
syntax enable

filetype off
filetype plugin indent on

set background=dark 
colorscheme pychimp
let g:solarized_termcolors=256
let g:solarized_contrast = 'high' 
let g:solarized_visibility= 'high'
set t_Co=256
let g:Powerline_symbols = 'fancy'

set title

set number
set ruler
set wrap

set scrolloff=3

set ignorecase
set smartcase
set incsearch
set hlsearch

set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set modeline

set backspace=indent,eol,start
set autoindent
set copyindent
set smartindent
set expandtab

set encoding=utf-8

set hidden

" deffinition de la touche leader
let mapleader = ","

" mapper un double ;; pour revenir au mode normal 
:imap <S Space> <Esc>
:map <S Space> <Esc>

" Buffer
:map <C-right> :bn<CR>
:map <C-left> :bp<CR>
:map <C-up> :ls<CR>
:map <C-down> :b 

" vertical to horizontal ( | -> -- )
noremap <c-w>-  <c-w>t<c-w>K
" horizontal to vertical ( -- -> | )
noremap <c-w>\|  <c-w>t<c-w>H
noremap <c-w>\  <c-w>t<c-w>H
noremap <c-w>/  <c-w>t<c-w>H

:map <F12> :set nonu!<CR>
:map <F10> :set list!<CR>

" make < > shift keep selection
vnoremap < <gv
vnoremap > >gv

set pastetoggle=<F11>
set showmatch
set showcmd

" Markdown
au BufNewFile,BufRead *.md set spell
au BufNewFile,BufRead *.md setlocal spell spelllang=fr
"Corriger un mot : mettre le curseur sur le mot, puis taper z=
"Définir un mot comme juste : zg
"Définir un mot comme non-juste : zug
"Prochain mot faux : ]s 
au bufNewFile *.md 0r ~/.vim/templates/md

" Python
autocmd BufEnter *.py map <F5> :PymodeRun<CR>
au bufNewFile *.py 0r ~/.vim/templates/python
let g:pymode_rope = 0

" C
autocmd BufEnter *.c map <F5> :!gcc -O2 -Wall -W -std=c99 -pedantic % && ./a.out ; rm a.out
au bufNewFile *.c 0r ~/.vim/templates/c

" C++
autocmd BufEnter *.cpp map <F5> :!g++ % && ./a.out ; rm a.out
au bufNewFile *.cpp 0r ~/.vim/templates/cpp

" HTML
au bufNewFile *.html 0r ~/.vim/templates/html

" bash
au bufNewFile *.sh 0r ~/.vim/templates/sh

" Json

com! FormatJSON %!python -m json.tool
