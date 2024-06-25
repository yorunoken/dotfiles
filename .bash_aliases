# git related aliases
alias ga='git add'
alias gp='git push'
alias gc='git commit -m'

# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias c='clear'
alias orphans='[[ -n $(pacman -Qdt) ]] && sudo pacman -Rs $(pacman -Qdtq) || echo "no orphans to remove"'

# connect to hetzner cloud
# alias hetzner='ssh -i [IP HERE]'
