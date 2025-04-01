# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# export TERM="xterm-truecolor"
export COLORTERM="truecolor"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|*-truecolor) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=no
    fi
fi

function timer_now {
    date +%s%N
}

function timer_start {
    timer_start=${timer_start:-$(timer_now)}
}

function timer_stop {
    local delta_us=$((($(timer_now) - $timer_start) / 1000))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # Goal: always show around 3 digits of accuracy
    if ((h > 0)); then timer_show=${h}h${m}m
    elif ((m > 0)); then timer_show=${m}m${s}s
    elif ((s >= 10)); then timer_show=${s}.$((ms / 100))s
    elif ((s > 0)); then timer_show=${s}.$(printf %03d $ms)s
    elif ((ms >= 100)); then timer_show=${ms}ms
    elif ((ms > 0)); then timer_show=${ms}.$((us / 100))ms
    else timer_show=${us}us
    fi
    unset timer_start
}

function setTitle {
    echo -e "\033]0;${PWD}\007" 
}

export MYTITLE='$(echo -n "${PWD}" | awk -F "/" '"'"'{
if (length($0) > 14) { if (NF>4) print ".../" $(NF-1) "/" $NF;
else if (NF>3) print "~/" $NF;
else print ".../" $NF; }
else print $0;}'"'"')'

set_prompt () {
    Last_Command=$? # Must come first!
    Blue='\[\e[01;34m\]'
    White='\[\e[01;37m\]'
    Red='\[\e[01;31m\]'
    Green='\[\e[01;32m\]'
    Kahki='\[\e[01;33m\]'
    Purple='\[\033[01;35m\]'
    Viridity='\[\033[38;5;77m\]'
    CloseColor='\[\e[0m\]'
    Reset='\[\e[00m\]'
    FancyX='\342\234\227'
    Checkmark='\342\234\223'
    SkullBone='\342\230\240'
    LightYellow='\e[38;5;229m'


    #PS1="$Kahki┌─[\d]$White[$Purple\u@$Green\h:$Blue\w$White]$CloseColor\n$Kahki└─>$Viridity\$ $CloseColor"
    # Add a bright white exit status for the last command
    PS1="\n$Kahki┌─ 💪  \D{%m-%d-周%a} "

    # If root, just print the host in red. Otherwise, print the current user
    # and host in green.
    if [[ $EUID == 0 ]]; then
        PS1+="$White[$Red\u@"
    else
        PS1+="$White$SkullBone $Purple\u@"
    fi
    PS1+="$Green\e[01;33mX:$Blue\w$White"

    # If it was successful, print a green check mark. Otherwise, print
    # a red X.
    if [[ $Last_Command == 0 ]]; then
        PS1+="🚀 $Green$Checkmark "
    else
        PS1+="\e[01;33m💩   $Red$FancyX "
    fi

    # Add the ellapsed time and current date
    timer_stop
    PS1+="($timer_show) \t "

    # 最后的\033]0;$("pwd") \a 为设置标题
    # PS1+="$CloseColor\n$Kahki└─>$Viridity\$ $CloseColor \033]0;$("pwd") \a"
    PS1+="$CloseColor \033]0;$(eval "echo ${MYTITLE}")\a\n$Kahki└─>$Viridity\$ $CloseColor"
}


trap 'timer_start' DEBUG
PROMPT_COMMAND='set_prompt'

if [ "$color_prompt" = no ]; then
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    # PS1="┌─[\d][\u@\h:\w]\n└─>"
fi
unset color_prompt force_color_prompt

PS2="\[\e[01;33m\]  ->     \[\e[0m\]"

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    # PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1="\[\e]0; \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto -a --text'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias tionb='sudo tio -b 921600 -d 8 -f none -s 1 -p none  /dev/serial/by-id/usb-Silicon_Labs_CP2102_USB_to_UART_Bridge_Controller_0001-if00-port0'
alias sourcenb='source build/envsetup.sh && export OUT_DIR=out_sys && lunch sys_mssi_auto_64_cn_armv82_car_wifi_vm-userdebug'


alias mgrep='grep --exclude-dir={node_modules,dist,out,generated,build,builddir,.yarn,target} --exclude="tags"'
alias cmake='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=on'
# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias sudo='sudo PATH="$PATH" HOME="$HOME" LD_LIBRARY_PATH="$LD_LIBRARY_PATH"'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias v="vim"
alias g="gvim"
alias c='google-chrome --enable-accelerated-compositing --enable-webgl'
alias f='firefox'
alias cdnb='cd ~/workspace/zhangrui/mt8676/lla/android'

alias pushpower='adb push ~/workspace/zhangrui/mt8676/lla/android/out_sys/target/product/mssi_auto_64_cn_armv82_car_wifi_vm/system/priv-app/PowerControl/PowerControl.apk /system/priv-app/PowerControl/PowerControl.apk'
alias pushserver='adb push  /home/an/workspace/zhangrui/mt8676/lla/android/out_sys/target/product/mssi_auto_64_cn_armv82_car_wifi_vm/system/priv-app/CarServiceUpdatableNonModule/CarServiceUpdatableNonModule.apk   /system/priv-app/CarServiceUpdatableNonModule/CarServiceUpdatableNonModule.apk'
alias pushlib='adb push /home/an/workspace/zhangrui/mt8676/lla/android/out_sys/target/product/mssi_auto_64_cn_armv82_car_wifi_vm/system/framework/*.vdex /system/framework/ && adb push /home/an/workspace/zhangrui/mt8676/lla/android/out_sys/target/product/mssi_auto_64_cn_armv82_car_wifi_vm/system/framework/arm64/* /system/framework/arm64/'
alias pushdisplay='adb push  /home/an/workspace/zhangrui/mt8676/lla/android/out_sys/target/product/mssi_auto_64_cn_armv82_car_wifi_vm/system/priv-app/GwmDisplayManager/GwmDisplayManager.apk  /system/priv-app/GwmDisplayManager/GwmDisplayManager.apk'

export OUT=$HOME/workspace/zhangrui/mt8676/lla/android/out_sys/target/product/mssi_auto_64_cn_armv82_car_wifi_vm/
alias adbr='adb root;adb remount'
alias frameworkc='adb shell "rm -rf /system/framework/arm /system/framework/arm64 /system/framework/oat"'
alias pservices='adbr;frameworkc;adb shell "rm -rf /data/dalvik-cache/arm/system@framework@services.jar@classes.*";adb push $OUT/system/framework/services.jar /system/framework'

alias html2jade='html2jade --donotencode'
alias grepn='grep --exclude-dir=node_modules'
alias cdhu='cd $HOME/workspace/fuxi/pangu/system/LINUX/android'
alias cdsuiren='cd $HOME/workspace/fuxi/suiren/system/LINUX/android'
alias cdvhal='cd $HOME/workspace/fuxi/pangu/system/LINUX/android/hardware/interfaces/automotive/vehicle/2.0/'
alias cdvhalsuiren='cd $HOME/workspace/fuxi/suiren/system/LINUX/android/hardware/interfaces/automotive/vehicle/2.0/'
alias cdhuapp='cd $HOME/workspace/fuxi/pangu/apps/LINUX/android/vendor/fuxi/packages/src/apps'
alias cdhuappsuiren='cd $HOME/workspace/fuxi/suiren/apps/LINUX/android/vendor/fuxi/packages/src/apps'
alias cdhucarsuiren='cd $HOME/workspace/fuxi/suiren/system/LINUX/android/packages/services/Car/'
alias cdrsecar='cd $HOME/data/fuxi-rse-aosp/LINUX/android/packages/services/Car'
alias cddashboard='cd $HOME/workspace/fuxi/pangu/LINUX/android/frameworks/base/services/core/java/com/android/server/dashboard/'
alias rustc='rustc --out-dir out'
alias cddisplay='cd /home/an/workspace/zhangrui/mt8676/lla/android/vendor/gwm/packages/GwmDisplayManager/app/src/main/java/com/gwm/car/display/'
alias cdpower='cd /home/an/workspace/zhangrui/mt8676/lla/android/vendor/gwm/packages/PowerControl/app/src/main/java/com/gwm/car/powercontrol/'
alias cdno='cd $HOME/workspace/zhangrui/mt8676/nobo_android/android/'
alias cdlib='cd /home/an/workspace/zhangrui/mt8676/lla/android/packages/services/Car/car-lib/src/android/car'
alias cdserver='cd /home/an/workspace/zhangrui/mt8676/lla/android/packages/services/Car/service/src/com/android/car'
alias sserver='cdnb && sourcenb && aidegen packages/services/Car/service -s -i s'
alias slib='cdnb && sourcenb && aidegen packages/services/Car/car-lib -s -i s'
alias spower='cdnb && sourcenb && aidegen vendor/gwm/packages/PowerControl/ -s -i s'
alias sdisplay='cdnb && sourcenb && aidegen vendor/gwm/packages/GwmDisplayManager/ -s -i s'




alias cdui='cd $HOME/projhub/react-ssr/'
alias cdpj='cd $HOME/projhub/service-project/'
alias cduser='cd $HOME/projhub/service-user/'

alias lh='lunch msm8996-userdebug'
# alias cp='rsync --info=progress2 '

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

uselocalecn() {
    export LC_ADDRESS="zh_CN.UTF-8"
    export LC_IDENTIFICATION="zh_CN.UTF-8"
    export LC_MEASUREMENT="zh_CN.UTF-8"
    export LC_MONETARY="zh_CN.UTF-8"
    export LC_NAME="zh_CN.UTF-8"
    export LC_NUMERIC="zh_CN.UTF-8"
    export LC_PAPER="zh_CN.UTF-8"
    export LC_TELEPHONE="zh_CN.UTF-8"
    export LC_TIME="zh_CN.UTF-8"
}
uselocalees() {
    export LC_ADDRESS="en_US.UTF-8"
    export LC_IDENTIFICATION="en_US.UTF-8"
    export LC_MEASUREMENT="en_US.UTF-8"
    export LC_MONETARY="en_US.UTF-8"
    export LC_NAME="en_US.UTF-8"
    export LC_NUMERIC="en_US.UTF-8"
    export LC_PAPER="en_US.UTF-8"
    export LC_TELEPHONE="en_US.UTF-8"
    export LC_TIME="en_US.UTF-8"
}

useproxy() {
    export HTTP_PROXY='http://127.0.0.1:9098'
    export HTTPS_PROXY='https://127.0.0.1:9098' 
    export http_proxy='http://127.0.0.1:9098'
    export https_proxy='https://127.0.0.1:9098' 
    export ALL_PROXY='http://127.0.0.1:9098' 
    export all_proxy='https://127.0.0.1:9098' 
}

cp23() {
     sudo update-alternatives --config python
}

unuseproxy() {
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset http_proxy 
    unset https_proxy 
    unset ALL_PROXY
    unset all_proxy
}

detection_cat () 
{
    DET_OUT=$(chardet $1);
    ENC=$(echo $DET_OUT | sed "s|^.*: \(.*\) (confid.*$|\1|");
    iconv -f $ENC $1
}

export GOPATH=$HOME/go
export PATH=$PATH:$HOME/workspace/venv-python/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/home/an/Android/android-studio-2024.2.1.12-linux/android-studio/bin
export GOPROXY=https://goproxy.io,direct
export JAVA_TOOL_OPTIONS="-Duser.language=en"
export JAVA8_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JAVA9_HOME=/usr/lib/jvm/java-9-openjdk-amd64
export JAVA19_HOME=/usr/lib/jvm/java-19-openjdk-amd64
export JAVA21_HOME=/usr/lib/jvm/java-21-openjdk-amd64
export JAVA17_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export JAVA_HOME=$JAVA17_HOME
export JAVA_CONF_DIR=$JAVA_HOME/conf

# export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_STUDIO=$HOME/Android/android-studio-2024.2.1.12-linux/android-studio/
export ANDROID_API_VERSION=34.0.0
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_EMULATOR=$ANDROID_HOME/emulator
export ANDROID_NDK=$ANDROID_HOME/ndk/26.1.10909125
export NDK_HOME=$ANDROID_NDK
export ANDROID_NDK_BIN=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/
export ANDROID_BUILD_TOOL=$ANDROID_HOME/build-tools/$ANDROID_API_VERSION
export ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools/
export ANDROID_TOOLS=$ANDROID_HOME/tools/
export ANDROID_PROGUARD_TOOLS=$ANDROID_TOOLS/proguard/bin
export ANDROID_SDK_ROOT=$ANDROID_HOME

# export LD_LIBRARY_PATH=$ANDROID_TOOLS/emulator/lib64:$LD_LIBRARY_PATH

export PATH=$HOME/.local/bin:$ANDROID_STUDIO/bin:$PATH
export PATH=$PATH:$ANDROID_EMULATOR:$ANDROID_PLATFORM_TOOLS:$ANDROID_TOOLS:$ANDROID_PROGUARD_TOOLS:$ANDROID_BUILD_TOOL:~/workspace/test/shell
export PATH=$ANDROID_NDK:$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:$PATH
# $ANDROID_NDK_BIN:

export DEX_2_JAR=$HOME/workspace/android/decompiler/dex-tools-v2.4/
export JADX_PATH=$HOME/workspace/android/decompiler/jadx/build/jadx/bin
export PATH=$PATH:$DEX_2_JAR:$JADX_PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

export WINE_PATH=/opt/wine-staging/bin
export PATH="$PATH:$WINE_PATH"
export PATH="$PATH:$HOME/bin"

#kafka
export KAFKA=$HOME/workspace/kafka/kafka_2.12-2.4.0

#esp8266
export XCC=$HOME/workspace/esp/esp8266/xtensa-lx106-elf
export PATH=$XCC/bin:$PATH

#esp32
alias idf='. $HOME/workspace/esp/esp32/esp-idf/export.sh'
export IDF_PATH=$HOME/workspace/esp/esp32/esp-idf
export ESP32_XCC=$HOME/workspace/esp/esp32/xtensa-esp32-elf
export PATH=$ESP32_XCC/bin:$IDF_PATH/tools:$PATH


# hozon
alias 74='ssh anlijiu@10.5.7.74'
alias 67='ssh anlijiu@10.5.7.67'

# minicom
alias mcuSer='sudo minicom -D /dev/ttyUSB0 -b 115200'
alias socSer='sudo minicom -D /dev/ttyUSB0 -b 921600'

export RASPBERRY_TOOL_CHAIN=$HOME/workspace/raspberry/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64
export PISYSROOT=/opt/rpi-sysroot
export PATH=$RASPBERRY_TOOL_CHAIN/bin:$PATH

#cscope 
# find /my/project/absolute/dir -name '*.c' -o -name '*.h' > $HOME/cscope_db/rpi_kernel/cscope.files
# cd $HOME/cscope_db/rpi_kernel/
# cscope -bq
CSCOPE_DB=$HOME/cscope_db/rpi_kernel/cscope.out; 
export CSCOPE_DB  

# export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'

source $HOME/.bash_profile

# npm下载puppeteer时不下载Chromium
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1
export PUPPETEER_EXECUTABLE_PATH=$HOME/program/chrome-linux/chrome



export YARN_GLOBAL_PATH=$HOME/.config/yarn/global/node_modules/.bin
export PATH=$PATH:$YARN_GLOBAL_PATH

export DEX2JAR_PATH=$HOME/workspace/android/decompile/dex2jar/bin/dex-tools-2.1-SNAPSHOT
export PATH=$PATH:$DEX2JAR_PATH

export DEPOT_TOOLS=$HOME/workspace/flutter/depot_tools
export FLUTTER_ROOT=$HOME/workspace/flutter/flutter
export PATH=$PATH:$DEPOT_TOOLS

export FASTDDS=$HOME/workspace/dds/Fast-DDS-Gen
export PATH=$PATH:$FASTDDS/scripts

source $HOME/.bash_password


. $HOME/torch/install/bin/torch-activate

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


ZOOKEEPER=$HOME/workspace/zookeeper/apache-zookeeper-3.5.6
PATH=$PATH:$ZOOKEEPER/bin

# dart pub global activate riverpod_cli
# 安装的bin目录
export PATH="$PATH":"$HOME/.pub-cache/bin"
export ZOOKEEPER PATH
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/ssl/lib"

export NDDSHOME=$HOME/rti_connext_dds-6.1.0
source $HOME/workspace/git-subrepo/.rc 
. "$HOME/.cargo/env"

# https://android.googlesource.com/platform/build/+/master/Changes.md#PATH_Tools
# 跳过编译aosp的时候 Disallowed PATH tool xxx  错误
export TEMPORARY_DISABLE_PATH_RESTRICTIONS=true

export PATH=$HOME/bin:$PATH

# pnpm
export PNPM_HOME="/home/an/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# rustup
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
# rustup end

# - webgpu  ~/workspace/doc/wasm/emcc.md  
PATH=$PATH:/home/an/workspace/webgpu/emsdk
PATH=$PATH:/home/an/workspace/webgpu/emsdk/upstream/emscripten
EMSDK=/home/an/workspace/webgpu/emsdk
EMSDK_NODE=/home/an/workspace/webgpu/emsdk/node/20.18.0_64bit/bin/node
