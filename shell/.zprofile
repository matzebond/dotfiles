# start and/or eval ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent | sed '/^echo/d' > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi


export NVM_DIR="/home/maschm/.nvm"

export PATH=$PATH:$HOME"/.node_modules/bin"
export npm_config_prefix=~/.node_modules
