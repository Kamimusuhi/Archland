# ~/.bashrc
#set -o vi

random_line=$(shuf -n 1 ~/.local/share/vocab/vocabulary.txt)
word=$(echo "$random_line" | cut -d ':' -f 1)
meaning=$(echo "$random_line" | cut -d ':' -f 2)
sentence=$(echo "$random_line" | cut -d ':' -f 3)
echo -e "$word: $meaning \n $sentence" | cowsay

# Enable bash-completion
export PS1='\n\[\e[36m\] \D{%Y-%m-%d %H:%M:%S} \[\e[39m\] \h \[\e[36m\]in \[\e[32m\]\w\n\[\e[37m\]\[\e[36m\]○ \[\e[32m\]→\[\033[00m\] '
export EDITOR="nvim"
export VISUAL="nvim"

# Aliases
alias in='sudo pacman -S'
alias un='sudo pacman -Rns'
alias uinst='sudo pacman -Rns $(pacman -Qq | fzf)'
alias prun='sudo pacman -Rns $(pacman -Qtdq)'
alias up='paru -Syu --noconfirm --quiet'
alias pmq='pacman -Q | fzf --border=sharp | wl-copy'

alias convert='ffmpeg -i $1 $2 > /dev/null 2>&1'
alias setwal='swaybg -m fill -i'
# alias kys='sudo rm -rf --no-preserve-root /'

alias vi='nvim'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias ll='ls -lah'
alias q='exit'
alias bl='bluetoothctl connect 8C:64:A2:2C:E5:AC'
alias dbl='bluetoothctl disconnect 8C:64:A2:2C:E5:AC'
alias hst='history | fzf --border=sharp | cut -c 8- | wl-copy'

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


