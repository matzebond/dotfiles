# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

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
export ZSH=/home/maschm/.oh-my-zsh


# Install zplug
if [[ ! -d ~/.zplug ]]; then
  git clone https://github.com/zplug/zplug ~/.zplug
  source ~/.zplug/init.zsh && zplug update --self
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "robbyrussell/oh-my-zsh", use:'lib/*', defer:0

zplug "rupa/z", use:z.sh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug "andrewferrier/fzf-z", defer:1
# zplug "djui/alias-tips"
# zplug "changyuheng/zsh-interactive-cd", defer:1
zplug "plugins/shrink-path", from:oh-my-zsh
zplug "1ambda/zsh-snippets"
# zplug "willghatch/zsh-snippets"

zplug 'dracula/zsh', as:theme
# zplug 'zaari/pieni', as:theme
# zplug 'miekg/lean'

# zplug mafredri/zsh-async, from:github
# zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

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

setopt HIST_IGNORE_ALL_DUPS

HISTSIZE=10000
SAVEHIST=10000


# if [[ -n $SSH_CONNECTION ]]; then
# else
#   export EDITOR='mvim'
# fi


export TERM=xterm-256color
export LESS=-r

alias ls='ls --group-directories-first --color=auto'
alias ll='ls -alh'
alias df='df -h'
alias tree='tree -C'
alias split='split -d -a 3'
alias fuck='sudo !!'
alias livestreamer='streamlink'
alias image='nomacs'
alias screensaver='xset s'
alias reloadXresources='xrdb ~/.Xresources'
alias reloadZsh='source ~/.zshrc'
alias redshift_toogle='pkill -USR1 redshift'
alias help=run-help
alias sudo="sudo " # allows to use sudo in aliases
alias pacman="sudo pacman"
alias part="mpv ~/dld/*.part"

zsh_snippets add h '| head ' > /dev/null
zsh_snippets add t '| tail ' > /dev/null
zsh_snippets add l '| less ' > /dev/null
zsh_snippets add g '| grep ' > /dev/null
zsh_snippets add wc '| wc ' > /dev/null
zsh_snippets add nul '> /dev/null 2>&1' > /dev/null
zsh_snippets add null '> /dev/null 2>&1' > /dev/null
bindkey '^S^S' zsh-snippets-widget-expand

# alias -g H='| head'
# alias -g T='| tail'
# alias -g L='| less'
# alias -g G='| grep'
# alias -g WC='| wc'
# alias -g NUL='> /dev/null 2>&1'

# bindkey '^G' #



[[ -e /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm


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
