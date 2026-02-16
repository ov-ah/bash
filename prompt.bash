# Gruvbox hard contrast PS1 prompt with git status

__prompt_git() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return
    local flags=""

    git diff --quiet 2>/dev/null || flags+="*"
    git diff --cached --quiet 2>/dev/null || flags+="+"
    [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]] && flags+="?"
    git rev-parse --verify refs/stash &>/dev/null && flags+='$'

    local upstream
    upstream=$(git rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)
    if [[ -n $upstream ]]; then
        local ahead behind
        ahead=$(git rev-list --count '@{upstream}..HEAD' 2>/dev/null)
        behind=$(git rev-list --count 'HEAD..@{upstream}' 2>/dev/null)
        [[ $ahead -gt 0 ]] && flags+="↑${ahead}"
        [[ $behind -gt 0 ]] && flags+="↓${behind}"
    fi

    [[ -n $flags ]] && flags=" ${flags}"
    # \001/\002 are the raw codes behind \[/\] — required inside command substitution
    printf ' \001\e[38;2;254;128;25m\002%s%s\001\e[0m\002' "${branch}" "${flags}"
}

__prompt_cmd() {
    __prompt_exit=$?
}

PROMPT_COMMAND='__prompt_cmd'

__prompt_exit_code() {
    [[ $__prompt_exit -ne 0 ]] && printf ' \001\e[38;2;251;73;52m\002%s\001\e[0m\002' "${__prompt_exit}"
}

PS1='\[\e[38;2;184;187;38m\]\u\[\e[0m\] '      # green user
PS1+='\[\e[38;2;250;189;47m\]\h\[\e[0m\] '      # yellow host
PS1+='\[\e[38;2;131;165;152m\]\w\[\e[0m\]'      # blue directory (full path)
PS1+='$(__prompt_git)'                            # orange git branch+status
PS1+='$(__prompt_exit_code)'                      # red nonzero exit code
PS1+='\n\[\e[38;2;254;128;25m\]\$\[\e[0m\] '    # orange $ on new line
