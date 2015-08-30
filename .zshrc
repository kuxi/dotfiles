# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git coredata nyan catimg command-not-found autojump gitignore lol sudo)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

alias bp='bin/python'

alias lsports='netstat -tulpn'

alias git='nocorrect git'
alias ack='nocorrect ack-grep'
alias gs='gst'

alias nautilus='nautilus --no-desktop'

#Docker helpers
alias docer="docker" # every goddamn time
alias dockermall="docker ps -a | cut -f1 -d' ' | tail -n +2 | xargs docker rm"

alias clip='xclip -selection clipboard'
alias dup='$COLORTERM'
alias gghist='git fetch && git log $(current_branch)..origin/$(current_branch)'
compdef gghist=git

# Transform the input file - first arg (written with the cProfile module)
# into an image representation, written to the output file - second arg
dotplot () { gprof2dot.py -f pstats $1 | dot -Tpng -o $2 }

function getexcludes () {
    excludes=(lib cache .git .idea share bin logs)
    for i in $(seq 1 $#excludes)
    do
        excludes[$i]="-name ${excludes[$i]}"
    done
    separator=" -o "
    temp=$(printf "$separator%s" "${excludes[@]}")
    temp=${temp:$#separator}
    echo $temp
}

fuse () { find -type d \( $(getexcludes) \) -prune -o -iname "$1" -print | xargs grep -n ${@:2} 2> /dev/null }
anyuse () { find . -type d \( $(getexcludes) \) -prune -o -print | xargs grep -n "$*" 2> /dev/null }

pyfunc () { fuse "*.py" "def $*" }
pyclass () { fuse "*.py" "class $*" }
jsuse () { fuse "*.js" "$*" }
tpluse () { fuse "*.html" "$*" }

alias ackpy='ack --python'

function synckeepass () {
    direction=$1
    mkdir -p /tmp/kee
    if [[ "$direction" = "push" ]]; then
        adb pull /sdcard/keepass/db.kdbx /tmp/kee/android.kdbx
        adb push ~/data/db.kdbx /sdcard/keepass
        echo "Database synced to device, backup at /tmp/kee/android.kdbx"
    else
        if [[ "$direction" = "pull" ]]; then
            cp ~/data/db.kdbx /tmp/kee/comp.kdbx
            adb pull /sdcard/keepass/db.kdbx ~/data
            echo "Database synced to computer, backup at /tmp/kee/comp.kdbx"
        else
            echo "Invalid direction or direction missing (push/pull)"
        fi
    fi
}

# for using ctrl-z to switch back and forth between vim and zsh
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

export TERM=xterm-256color

# Add virtualenvwrapper stuff
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh
