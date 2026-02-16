# Gruvbox hard contrast PS1 prompt with git status

__prompt_git() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return
    local status=""
    local flags=""

    # Check for uncommitted changes
    git diff --quiet 2>/dev/null || flags+="*"
    # Check for staged changes
    git diff --cached --quiet 2>/dev/null || flags+="+"
    # Check for untracked files
    [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]] && flags+="?"
    # Check for stashes
    git rev-parse --verify refs/stash &>/dev/null && flags+='$'

    # Ahead/behind upstream
    local upstream
    upstream=$(git rev-parse --abbrev-ref '@{upstream}' 2>/dev/null)
    if [[ -n $upstream ]]; then
        local ahead behind
        ahead=$(git rev-list --count '@{upstream}..HEAD' 2>/dev/null)
        behind=$(git rev-list --count 'HEAD..@{upstream}' 2>/dev/null)
        [[ $ahead -gt 0 ]] && flags+="↑${ahead}"
        [[ $behind -gt 0 ]] && flags+="↓${behind}"
    fi

    [[ -n $flags ]] && status=" ${flags}"
    printf ' \[\e[38;2;254;128;25m\]%s%s\[\e[0m\]' "${branch}" "${status}"
}

__prompt_exit_code() {
    local exit=$?
    [[ $exit -ne 0 ]] && printf ' \[\e[38;2;251;73;52m\]%s\[\e[0m\]' "${exit}"
    return $exit
}

PROMPT_COMMAND='__prompt_last_exit=$?'

PS1='\[\e[38;2;184;187;38m\]\u\[\e[0m\] '      # green user
PS1+='\[\e[38;2;250;189;47m\]\h\[\e[0m\] '      # yellow host
PS1+='\[\e[38;2;131;165;152m\]\w\[\e[0m\]'      # blue directory (full path)
PS1+='$(__prompt_git)'                            # orange git branch+status
PS1+='$(__prompt_exit_code)'                      # red nonzero exit code
PS1+='\n\[\e[38;2;254;128;25m\]\$\[\e[0m\] '    # orange $ on new line
