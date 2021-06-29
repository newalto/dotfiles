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

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

if [ "$WINDOWID" != "" ]; then
  [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
fi
