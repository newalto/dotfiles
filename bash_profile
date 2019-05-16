#
# ~/.bash_profile
#

PATH=$HOME/.local/bin:$HOME/bin:$PATH

DATA=/data

APPS=$DATA/Apps
JAVA_HOME=$APPS/jdk
JRE_HOME=$JAVA_HOME/jre
CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH

[ -d $JAVA_HOME ] && { export JAVA_HOME=$JAVA_HOME; PATH=$JAVA_HOME/bin:$PATH; }
[ -d $APPS/maven/bin ] && PATH=$APPS/maven/bin:$PATH
[ -d $APPS/nodejs/bin ] && PATH=$APPS/nodejs/bin:$PATH
[ -d $APPS/ant/bin ] && PATH=$APPS/ant/bin:$PATH
[ -d $HOME/.node_modules/bin ] && PATH=$HOME/.node_modules/bin:$PATH
PATH=$APPS/bin:$PATH

export JAVA_HOME PATH
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$DATA/workspace/sublime
export EDITOR=vim

# set dbus for remote SSH connections
if [ -n "$SSH_CLIENT" -a -n "$DISPLAY" ]; then
  machine_id=$(LANGUAGE=C hostnamectl|grep 'Machine ID:'| sed 's/^.*: //')
  x_display=$(echo $DISPLAY|sed 's/^.*:\([0-9]\+\)\(\.[0-9]\+\)*$/\1/')
  dbus_session_file="$HOME/.dbus/session-bus/${machine_id}-${x_display}"
  if [ -r "$dbus_session_file" ]; then
    export $(grep '^DBUS.*=' "$dbus_session_file")
    # check if PID still running, if not launch dbus
    ps $DBUS_SESSION_BUS_PID | tail -1 | grep dbus-daemon >& /dev/null
    [ "$?" != "0" ] && export $(dbus-launch) >& /dev/null
  else
    export $(dbus-launch) >& /dev/null
  fi
fi

# ~/.config/systemd/user/ssh-agent.service
# Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

[[ -f ~/.bashrc ]] && . ~/.bashrc
