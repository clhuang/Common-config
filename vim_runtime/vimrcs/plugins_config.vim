""""""""""""""""""""""""""""""
" => vim-plug
""""""""""""""""""""""""""""""
call plug#begin('~/.vim_runtime/plugged')

Plug 'fatih/vim-go'
Plug 'mileszs/ack.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'eagletmt/ghcmod-vim'
Plug 'davidhalter/jedi-vim'
Plug 'tomasr/molokai'
Plug 'yegappan/mru'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'python-mode/python-mode', {'branch': 'develop'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'kchmck/vim-coffee-script'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/vim-jsx-improve'
Plug 'lervag/vimtex'
Plug 'shougo/vimproc.vim'
Plug 'justinmk/vim-sneak'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'embear/vim-localvimrc'

call plug#end()

""""""""""""""""""""""""""""""
" => fzf plugin
""""""""""""""""""""""""""""""
nmap ; :Buffers<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nmap <Leader>a :Rg<CR>
nmap <Leader>t :GFiles<CR>
nmap <Leader>tt :Files<CR>

""""""""""""""""""""""""""""""
" => ack plugin
""""""""""""""""""""""""""""""
let g:ackprg = 'rg --vimgrep --no-heading'

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => YankRing
""""""""""""""""""""""""""""""
if has("win16") || has("win32")
    " Don't do anything
else
    let g:yankring_history_dir = '~/.vim_runtime/temp_dirs/'
endif


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
map <c-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'


""""""""""""""""""""""""""""""
" => Peepopen
""""""""""""""""""""""""""""""
map <leader>j :PeepOpen<cr>



""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'


""""""""""""""""""""""""""""""
" => snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=grep\ -nH\ $*


""""""""""""""""""""""""""""""
" => Vimtex
""""""""""""""""""""""""""""""
let g:tex_flavor='latex'
let g:Tex_MultipleCompileFormats='dvi, pdf'
let g:vimtex_latexmk_options="-xelatex -shell-escape -pdf"


""""""""""""""""""""""""""""""
" => slimv
""""""""""""""""""""""""""""""
let g:slimv_preferred = 'mit'
let g:slimv_disable_lisp=1
let g:scheme_builtin_swank=1


""""""""""""""""""""""""""""""
" => jedi
""""""""""""""""""""""""""""""
let g:jedi#force_py_version = 3


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_next_key="\<C-s>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ghcmod-vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePost *.hs GhcModCheckAndLintAsync
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0
let g:jedi#force_py_version = 3

let g:localvimrc_persistent = 1

" Syntastic setup
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

"let g:syntastic_error_symbol = '❌'
"let g:syntastic_style_error_symbol = '⁉️'
"let g:syntastic_warning_symbol = '⚠️'
"let g:syntastic_style_warning_symbol = '💩'

"highlight link SyntasticErrorSign SignColumn
"highlight link SyntasticWarningSign SignColumn
"highlight link SyntasticStyleErrorSign SignColumn
"highlight link SyntasticStyleWarningSign SignColumn
