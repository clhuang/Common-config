if exists("b:did_ftplugin")
  finish
endif

au BufRead,BufNewFile *.kv set filetype=kv
setlocal comments=b:#
setlocal commentstring=#%s
