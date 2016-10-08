# source this before "source $ZSH/oh-my-zsh.sh"
USING_ZSH=false
if [[ "$SHELL" == *"/zsh" ]]; then USING_ZSH=true; fi
USING_MAC=false 
if [[ "$OSTYPE" == "darwin"* ]]; then USING_MAC=true; fi

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
alias mountafs="sshfs calvinh@athena.dialup.mit.edu:/afs /afs"
alias unmountafs="umount /afs"
alias sshathena="ssh -K -X calvinh@athena.dialup.mit.edu"
alias mosh='mosh --ssh="ssh -o GSSAPITrustDns=no"'
alias nv='nvim'
alias cserv='ssh -X calvinserv.mit.edu -t "tmux -CC attach"'
alias fuck='$(thefuck $(fc -ln -1))'
alias FUCK='fuck'

# server-specific
alias dropboxmit='HOME=/home/calvin dropbox'
alias dropboxpers='HOME=/home/calvin/.dropbox-pers dropbox'

alias ipyserv='nohup jupyter notebook --config=~/.ipython/profile_nbserver/ipython_notebook_config.py > ipynb.log 2>&1 &'

export FZF_TMUX=0

if $USING_MAC; then
    if $USING_ZSH; then
        source $HOME/.iterm2_shell_integration.zsh
    else
        source $HOME/.iterm2_shell_integration.bash
    fi
    alias lsb_release='echo'
fi

if $USING_ZSH; then
    ZSH_THEME="agnoster"
    plugins=(git brew dirhistory git-extras osx pip sudo z)
    source $ZSH/oh-my-zsh.sh
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
    alias ls='ls -GFh'
    HISTSIZE=5000
    HISTFILESIZE=10000
fi


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
# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}
