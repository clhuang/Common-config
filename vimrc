set runtimepath+=~/.vim_runtime
if has("gui_running")
    let g:airline_powerline_fonts=1
endif

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

filetype plugin on
set shellslash
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
let g:Tex_MultipleCompileFormats='dvi, pdf'
