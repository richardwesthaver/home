# .bashrc --- bash configuration 
# Set prompt
PS1="\u [\!]:\t:\w\n  >> \[\e[0m\]"
# default Envs
export LISP='sbcl'
export ESHELL='/usr/bin/bash'
export ORGANIZATION='The Compiler Company'
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export ALTERNATE_EDITOR=''
export EDITOR='emacsclient -a='
# aliases
alias em='emacsclient -a='
alias ec='emacsclient -c -a='
alias et='emacsclient -t -a='
# VCS
alias hgsub='find . -name ".hg" -type d | grep -v "\./\.hg" | xargs -n1 dirname | xargs -iREPO hg -R REPO'
# completion
complete -c man which
