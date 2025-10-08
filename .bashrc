# ~/.bashrc

#When shell is interactive will be executed
case $- in 
	*i*) ;;
	*) return;;
esac

#Historic format

HISTTIMEFORMAT="%F %T " #Date and time format 
HISTCONTROL=ignoreboth #Ignore duplicate
shopt -s histappend 
HISTSIZE=1000 
HISTFILESIZE=2000

#update automaticaly the size of the terminal
shopt -s checkwinsize

#less is better with not-text files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#chroot info
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

###GIT

# Detected a git branch
parse_git_branch() {
	git branch 2>/dev/null | sed -n '/\* /s///p' | sed 's/^/(git: /;s/$/)/'
}

###Personalization

#Colors

#PS1='\[\e[1;35m\]\u \[\e[0m\]| [date: \D{%d.%m.%Y %H:%M:%S}] | [path: \w] \[\e[0;33m\]$(parse_git_branch)\[\e[0m\]\n\$'

PS1='\[\e[01;35m\]┌─[\[\e[01;92m\u\e[01;35m\]] | [date: \D{%d.%m.%Y %H:%M:%S}] | [path: \w\[\033[1;35m\]] \[\e[0;35m\]$(parse_git_branch)\]-\[\e[01;35m\]$\[\e[01;35m\]\n\[\e[01;35m\]└──\[\e[01;92m\]>>\[\e[0m\]'

#Tittle 

case "$TERM" in
	xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]$PS1"
	;;
esac

#Commands colors

if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias ll='ls -alF --color=auto'
	alias la='ls -A'
	alias l='ls -CF'
	alias update='sudo apt update && sudo apt upgrade -y'
	alias cls='clear'
fi

#Alert Visual after long commands
alias alert='notify-send --urgency=low -i "$( [ $? = 0 ] && echo terminal || echo error )" "$(history | tail -n1 | sed -E "s/^[ ]*[0-9]+[ ]+//;s/[;&|]*\s*alert$//")"'

#Load customizate aliases

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi 

### Autocomplete

if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_comletion ]; then
	. /etc/bash_completion
	fi
fi

###Powerline initialization

if [ -f ~/.venvs/powerline/bin/poweline-daemon  ]; then
	~/.venvs/powerline/bin/poweline-daemon -q
	POWELINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	source ~/.venvs/poweline/lib/python*/site-packages/poweline/bindings/bash/poweline.sh
fi

export PS1="$PS1"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#Environment variables
export EDITOR='vim'
export PATH=$PATH:/usr/local/bin


