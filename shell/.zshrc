# for profiling
# zmodload zsh/zprof


fpath+=~/.zfunc

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Path to your oh-my-zsh installation.
export ZSH=/home/maschm/.zcomet/repos/ohmyzsh/ohmyzsh

# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

AGKOZAK_MULTILINE=0

zcomet load ohmyzsh lib compfix.zsh completion.zsh correction.zsh functions.zsh history.zsh key-bindings.zsh misc.zsh spectrum.zsh termsupport.zsh

zcomet load mafredri/zsh-async async.zsh

zcomet load agkozak/zsh-z

zcomet load 1ambda/zsh-snippets
# zcomet load willghatch/zsh-snippets

zcomet load hlissner/zsh-autopair


# fzf installed by pacman
# zplug "junegunn/fzf", \
#       from:gh-r, \
#       as:command, \
#       rename-to:fzf, \
#       use:"*linux*amd64*"
# zplug "andrewferrier/fzf-z", defer:1

# zplug "plugins/shrink-path", from:oh-my-zsh
# zstyle :prompt:shrink_path fish yes

# It is good to load these popular plugins last, and in this order:
zcomet load zdharma-continuum/fast-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions

zcomet load agkozak/agkozak-zsh-prompt # needs to be after zsh-autosuggestions

# Run compinit and compile its cache
zcomet compinit

autoload -U zmv

setopt dotglob

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

HISTSIZE=10000
SAVEHIST=10000

setopt extendedglob

# if [[ -n $SSH_CONNECTION ]]; then
# else
#   export EDITOR='mvim'
# fi


#export TERM=xterm-256color
export LESS=-r

alias ..='cd ..'
alias ls='ls -v --group-directories-first --color=auto'
alias l='ls -Alh'
alias ll='ls -alh'
alias cp='cp -i'
alias rmf='rm -rf'
alias rm='rm -i'
alias df='df -h'
mkcd () { # md is already an alias
    mkdir $1 && cd $1
}
alias tree='tree -C'
alias split='split -d -a 3'
alias fuck='sudo !!'
alias livestreamer='streamlink'
alias image='nomacs'
alias screensaver='xset s'
alias reloadXresources='xrdb ~/.Xresources'
alias reloadZsh='source ~/.zshrc'
alias redshift_toogle='pkill -USR1 redshift'
alias help='run-help'
alias sudo='sudo ' # allows to use sudo in aliases
alias part='mpv ~/dld/*.part'
alias download='aria2c'

# zsh_snippets add h '| head ' > /dev/null
# zsh_snippets add t '| tail ' > /dev/null
# zsh_snippets add l '| less ' > /dev/null
# zsh_snippets add g '| grep ' > /dev/null
# zsh_snippets add wc '| wc ' > /dev/null
# zsh_snippets add nul '> /dev/null 2>&1' > /dev/null
# zsh_snippets add null '> /dev/null 2>&1' > /dev/null
bindkey '^S' zsh-snippets-widget-expand

alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'
alias -g LE=' 2>&1 | less'
alias -g G='| grep'
alias -g WC='| wc'
alias -g NUL='> /dev/null 2>&1'

# bindkey '^Y' undo
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[3;5~" kill-word
bindkey "^[[3;3~" kill-word

WORDCHARS='*?_-.[]~&;!#$%^(){}<>'


[[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm


case "$TERM" in
"dumb")
    PS1="> "
    ;;
xterm*|rxvt*|eterm*|screen*)
    ;;
*)
    PS1="> "
    ;;
esac


# fzf

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null
[ -f "/usr/share/fzf/key-bindings.zsh" ] && source "/usr/share/fzf/key-bindings.zsh"

export FZF_DEFAULT_OPTS='--height 100% --reverse'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


# for profiling
# zprof
