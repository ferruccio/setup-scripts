eval "$(mcfly init bash)"
eval "$(starship init bash)"
eval "$(fnm env --use-on-cd)"

export MCFLY_RESULTS=25

source ~/bin/starship-completions.sh
source ~/bin/just-completions.sh
source ~/bin/deno-completions.sh
source ~/bin/g3-completions.sh
source ~/bin/g4-completions.sh
source ~/bin/fnm-completions.sh

export G4DB="host=localhost; database=g4dev; user id=postgres; password=postgres"
export G4TEST="host=localhost; database=g4test; user id=postgres; password=postgres"
