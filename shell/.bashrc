#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

setopt -s autocd
setopt -s dotglob
complete -o filenames

#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

eval $(dircolors -b ~/.dircolors)

export HISTCONTROL=ignoredups:erasedups
# shopt -s histappend # does not work well with erasedups see https://unix.stackexchange.com/questions/18212

export LESS=-R

source ~/.aliases

PS1='[\u@\h \W]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
