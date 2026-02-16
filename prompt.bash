# Gruvbox hard contrast PS1 prompt
#
# Colors: green user, yellow host, blue directory, orange $

_gruvbox_green='\[\e[38;2;184;187;38m\]'
_gruvbox_yellow='\[\e[38;2;250;189;47m\]'
_gruvbox_blue='\[\e[38;2;131;165;152m\]'
_gruvbox_orange='\[\e[38;2;254;128;25m\]'
_reset='\[\e[0m\]'

PS1="${_gruvbox_green}\u${_reset} ${_gruvbox_yellow}\h${_reset} ${_gruvbox_blue}\W${_reset} ${_gruvbox_orange}\$${_reset} "

unset _gruvbox_green _gruvbox_yellow _gruvbox_blue _gruvbox_orange _reset
