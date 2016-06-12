export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
alias mountafs="sshfs calvinh@athena.dialup.mit.edu:/afs /afs"
alias unmountafs="umount /afs"
alias sshathena="ssh -o GSSAPIKeyExchange=no -X calvinh@athena.dialup.mit.edu"
alias mosh='mosh --ssh="ssh -o GSSAPITrustDns=no"'
alias nv='nvim'
alias cserv='ssh -X calvinserv.mit.edu'
PATH="/Users/calvin/.cabal/bin:/usr/local/bin:/usr/local/share/python:$PATH"
alias fuck='$(thefuck $(fc -ln -1))'
alias FUCK='fuck'

export FZF_TMUX=0
