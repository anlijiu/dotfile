
# flutter settings
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export FLUTTER_ROOT=$HOME/workspace/flutter/flutter
export DART_SDK=$FLUTTER_ROOT/bin/cache/dart-sdk/
export PATH=$PATH:$FLUTTER_ROOT/bin:$DART_SDK/bin

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

 # rvm use ruby-2.6.0-preview2

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
export NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
nvm use v20.10.0
export NODE_PATH="$HOME/.nvm/versions/node/v20.10.0/lib/node_modules/"
. "$HOME/.cargo/env"
