
if test `find ~/.aws/credentials -mmin +600`; then
    fast ~/.aws/credentials git
fi

eval "$(mcfly init bash)"
eval "$(starship init bash)"

export MCFLY_RESULTS=25

source ~/bin/starship-completions.sh
source ~/bin/just-completions.sh

export G4DB="host=localhost; database=g4dev; user id=postgres; password=postgres"
export G4TEST="host=localhost; database=g4test; user id=postgres; password=postgres"
