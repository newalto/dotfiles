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

if [ -n "$WORKON_HOME" ] && [ -f $HOME/.local/bin/virtualenvwrapper.sh ] ; then
  source $HOME/.local/bin/virtualenvwrapper.sh
fi
