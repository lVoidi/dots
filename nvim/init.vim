" Muestra el numero de linea
set number

" Hace que el mouse se pueda
set expandtab ts=4 sw=4 ai
" utilizar
set mouse=a
" Espaciado entre numeros
set numberwidth=1
" Para poder usar la clipboard en
" vim
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set clipboard=unnamed
" Para tener el marcado de sintaxis
syntax enable
" Esto muestra el comando que esta siendo actualmente
" ejecutado
set showcmd
" Esto muestra la barra de abajo
set ruler
" Hace que el encoding sea de utf-8
set encoding=utf-8
set showmatch
set sw=2
"set relativenumber
set laststatus=2
set noshowmode

" Inicializa los plugins
call plug#begin('~/.vim/plugged')

" Tema de color
Plug 'w0ng/vim-hybrid'
" Para moverse mas rapidamente mediante letras y palabras clave
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'nvim-lua/completion-nvim'
Plug 'davidhalter/jedi-vim'

" Para poder navegar entre archivos abiertos
" usando el teclado
Plug 'christoomey/vim-tmux-navigator'
Plug 'luochen1990/rainbow'
" Termina con los plugins
call plug#end()
let g:rainbow_active = 1


set background=dark
colorscheme hybrid

" La tecla modificadora es el espacio
let mapleader=" "

" Cierra nerdtree al abrir un archivo
" let NERDTreeQuitOnOpen=1

" let g:buffet_powerline_separators = 1
" let g:buffet_tab_icon = "\uf00a"
" let g:buffet_left_trunc_icon = "\uf0a8"
" let g:buffet_right_trunc_icon = "\uf0a9"

" Easy motion
" Este encontrara una palabra usando 2
" Letras clave
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>cl :noh<cr>
" Nerdtree sirve para poder tener varios
" archivos abiertos en el mismo vim
nmap <Leader>nt :NERDTreeFind<CR>

" Shortcut para poder guardar
" los archivos usando la tecla lider,
" la cual en este ejemplo es el espacio,
" mas la w
nmap <Leader>w :w<CR>

" Este hace lo mismo, pero en vez de guardar
" el archivo, lo cierra
nmap <Leader>q :q<CR>


