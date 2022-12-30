alias ls='exa --time-style=long-iso --group-directories-first --icons --no-permissions --no-user'
alias l='ls'
alias la='exa --time-style=long-iso --group-directories-first --icons --no-permissions --no-user -al'
alias ll='exa --time-style=long-iso --group-directories-first --icons --no-permissions --no-user -l'
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
alias ggo='git remote show origin'
alias gso='git remote set-url origin'

alias myip='curl ifconfig.me -w "\n"'

alias ut='~/UrbanTerror43/Quake3-UrT.x86_64 +exec autoexec.cfg |& utcolor'

title() {
    printf "\e]2;$*\a"
}

awslog() {
    title $1
    aws logs tail $1 --follow --format short
}
