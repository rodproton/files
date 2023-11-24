# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't add duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Set history length 
HISTSIZE=10000
HISTFILESIZE=20000

# Check window size after each command and update LINES and COLUMNS.
shopt -s checkwinsize

# "**" will match all files and zero or more directories and subdirectories.
shopt -s globstar

# Make less more friendly 
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set a fancy prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Set colored prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
    else
    color_prompt=
    fi
fi

# Display git branch
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[01;34m\]\W\[\033[32m\]\$(git_branch)\[\033[00m\] $ "
else
    PS1="\W \$(git_branch)$ "
fi
unset color_prompt force_color_prompt

# Enable color support of ls 
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Enable programmable completion features 
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#Enable vi-mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

#Keyboard Remap
$HOME/.local/bin/remap-keys

# Golang 
export PATH=$PATH:/usr/local/go/bin
