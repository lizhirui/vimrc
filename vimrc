" Base Configuration
set ai " auto indent
set smarttab " enhanced tab
set tabstop=4
set shiftwidth=4 " indent width
set expandtab " replace tab to space
set nu " line number
set noshowmode " don't show mode because of airline
syntax on " syntax highlight
filetype on " filetype check
filetype plugin on " filetype plugin load
filetype indent on " filetype indent configuration file load
set nofoldenable

" vim-plug Load
call plug#begin('~/.vim/plugged')
" Shorthand notation for plugin
Plug 'scrooloose/nerdtree'
Plug 'kshenoy/vim-signature'
Plug 'vhda/verilog_systemverilog.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/asyncrun.vim'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe'
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
call plug#end()

" External Scripts
source $VIMRUNTIME/macros/matchit.vim

"Disable verilog_systemverilog,c,cpp indent
autocmd filetype verilog_systemverilog,c,cpp setlocal indentexpr=

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

" asyncrun Configuration
let g:asyncrun_open = 6 " height of quickfix window is 6
let g:aynscrun_bell = 1 " alarm after task finish
" F10 open/close quickfix window
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']

" ALE Configuration
let g:ale_sign_column_always = 1
let g:ale_set_highilghts = 0
let g:ale_linters_explicit = 0
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter] %code: %%s'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airilne#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++20'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta

" YCM
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }

" LeaderF
let g:Lf_StlSeparator = {'left': '', 'right': '', 'font': ''}

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" Keymap Settings

" global

" alt remap
let c = 'a'

while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1 + char2nr(c))
endw

set timeout ttimeoutlen=50
 
" disable ex mode
execute ":map Q <Nop>"

" map q to exit
nnoremap <silent> q :q<cr>

nnoremap <silent> <F10> :call asyncrun#quickfix_toggle(6)<cr>
let mapleader="\<Space>" 

nnoremap <silent> <F2> :NERDTreeToggle<cr>
nnoremap <silent> <C-p> :PlugInstall<cr> 
nnoremap <silent> <F12> :so $MYVIMRC<cr> :echo "vimrc reloaded"<cr>
nnoremap <silent> <A-p> :LeaderfFunction<cr>
nnoremap <silent> <C-n> :LeaderfMru<cr>
nnoremap <silent> <A-n> :LeaderfBuffer<cr>

" prevent the indent located in blank line from deleting
inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>
" line Move
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" c/c++
" autocmd filetype c,cpp nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" autocmd filetype c,cpp nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
autocmd filetype c,cpp nnoremap <silent> <F7> :AsyncRun -cwd=<root> -raw make <cr>
autocmd filetype c,cpp nnoremap <silent> <F5> :AsyncRun -cwd=<root> -raw make run <cr>

" verilog/sv
autocmd filetype verilog_systemverilog nnoremap <leader>i :VerilogFollowInstance<CR>
autocmd filetype verilog_systemverilog nnoremap <leader>I :VerilogFollowPort<CR>
autocmd filetype verilog_systemverilog nnoremap <leader>u :VerilogGotoInstanceStart<CR>

" Other Configuration
set foldmethod=syntax
set tags=tags;
set autochdir

" Disable Comment Line Auto Generation
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Disable CIndent
autocmd filetype * setlocal nocindent
