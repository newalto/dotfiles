#
# ~/.bash_profile
#

# Append our default paths
appendpath () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

appendpath $HOME/.local/bin
#appendpath $HOME/bin

[ -d /data ] && DATA=/data || DATA=$HOME
APPS=$DATA/Apps
JAVA_HOME=$APPS/jdk

[ -d $JAVA_HOME ] && { export JAVA_HOME=$JAVA_HOME; appendpath $JAVA_HOME/bin; }
[ -d $APPS/maven/bin ] && appendpath $APPS/maven/bin
[ -d $APPS/nodejs/bin ] && appendpath $APPS/nodejs/bin
[ -d $APPS/ant/bin ] && appendpath $APPS/ant/bin
[ -d $HOME/.node_modules/bin ] && appendpath $HOME/.node_modules/bin

export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
appendpath $GEM_HOME

unset appendpath

export PATH
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace/sublime
#source $HOME/.local/bin/virtualenvwrapper.sh

export EDITOR=vim
export HISTTIMEFORMAT='%d/%m/%y %T '

# Begin protected block
if [ -t 0 ]; then       # check for a terminal
  [ x"$TERM" = x"wy30" ] && stty erase ^h       # sample legacy environment
  echo "Welcome to Debian, $LOGNAME"
  #/usr/games/fortune
fi
# End protected block

[[ -f ~/.bashrc ]] && . ~/.bashrc
