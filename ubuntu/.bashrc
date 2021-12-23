
fast ~/.aws/credentials git >/dev/null

eval "$(mcfly init bash)"
eval "$(starship init bash)"

export MCFLY_RESULTS=25

source ~/bin/starship-completions.sh
source ~/bin/just-completions.sh
