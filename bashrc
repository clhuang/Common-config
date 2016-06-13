export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
HISTSIZE=5000
HISTFILESIZE=10000

if [[ "$OSTYPE" == "darwin"* ]]; then
    source /Users/calvin/.iterm2_shell_integration.bash
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

source .profile
export $ANS_ROOT=$HOME/ans
source $ANS_ROOT/etc/shrc
