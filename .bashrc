# .bashrc --- bash configuration 
# Set prompt
PS1="\u [\!]:\t:\w\n  >> \[\e[0m\]"

export PYTHON=python3.11
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/go/bin:$HOME/.nimble/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin:$PATH"

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

eval "$(pyenv init --path)"
if command -v rhg>>/dev/null; then alias hg='rhg';fi
. "$HOME/.cargo/env"

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
