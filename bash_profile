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

#appendpath $HOME/.local/bin
#appendpath $HOME/bin

[[ -f ~/.bashrc ]] && . ~/.bashrc

DATA=$HOME

APPS=$DATA/Apps
JAVA_HOME=$APPS/jdk-14

[ -d $JAVA_HOME ] && { export JAVA_HOME=$JAVA_HOME; appendpath $JAVA_HOME/bin; }
[ -d $APPS/maven/bin ] && appendpath $APPS/maven/bin
[ -d $APPS/nodejs/bin ] && appendpath $APPS/nodejs/bin
[ -d $APPS/ant/bin ] && appendpath $APPS/ant/bin
[ -d $HOME/.node_modules/bin ] && appendpn $HOME/.node_modules/bin
unset appendpath

export PATH
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace/sublime
#source $HOME/.local/bin/virtualenvwrapper.sh

export EDITOR=vim
