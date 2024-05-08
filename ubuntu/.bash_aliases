alias ls='exa --time-style=long-iso --group-directories-first --icons --no-permissions --no-user'
alias l='exa'
alias la='exa --time-style=long-iso --group-directories-first --icons --no-permissions --no-user -al'
alias ll='exa --time-style=long-iso --group-directories-first --icons --no-permissions --no-user -l'
alias l.='exa -a | rg "^\."'

alias ..='cd ..'
alias ...='cd ../..'
alias paths='echo $PATH | tr : \\n'

alias cls="clear && printf '\e[3J'"

alias cp='cp -i'
alias less='less -r'
alias more=less


alias rm='rm -i'
alias mv='mv -i'
alias df='df -hT'
alias du='du -h'
alias tmp='pushd $(mktemp -d -p /tmp)'

alias gls='git log --oneline -n 20 && git status -s'
alias ggo='git remote show origin'
alias gso='git remote set-url origin'
alias gd='git diff -- . ":(exclude)*.lock"'
alias lg=lazygit

alias myip='curl ifconfig.me -4 -w "\n"'

alias npm-reset='npm config set registry https://registry.npmjs.org/'

alias vi='nvim'
alias vim='nvim'
alias nv='nvim'

alias m='micro'

alias copy='xsel --clipboard --input'
alias paste='xsel --clipboard --output'

title() {
    printf "\e]2;$*\a"
}

title_cwd() {
    printf "\e]2;${PWD/*\//}\a"
}

awslog() {
    title $1
    aws logs tail $1 --follow --format short
}
