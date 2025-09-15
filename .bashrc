# Exit if not running interactively
[[ $- != *i* ]] && return

# History settings
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Adjust window size after each command
shopt -s checkwinsize

# completion case thing
set completion-ignore-case on

# Make `less` friendly for non-text input
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Set chroot name if applicable
if [[ -z "$debian_chroot" && -r /etc/debian_chroot ]]; then
  debian_chroot=$(</etc/debian_chroot)
fi

# Enable color prompt if possible
if [[ -x /usr/bin/tput && $(tput setaf 1) ]]; then
  color_prompt=yes
else
  color_prompt=
fi

# Define color variables
reset='\[\033[0m\]'
bold_red='\[\033[1;31m\]'
bold_green='\[\033[1;32m\]'
bold_yellow='\[\033[1;33m\]'
bold_blue='\[\033[1;34m\]'
bold_purple='\[\033[1;35m\]'
bold_cyan='\[\033[1;36m\]'

# Git branch parser
parse_git_branch() {
  git branch 2>/dev/null | sed -n '/^\*/s/^\* \(.*\)/ (\1)/p'
}

# Set prompt
set_prompt() {
  local repo_path
  repo_path=$(git rev-parse --show-toplevel 2>/dev/null)

  if [[ -n $repo_path ]]; then
    PS1="${bold_cyan}@\u${reset} ${bold_red}in${reset} ${bold_blue}\w${reset} ${bold_red}on${reset} ${bold_yellow}\$(parse_git_branch)${reset} \n${bold_purple}💜${reset} "
  else
    PS1="${bold_cyan}@\u${reset} ${bold_red}in${reset} ${bold_blue}\w${reset} \n${bold_purple}💜${reset} "
  fi
}

PROMPT_COMMAND=set_prompt

# Set terminal title if xterm-like
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
esac

# Color support for common tools
if [[ -x /usr/bin/dircolors ]]; then
  eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# wayland support
export ELECTRON_OZONE_PLATFORM_HINT=wayland

# Load Bun
export BUN_INSTALL="$HOME/.bun"

export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/waywall:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$PATH:/home/yorunoken/.lmstudio/bin"

# Source aliases
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases

# Activate catnap
catnap
