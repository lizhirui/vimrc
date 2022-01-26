" Base Configuration
set ai " auto indent
set smarttab " enhanced tab
set tabstop=4
set shiftwidth=4 " indent width
set expandtab " replace tab to space
set nu " line number
syntax on " syntax highlight
filetype on " filetype check
filetype plugin on " filetype plugin load
filetype indent on " filetype indent configuration file load

" vim-plug Load
call plug#begin('~/.vim/plugged')
" Shorthand notation for plugin
Plug 'scrooloose/nerdtree'
Plug 'kshenoy/vim-signature'
Plug 'vhda/verilog_systemverilog.vim'
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

" External Scripts
source $VIMRUNTIME/macros/matchit.vim

" gutentags Configuration
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', 'project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" Other Configuration
set foldmethod=syntax
set tags=tags;
set autochdir
let mapleader="\<Space>"
nnoremap <leader>i :VerilogFollowInstance<CR>
nnoremap <leader>I :VerilogFollowPort<CR>
nnoremap <leader>u :VerilogGotoInstanceStart<CR>
nnoremap <F8> :NERDTreeToggle<CR>
" Prevent the indent located in blank line from deleting
inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>
" Line Move
execute ":set <M-j>=\ej"
execute ":set <M-k>=\ek"
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

" Disable Comment Line Auto Generation
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
