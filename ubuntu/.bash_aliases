alias l='exa --across --group-directories-first'
alias ls='exa -a --group-directories-first'
alias la='exa -al --group-directories-first'
alias ll='exa -l --group-directories-first'
alias l.='exa -a | rg "^\."'

alias ..='cd ..'
alias ...='cd ../..'
alias paths='echo $PATH | tr : \\n'

alias cls="clear && printf '\e[3J'"

alias cp='cp -i'
alias more=less

alias rm='rm -i'
alias mv='mv -i'

alias gls='git log --oneline -n 20 && git status -s'

alias myip='curl ifconfig.me -w "\n"'
