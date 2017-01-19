# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
source ~/.private_profile

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
    xterm-color) color_prompt=yes;;
esac

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
    PS1="$Kahki┌─ 💪  \D{%Y-%m-%d %a} "

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
    PS1+="$CloseColor\n$Kahki└─>$Viridity\$ $CloseColor \033]0;$("pwd") \a"
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

# alias grep='grep --exclude-dir=build --color=auto'

#新建terminal tab 页时工作目录延用上一个
# . /etc/profile.d/vte.sh

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias g='gvim'
alias vi='vim'
alias v='vim'
alias c='google-chrome  --enable-accelerated-compositing --enable-webgl'
alias f='firefox'
alias cdmw='cd ~/workspace/letv/vendor/letv/apps/LetvCarObd'
alias html2jade='html2jade --donotencode'
alias grepn='grep --exclude-dir=node_modules'

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

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib64

export QT_BIN=/usr/lib64/qt4/bin
export GOPATH=~/go
export JAVA6_HOME=/opt/jdk1.6.0_45
export JAVA7_HOME=/opt/jdk1.7.0_71
# export JAVA8_HOME=/opt/jdk1.8.0_92
export JAVA8_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
# export RUBYMINE_JDK=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.65-3.b17.fc22.x86_64
export CL_JDK=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.65-3.b17.fc22.x86_64
# export RUBYMINE_JDK=$JAVA8_HOME
# export RUBYMINE_JDK=$JAVA7_HOME
export OPEN_JDK_HOME=/usr/lib/jvm/java-7-openjdk-amd64
# export JAVA_HOME=$OPEN_JDK_HOME
export JAVA_HOME=$JAVA8_HOME
# export JAVACMD=$JAVA6_HOME/bin/java
# export PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin
export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

export DEX2JAR_HOME=/home/anlijiu/workspace/android反编译/dex2jar/dex2jar-0.0.9.15/
export JDGUI_HOME=/home/anlijiu/workspace/android反编译/jd-gui-0.3.5/
export ECLIPSE_HOME=/opt/eclipse
export M2_HOME=/opt/maven/apache-maven-3.1.1
export PATH=$PATH:$M2_HOME/bin:$QT_BIN
#optional  
export MAVEN_OPTS="-Xms256m -Xmx512m"  
 
# export STUDIO_JDK=$OPEN_JDK_HOME
export STUDIO_JDK=$JAVA8_HOME
export ANDROID_HOME=/opt/sdk/
export NDK_HOME=/opt/android-ndk-r10c/
export ANDROID_NDK_HOME=$NDK_HOME
PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$NDK_HOME:$DEX2JAR_HOME:$JDGUI_HOME

PATH=~/bin:/opt/wine-devel/bin/:$PATH

export CLASSPATH=$CLASSPATH:$ANDROID_HOME/tools:$ANDROID_HOME/platforms/android-25/android.jar

export GIT_SSH_COMMAND='ssh -o KexAlgorithms=+diffie-hellman-group1-sha1'

# set_gnome_terminal_transparent.sh 85

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/dist
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
export NVM_IOJS_ORG_MIRROR=http://npm.taobao.org/mirrors/iojs

NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export PATH=$PATH:$NPM_PACKAGES/bin
# PS1="\[\e[0;1m\]┌─( \[\e[31;1m\]\u\[\e[0;1m\] ) – ( \[\e[36;1m\]\w\[\e[0;1m\] )\n└──┤ \[\e[0m\]"
# PS1="┌─[\d][\u@\h:\w]\n└─>"
nvm use v7.4.0
rvm use 2.3.1
