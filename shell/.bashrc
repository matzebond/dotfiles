#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

setopt -s autocd
setopt -s dotglob

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
