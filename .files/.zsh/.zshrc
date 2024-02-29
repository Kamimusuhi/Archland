# Created by newuser for 5.9

eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
atuin import auto
export EDITOR="nvim"
export VISUAL="nvim"
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Aliases
alias in='paru -S'
alias un='sudo pacman -Rns'
alias uinst='sudo pacman -Rns $(pacman -Qq | fzf)'
alias prun='sudo pacman -Rns $(pacman -Qtdq)'
alias up='paru -Syu --noconfirm --quiet'
alias pmq='pacman -Q | fzf --border=sharp | wl-copy'

alias convert='ffmpeg -i $1 $2 > /dev/null 2>&1'
alias wal='swaybg -m fill -i'
# alias kys='sudo rm -rf --no-preserve-root /'

alias v='nvim'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias ls='ls --color=auto'
alias l.='ls -d .* --color=auto'
alias ll='ls -lah'
alias q='exit'
alias cat='bat'
alias bl='bluetoothctl connect 8C:64:A2:2C:E5:AC'
alias dbl='bluetoothctl disconnect 8C:64:A2:2C:E5:AC'

alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias ff="find -type d | fzf --multi --border=sharp \
--preview='tree -C {}' --preview-window='40%,border-sharp' \
--prompt='Dirs > ' \
--bind='enter:execute($EDITOR {+})' \
--bind='del:execute(rm -ri {+})' \
--bind='ctrl-p:toggle-preview' \
--bind='ctrl-d:change-prompt(Dirs > )' \
--bind='ctrl-d:+reload(find -type d)' \
--bind='ctrl-d:+change-preview(tree -C {})' \
--bind='ctrl-d:+refresh-preview' \
--bind='ctrl-f:change-prompt(Files > )' \
--bind='ctrl-f:+reload(find -type f)' \
--bind='ctrl-f:+change-preview(cat {})' \
--bind='ctrl-f:+refresh-preview' \
--bind='ctrl-a:select-all' \
--bind='ctrl-x:deselect-all' \
--header '
CTRL-D to display directories | CTRL-F to display files
CTRL-A to select all | CTRL-x to deselect all
ENTER to edit | DEL to delete
CTRL-P to toggle preview
'"

function stopwatch(){
  date1=`date +%s`; 
   while true; do 
    echo -ne "\e[1m\e[91m"$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)"\e[0m\r"; 
    sleep 0.1
   done
}

function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

fg(){
  file=$(grep --line-buffered --color=auto -nrFI "$1" * | fzf -e --multi --border=sharp \
--preview='grep --color=always -nrF "$1" {} | fzf --ansi --preview "bat --style=numbers --color=always --line-range :500 {}"' \
--preview-window='40%,border-sharp' | cut -d: -f1 --output-delimiter=' ') && nvim ${file}
}

##random_line=$(shuf -n 1 ~/.local/share/vocab/vocabulary.txt)
##word=$(echo "$random_line" | cut -d ':' -f 1)
##meaning=$(echo "$random_line" | cut -d ':' -f 2)
##sentence=$(echo "$random_line" | cut -d ':' -f 3)
##echo -e "$word: $meaning \n $sentence" | cowsay

clear
