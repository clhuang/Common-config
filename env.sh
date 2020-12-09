# source this before "source $ZSH/oh-my-zsh.sh"
source ~/Common-config/private.sh

USING_ZSH=false
if [[ "$SHELL" == *"/zsh" ]]; then USING_ZSH=true; fi
USING_MAC=false 
if [[ "$OSTYPE" == "darwin"* ]]; then USING_MAC=true; fi

if $USING_ZSH; then
    ZSH_THEME="agnoster"
    export KEYTIMEOUT=2
    plugins=(aws git kubectl brew dirhistory git-extras osx pip sudo z vi-mode)
    source $ZSH/oh-my-zsh.sh
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    setopt hist_ignore_space
else
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
    alias ls='ls -GFh'
    HISTSIZE=5000
    HISTFILESIZE=10000
fi

export FZF_TMUX=0
export EDITOR=nvim

if $USING_MAC; then
    if $USING_ZSH; then
        source $HOME/.iterm2_shell_integration.zsh
    else
        source $HOME/.iterm2_shell_integration.bash
    fi
    alias lsb_release='echo'
fi

source ~/Common-config/aliases.sh

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

# Install zsh-async if it’s not present
if [[ ! -a ~/.zsh-async ]]; then
  git clone git@github.com:mafredri/zsh-async.git ~/.zsh-async
fi
source ~/.zsh-async/async.zsh

eval "`fnm env`"


# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS='
'
  local declare files=($(fzf-tmux --query="$1" --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
  unset IFS
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-nvim} "$file"
  fi
}

if $USING_ZSH; then
    # vf - fuzzy open with nvim from anywhere
    # ex: vf word1 word2 ... (even part of a file name)
    # zsh autoload function
    vf() {
      local files

      files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

      if [[ -n $files ]]
      then
         nvim -- $files
         print -l $files[1]
      fi
    }
fi

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$(pwd)}") | fzf-tmux --tac)
  cd "$DIR"
}

if $USING_ZSH; then
    # cf - fuzzy cd from anywhere
    # ex: cf word1 word2 ... (even part of a file name)
    # zsh autoload function
    cf() {
      local file

      file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

      if [[ -n $file ]]
      then
         if [[ -d $file ]]
         then
            cd -- $file
         else
            cd -- ${file:h}
         fi
      fi
    }
fi

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf-tmux +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

# venv configuration
export WORKON_HOME=~/.virtualenvs

_direnv_hook() {
  eval "$(direnv export zsh)";
}
typeset -ag precmd_functions;
if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
  precmd_functions+=_direnv_hook;
fi
