export NAME="Matthias Schmitt"
export EMAIL="male.schmitt@posteo.de"

export LC_CTYPE=en_US.UTF-8
export EDITOR='vim'
export SUDO_EDITOR='vim'
export VISUAL='emacsclient'
# export ALTERNATIVE_EDITOR='vim'
export BROWSER="/usr/bin/firefox"

export MAILDIR="$HOME/.mail"

export PATH=$PATH:$HOME/.local/bin

if command -v rustc &> /dev/null ; then
     export PATH=$PATH:$HOME/.cargo/bin
     export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'

# done in /etc/profile.d/
# export ANDROID_HOME='/opt/android-sdk'
export ANDROID_SDK=$ANDROID_HOME
# export PATH=$PATH:$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

if command -v dart &> /dev/null; then
    export DART_SDK="/opt/dart-sdk"
fi

if command -v node &> /dev/null ; then
    export NVM_DIR="/home/maschm/.nvm"
    export PATH=$PATH:$HOME"/.node_modules/bin"
    export npm_config_prefix=~/.node_modules
fi

if command -v ruby &> /dev/null; then
    export RUBY_GEM_PATH="$(ruby -e 'print Gem.user_dir')/bin"
    if [ -x $RUBY_GEM_PATH ]; then
       export PATH=$PATH:$RUBY_GEM_PATH
    fi
fi

export CHROME_EXECUTABLE=/usr/bin/chromium

# only for wayland
# export MOZ_ENABLE_WAYLAND=1
# export QT_QPA_PLATFORM=wayland
# export QT_QPA_PLATFORMTHEME=qt5ct
# export GDK_BACKEND
