# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

alias gitaa="git add -A"
alias gitap="git add -p"
alias gitc="git commit -m"
alias gits="git status"
alias gitsubr="git submodule update --init --recursive"
alias bl="black --line-length=120 ."
alias weather="curl wttr.in/"

alias tmuxa="tmux attach -dt 0"

alias lessnm="less"
alias less="less --mouse"

alias cpresearch="cd /hgm/research_scratch/cpiller/"
alias gm1="cd ~/gm.dev/platform/"
alias gm2="cd ~/gm.dev2/platform/"

function pretty_csv {
  echo "$@"; column -t -s, -n "$@" | less -F -S -X -K; echo
}

function ssh-copy-id-if-needed()
{
    host=$1
    ssh -o PasswordAuthentication=no $host exit &>/dev/null
    if [[ $? -ne 0 ]]; then
        ssh-copy-id $host
    fi
}

export PATH="$HOME/.poetry/bin:$PATH"

export PATH="$HOME/bin:$PATH"

