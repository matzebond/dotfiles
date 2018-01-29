export NAME="Matthias Schmitt"
export EMAIL="male.schmitt@posteo.de"

export LC_CTYPE=en_US.UTF-8
export EDITOR='emacsclient'
export VISUAL='emacsclient'
export ALTERNATIVE_EDITOR='vim'
export FZF_DEFAULT_OPTS='--height 100% --reverse' 

export PATH=$PATH:$HOME/.local/bin

export RUST_SRC_PATH='/home/maschm/src/rust/src'
export PATH=$PATH:$RUST_SRC_PATH
export PATH=$PATH:$HOME/.cargo/bin

export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'
# export ANDROID_HOME='/opt/android-sdk'
# export PATH=$PATH:$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

if [ -x "$(command -v ruby)" ]; then
    export RUBY_GEM_PATH="$(ruby -e 'print Gem.user_dir')/bin"
    export PATH=$PATH:$RUBY_GEM_PATH
fi
