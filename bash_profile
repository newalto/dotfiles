#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

PATH=$HOME/.local/bin:$HOME/bin:$PATH

DATA=/data

APPS=$DATA/Apps
JAVA_HOME=$APPS/jdk-1.8
JRE_HOME=$JAVA_HOME/jre
CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH

[ -d $JAVA_HOME ] && { export JAVA_HOME=$JAVA_HOME; PATH=$JAVA_HOME/bin:$PATH; }
[ -d $APPS/maven/bin ] && PATH=$APPS/maven/bin:$PATH
[ -d $APPS/nodejs/bin ] && PATH=$APPS/nodejs/bin:$PATH
[ -d $APPS/ant/bin ] && PATH=$APPS/ant/bin:$PATH
[ -d $HOME/.node_modules/bin ] && PATH=$HOME/.node_modules/bin:$PATH

export JAVA_HOME PATH
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$DATA/workspace/sublime
export EDITOR=vim
