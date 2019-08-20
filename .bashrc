# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

hcolor=33
rcolor=36
mfgrole=""
if [ -f /etc/mfgrole ];then
    mfgrole=" $(cat /etc/mfgrole)"
    if egrep -i 'recette|staging|dev'  /etc/mfgrole > /dev/null;then
        hcolor=32
    fi
    if grep -i prod /etc/mfgrole > /dev/null;then
        hcolor=31
        rcolor=95
    fi
fi
ucolor=39
if [ "$USER" == "root" ];then
    ucolor=31
fi
if egrep -i 'recette|staging|dev'  /etc/hostname > /dev/null;then
    hcolor=32
fi
if grep -i prod /etc/hostname > /dev/null;then
    hcolor=31
    rcolor=95
fi
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;${ucolor}m\]\u\[\033[00m\]@\[\033[01;${hcolor}m\]\h\[\033[01;${rcolor}m\]${mfgrole}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}\e\[${ucolor}m\u@\e\[${hcolor}m\h\e\[00m\e\[${rcolor}m${mfgrole}\e\[0m:\e[94m\w\e[00m\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h${mfgrole}:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# You may uncomment the following lines if you want `ls' to be colorized:

# eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lAh'

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
# very custom #
test -f ${HOME}/.bash_specialfunction.sh && source ${HOME}/.bash_specialfunction.sh
test -f ${HOME}/.bash_customuser && source ${HOME}/.bash_customuser

alias l='ls -alh --color=auto'
alias tmux='tmux -2'
alias g='git'
