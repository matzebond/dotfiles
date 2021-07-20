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
export ZSH=/home/maschm/.zplug/repos/robbyrussell/oh-my-zsh


# Install zplug
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "robbyrussell/oh-my-zsh", use:'lib/*', ignore:'*theme*'

zplug "mafredri/zsh-async", from:github

zplug "rupa/z", use:z.sh
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-autosuggestions"

zplug "junegunn/fzf-bin", \
      from:gh-r, \
      as:command, \
      rename-to:fzf, \
      use:"*linux*amd64*"
zplug "andrewferrier/fzf-z", defer:1

# zplug "djui/alias-tips"
# zplug "changyuheng/zsh-interactive-cd", defer:1
zplug "plugins/shrink-path", from:oh-my-zsh
zplug "1ambda/zsh-snippets"
# zplug "willghatch/zsh-snippets"

zplug "hlissner/zsh-autopair", defer:2
# zplug 'dracula/zsh', as:theme
# zstyle :prompt:shrink_path fish yes
# zplug 'zaari/pieni', as:theme
# zplug 'miekg/lean'
# zplug "nojhan/liquidprompt"
# zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

AGKOZAK_MULTILINE=0
zplug "agkozak/agkozak-zsh-theme", defer:1


# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

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

zsh_snippets add h '| head ' > /dev/null
zsh_snippets add t '| tail ' > /dev/null
zsh_snippets add l '| less ' > /dev/null
zsh_snippets add g '| grep ' > /dev/null
zsh_snippets add wc '| wc ' > /dev/null
zsh_snippets add nul '> /dev/null 2>&1' > /dev/null
zsh_snippets add null '> /dev/null 2>&1' > /dev/null
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
