# main zshrc loop
autoload -Uz colors
zmodload zsh/terminfo
if [[ $#terminfo -eq 0 ]]
then
	TERM=vt100
fi
if [[ $#terminfo -gt 0 && $terminfo[colors] -ge 8 ]]
then
	colors
fi

setopt extended_glob
echo "$fg[green]starting up shell$reset_color\c"
[[ $V == 1 ]] && echo ":\c"
for script in ~/.zsh/rc.*~*~
do
	[[ $V == 1 ]] && echo " $script:e\c" || echo ".\c"
	. $script
	[[ $? -ne 0 ]] && { [[ $V == 1 ]] && echo "\e[$#script:eD$fg[red]$script:e$reset_color\c" || echo "\e[1D$fg[red].$reset_color\c" }
done
[[ $V == 1 ]] && echo "." || echo
unset script

# vi: set ts=4 sw=4:
