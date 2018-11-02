#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions
PS1='[\u@\h \W]\$ '

# Alias definitions.
alias ls='ls --color=auto'
alias rm='trash-put'

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

if [ -n "$WORKON_HOME" ] && [ -f $HOME/.local/bin/virtualenvwrapper.sh ] ; then
    source $HOME/.local/bin/virtualenvwrapper.sh
fi
