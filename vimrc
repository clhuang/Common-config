set runtimepath+=~/.vim_runtime
if has("gui_running")
    let g:airline_powerline_fonts=1
endif

let g:multi_cursor_next_key='<C-n>'
source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

nnoremap <C-j> <C-w>j
vnoremap <C-j> <C-w>j

set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

filetype plugin on
set shellslash
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
let g:Tex_MultipleCompileFormats='dvi, pdf'
