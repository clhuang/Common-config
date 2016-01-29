set runtimepath+=~/.vim_runtime
if has("gui_running")
endif
let g:airline_powerline_fonts=1

let g:multi_cursor_next_key='<C-n>'
source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry


set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

filetype plugin on
set shellslash
set grepprg=grep\ -nH\ $*
filetype indent on
set mouse=a
set rtp+=/usr/local/Cellar/fzf/0.10.2
