#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

setopt -s autocd
setopt -s dotglob

eval $(dircolors -b ~/.dircolors)

export LESS=-R

export HISTCONTROL=ignoredups:erasedups
# shopt -s histappend # does not work well with erasedups see https://unix.stackexchange.com/questions/18212

source ~/.aliases

PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
