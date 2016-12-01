HISTCONTROL=ignoreboth
HISTSIZE=-1
HISTFILESIZE=-1
shopt -s histappend
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Color for less http://www.tuxarena.com/2012/04/tutorial-colored-man-pages-how-it-works/
export LESS_TERMCAP_mb=$(printf '\e[01;31m') # enter blinking mode - red
export LESS_TERMCAP_md=$(printf '\e[01;35m') # enter double-bright mode - bold, magenta
export LESS_TERMCAP_me=$(printf '\e[0m') # turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_se=$(printf '\e[0m') # leave standout mode    
export LESS_TERMCAP_so=$(printf '\e[01;33m') # enter standout mode - yellow
export LESS_TERMCAP_ue=$(printf '\e[0m') # leave underline mode
export LESS_TERMCAP_us=$(printf '\e[04;36m') # enter underline mode - cyan

if [ `id -u` -eq 0 ]; then 
    PS1="\[\033[01;31m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]# "
else
    PS1="\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]$ "
    ssh-add -l > /dev/null || ( echo "Unlock the god damn key!" && ssh-add )
fi
PROMPT_COMMAND='echo -ne "\033]0;${?}:${PWD}\007"'

export EDITOR=vim

alias up='sudo apt update && sudo apt dist-upgrade && sudo apt autoremove --purge'

alias vim='vim -p'
alias ls='ls --almost-all --color=auto --group-directories-first --indicator-style=slash --show-control-chars'
alias ll='ls --format=long --human-readable'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias gpg="gpg --keyserver keyserver.ubuntu.com"

alias ydisk='sudo mount.davfs https://webdav.yandex.ru /home/mike/yandexdisk -o uid=mike,gid=mike'

#alias work='xrandr --output eDP1 --auto --output VGA1 --auto --left-of eDP1'
#alias home='xrandr --output VGA1 --off --output eDP1 --auto'

rollback() {
    sudo apt purge `tail -2 /var/log/apt/history.log | head -1 | tr ' ' '\n' | egrep -v '(\(|\)|Install:)' | tr '\n' ' '`
}

s() {
    echo -ne "\033]0;${1}\007"
    ssh -o ConnectTimeout=5 ${1} ${2}
    echo -ne "\033]0;[${1}]\007"
}

_s() {
    COMPREPLY=()
    local cur=${COMP_WORDS[COMP_CWORD]}
    comp_ssh_hosts=`grep '^Host ' .ssh/config | cut -d ' ' -f 2`
    COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur) )
    return 0
}
complete -F _s s
