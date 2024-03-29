set icm=split
let g:airline_powerline_fonts=1

let g:multi_cursor_next_key='<C-n>'
runtime basic.vim
runtime filetypes.vim
lua require('plugins')
runtime extended.vim

set termguicolors
set background=dark
colorscheme molokai
highlight Comment cterm=italic gui=italic

filetype plugin on
set shellslash
set grepprg=grep\ -nH\ $*
filetype indent on
set mouse=n

let g:terminal_color_0  = '#626262'
let g:terminal_color_1  = '#ff8373'
let g:terminal_color_2  = '#b4fb73'
let g:terminal_color_3  = '#fffdc3'
let g:terminal_color_4  = '#a5d5fe'
let g:terminal_color_5  = '#ff90fe'
let g:terminal_color_6  = '#d1d1fe'
let g:terminal_color_7  = '#f1f1f1'
let g:terminal_color_8  = '#8f8f8f'
let g:terminal_color_9  = '#ffc4be'
let g:terminal_color_10 = '#d6fcba'
let g:terminal_color_11 = '#fffed5'
let g:terminal_color_12 = '#c2e3ff'
let g:terminal_color_13 = '#ffb2fe'
let g:terminal_color_14 = '#e6e7fe'
let g:terminal_color_15 = '#ffffff'

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
