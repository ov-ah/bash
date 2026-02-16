#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- ble.sh (fish-like autosuggestions & syntax highlighting) ---
[[ $BLE_VERSION ]] || source /usr/share/blesh/ble.sh --noattach 2>/dev/null

alias ls='ls --color=auto'
alias grep='grep --color=auto'
source ~/.config/bash/prompt.bash
export PATH="$HOME/.local/bin:$PATH"

# --- Directory navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ll='ls -lAh --color=auto'
alias la='ls -A --color=auto'
alias lt='ls -lAht --color=auto'  # sort by modified time

# --- Git aliases ---
alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gsw='git switch'
alias gb='git branch'
alias gd='git diff'
alias gds='git diff --staged'
alias gp='git push'
alias gpl='git pull --rebase'
alias gf='git fetch --all --prune'
alias gst='git stash'
alias gstp='git stash pop'
alias gl='git log --graph --pretty=format:"%C(yellow)%h%Creset -%C(auto)%d%Creset %s %C(dim)(%cr) %C(cyan)<%an>%Creset" --abbrev-commit'
alias gla='gl --all'
alias gls='git log --oneline -20'
alias gbl='git blame -s'

# --- Utility ---
alias mkdir='mkdir -pv'
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ports='ss -tulnp'
alias myip='curl -s ifconfig.me'
alias path='echo $PATH | tr ":" "\n"'
alias reload='source ~/.bashrc'

# --- Search helpers ---
alias ff='find . -type f -name'
alias fd='find . -type d -name'

# --- Extract anything ---
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1"   ;;
            *.tar.gz)  tar xzf "$1"   ;;
            *.tar.xz)  tar xJf "$1"   ;;
            *.bz2)     bunzip2 "$1"   ;;
            *.gz)       gunzip "$1"    ;;
            *.tar)     tar xf "$1"    ;;
            *.tbz2)    tar xjf "$1"   ;;
            *.tgz)     tar xzf "$1"   ;;
            *.zip)     unzip "$1"     ;;
            *.7z)      7z x "$1"      ;;
            *.zst)     unzstd "$1"    ;;
            *)         echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# --- Quick directory bookmarks ---
mkd() { mkdir -p "$1" && cd "$1"; }

# --- Better history ---
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# --- Shell options ---
shopt -s autocd        # cd into directories by just typing the name
shopt -s cdspell       # autocorrect minor typos in cd
shopt -s dirspell      # autocorrect directory names during completion
shopt -s globstar      # ** matches recursively
shopt -s checkwinsize  # update LINES/COLUMNS after each command
shopt -s no_empty_cmd_completion  # don't complete on empty line

# --- Bash completion ---
if [ -r /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

# --- Attach ble.sh (must be last) ---
[[ ${BLE_VERSION-} ]] && ble-attach
