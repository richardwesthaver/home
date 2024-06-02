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
# sudo pacman -Sy seahorse libgnome-keyring libsecret
#export SSH_ASKPASS=/usr/lib/seahorse/ssh-askpass
# git config --global credential.helper /usr/lib/git-core/git-credential-libsecret
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

# aliases
eman() {
    emacsclient -t -e "(man \"$1\")" -a=
}

eww() {
 emacsclient -t -e '(eww-browse-url "'"$1"'")' -a=
}
alias em='emacsclient -a='
alias ec='emacsclient -c -a='
alias et='emacsclient -t -a='
alias skm='skel make'
alias hmi='homer install'
alias lisp='rlwrap sbcl'
alias hgpu='hg pull -u'
alias hgc='hg ci -m'
alias hgp='hg push'

# VCS
alias hgsub='find . -name ".hg" -type d | grep -v "\./\.hg" | xargs -n1 dirname | xargs -iREPO hg -R REPO'

alias q='QHOME=~/q rlwrap -r ~/q/l64/q'
alias ..='cd ..'

complete -c man which
