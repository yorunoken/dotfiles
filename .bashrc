
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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

# colors
reset='\[\033[0m\]'

red='\[\033[31m\]'
green='\[\033[32m\]'
yellow='\[\033[33m\]'
blue='\[\033[34m\]'
purple='\[\033[35m\]'
cyan='\[\033[36m\]'
white='\[\033[37m\]'

bold_red='\[\033[1;31m\]'
bold_green='\[\033[1;32m\]'
bold_yellow='\[\033[1;33m\]'
bold_blue='\[\033[1;34m\]'
bold_purple='\[\033[1;35m\]'
bold_cyan='\[\033[1;36m\]'
bold_white='\[\033[1;37m\]'

italic_bold_red='\[\033[1;3;31m\]'
italic_bold_green='\[\033[1;3;32m\]'
italic_bold_yellow='\[\033[1;3;33m\]'
italic_bold_blue='\[\033[1;3;34m\]'
italic_bold_purple='\[\033[1;3;35m\]'
italic_bold_cyan='\[\033[1;3;36m\]'
italic_bold_white='\[\033[1;3;37m\]'

parse_git_branch() {
    branch_name=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
    echo $branch_name
}

# bash prompt.
set_prompt() {
    repo_path=$(git rev\-parse --show-toplevel 2>/dev/null)

    if [ -z "$repo_path" ]; then
        PS1="${bold_cyan}@\u${reset} ${bold_red}in${reset} ${bold_blue}\w${reset} \n${bold_purple}💜${reset} "
    else
        PS1="${bold_cyan}@\u${reset} ${bold_red}in${reset} ${bold_blue}\w${reset} ${bold_red}on${reset} ${bold_yellow}\$(parse_git_branch)${reset} \n${bold_purple}💜${reset} "
    fi
}


PROMPT_COMMAND=set_prompt

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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
