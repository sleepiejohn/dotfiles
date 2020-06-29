# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/joao/.zshrc'
# End of lines added by compinstall
export PATH="${PATH}:${HOME}/.local/bin/"
export ANDROID_HOME="${HOME}/Android/Sdk"
export ANDROID_SDK_ROOT="${HOME}/Android/Sdk"
export JAVA_HOME="${HOME}/.jdks/azul-1.8.0_252"
export FREETYPE_PROPERTIES="truetype:interpreter-version=38"
# ZPlug
source $HOME/.config/zplug/config
# asdf
. $HOME/.asdf/asdf.sh


# Aliases and Helpers
alias vim=nvim
alias open=xdg-open
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -A --color=auto'
alias c=clear
alias mkdir='mkdir -pv'
# dont fuckup
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -I --preserve-root'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
# Git Aliases
alias gpo=git push origin master
# Sys
## pass options to free ##
alias meminfo='free -m -l -t'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
# temperature
alias temp='sensors | grep "Package id 0"'




# Functions
function sauce {
	source $HOME/.zshrc
}
function wallpaper {
	rm ~/.wallpaper && sudo ln -s $1 ~/.wallpaper
	feh --bg-max ~/.wallpaper
	wal -l -i ~/.wallpaper
}

function i3config {
	vim ~/.config/i3/config
}
function pbconfig {
	vim ~/.config/polybar/config
}
function montemp {
	while true; do
		cmd=$(ps -Ao comm,pcpu --sort=-pcpu | tail -n +2 | head -n 1 | awk '{print $1 "," $2}')
		d=$(date +"%d/%m/%Y %H:%M")
		t=$(sensors | grep "Package id 0" | grep -oE '\s{2}\+([0-9.]*)' | sed 's/\s*+\s*//')
		echo "$d,$t,$cmd"
		sleep 60
	done
}

function logtemp {
	log=$HOME/temp.log
	if [ ! -f "$log" ]; then touch $log; fi
	(montemp >> "$log" &) && \
	echo 'Logging started'
}

function note {
	if [ -z "$1" ]; then
		vim $HOME/.notes
	else
		echo -n $(date +"%d/%m/%Y %H:%M") $1 >> $HOME/.notes
	fi
}
#Nix Pkgs
if [ -e /home/joao/.nix-profile/etc/profile.d/nix.sh ]; then . /home/joao/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit
compinit

