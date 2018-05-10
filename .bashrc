# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
    xterm-color|*-256color) color_prompt=yes;;
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
    PS1="\n$Kahki┌─ 💪  \D{%Y-%m-%d %a} "

    # If root, just print the host in red. Otherwise, print the current user
    # and host in green.
    if [[ $EUID == 0 ]]; then
        PS1+="$White[$Red\u@"
    else
        PS1+="$White$SkullBone $Purple\u@"
    fi
    PS1+="$Green\h:$Blue\w$White"

    # If it was successful, print a green check mark. Otherwise, print
    # a red X.
    if [[ $Last_Command == 0 ]]; then
        PS1+="🛪   $Green$Checkmark "
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias v="vim"
alias c='google-chrome  --enable-accelerated-compositing --enable-webgl'
alias f='firefox'
alias cdmw='cd ~/workspace/letv/vendor/letv/apps/LetvCarObd'
alias html2jade='html2jade --donotencode'
alias grepn='grep --exclude-dir=node_modules'

alias lh='lunch msm8996-userdebug'

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
export JAVA8_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export JAVA9_HOME=/usr/lib/jvm/java-9-openjdk-amd64/
export JAVA_HOME=$JAVA8_HOME
export JAVA_CONF_DIR=$JAVA_HOME/conf

# export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_HOME=$HOME/Android/M01Sdk/android-sdk_eng.anlijiu_linux-x86
export ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools/
export ANDROID_TOOLS=$ANDROID_HOME/tools/
export ANDROID_PROGUARD_TOOLS=$ANDROID_TOOLS/proguard/bin

# export LD_LIBRARY_PATH=$ANDROID_TOOLS/emulator/lib64:$LD_LIBRARY_PATH

export PATH=$PATH:$ANDROID_PLATFORM_TOOLS:$ANDROID_TOOLS:$ANDROID_PROGUARD_TOOLS:~/workspace/test/shell

export DEX_2_JAR=$HOME/workspace/android/decompile/dex2jar-2.1-SNAPSHOT
export PATH=$PATH:$DEX_2_JAR

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export FLUTTER_ROOT=$HOME/workspace/flutter/flutter
export PATH=$PATH:$FLUTTER_ROOT/bin

export WINE_PATH=/opt/wine-staging/bin
export PATH="$PATH:$WINE_PATH"
export PATH="$PATH:$HOME/bin"

#esp8266
export XCC=/home/anlijiu/workspace/esp/esp8266/esp-open-sdk/xtensa-lx106-elf
export PATH=$XCC/bin:$PATH

#esp32
export IDF_PATH=/home/anlijiu/workspace/esp/esp32/esp-idf
export ESP32_XCC=/home/anlijiu/workspace/esp/esp32/xtensa-esp32-elf
export PATH=$ESP32_XCC/bin:$PATH

export RASPBERRY_TOOL_CHAIN=/home/anlijiu/workspace/raspberry/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64
export PISYSROOT=/opt/rpi-sysroot
export PATH=$RASPBERRY_TOOL_CHAIN/bin:$PATH

#cscope 
# find /my/project/absolute/dir -name '*.c' -o -name '*.h' > $HOME/cscope_db/rpi_kernel/cscope.files
# cd $HOME/cscope_db/rpi_kernel/
# cscope -bq
CSCOPE_DB=$HOME/cscope_db/rpi_kernel/cscope.out; 
export CSCOPE_DB  

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
nvm use v8.7.0
