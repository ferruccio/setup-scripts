#! /usr/bin/env bash

sudo apt update -y
sudo apt upgrade -y

# install Deno
curl -fsSL https://deno.land/x/install/install.sh | sh
cat >>~/.profile <<EOF

# add deno to path
export DENO_INSTALL="/home/fgb/.deno"
export PATH="\$DENO_INSTALL/bin:\$PATH"
EOF

# install dependencies and tools
sudo apt install -y libssl-dev subversion htop

# install Rust, Cargo plugins & tools
curl --proto '=https' --tlsv1.2 -sSf -q https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

cargo install --target-dir=/tmp/target \
    cargo-audit cargo-edit cargo-outdated cargo-deny cargo-update
cargo install --target-dir=/tmp/target  \
    ripgrep exa bat fd-find git-delta starship just mcfly mdbook onefetch

# install nvm, node & npm
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.profile
nvm install 14
nvm install-latest-npm

# install AWS CLI
pushd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
popd

# build fast from source
mkdir ~/bin
pushd /tmp
git clone https://github.com/ferruccio/fast.git
cd fast
cargo build --release
cp ./target/release/fast ~/bin
popd

# completions
starship completions bash >~/bin/starship-completions.sh
just completions bash >~/bin/just-completions.sh

# install .NET
wget https://dot.net/v1/dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh -c 6.0
cat >>.profile <<EOF

# add .NET to path
export PATH="/home/fgb/.dotnet:\$PATH"
EOF
source ~/.profile

# configure AWS
aws configure
fast ~/.aws/credentials git

# update .bashrc
cat >>~/.bashrc <<EOF

fast ~/.aws/credentials git >/dev/null

eval "\$(mcfly init bash)"
eval "\$(starship init bash)"

export MCFLY_RESULTS=25

source ~/bin/starship-completions.sh
source ~/bin/just-completions.sh
EOF

# create .gitconfig
cat >~/.gitconfig <<EOF
[user]
    email = ferruccio.barletta@gmail.com
    name = Ferruccio Barletta

[credential]
    helper = !aws --profile git codecommit credential-helper \$@
    UseHttpPath = true

[core]
    pager = delta

[delta]
    features = line-numbers decorations
    syntax-theme = Dracula
    plus-style = syntax "#003800"
    minus-style = syntax "#3f0001"

[delta "decorations"]
    commit-decoration-style = bold yellow box ul
    file-style = bold yellow ul
    file-decoration-style = none
    hunk-header-decoration-style = cyan box ul

[delta "line-numbers"]
    line-numbers-left-style = cyan
    line-numbers-right-style = cyan
    line-numbers-minus-style = 124
    line-numbers-plus-style = 28

[diff]
    colorMoved = default
EOF

# create .bash_aliases
cat >~/.bash_aliases <<EOF
alias l='exa --across --group-directories-first'
alias ls='exa -a --group-directories-first'
alias la='exa -al --group-directories-first'
alias ll='exa -l --group-directories-first'
alias l.='exa -a | rg "^\."'

alias ..='cd ..'
alias ...='cd ../..'
alias cls="clear && printf '\e[3J'"

alias cp='cp -i'
alias more=less

alias rm='rm -i'
alias mv='mv -i'

alias gls='git log --oneline -n 20 && git status -s'

alias myip='curl ifconfig.me -w "\n"'
EOF

# create .config/starship.toml
cat >~/.config/starship.toml <<EOF
add_newline = true

[character]
success_symbol = "[\\\\\$](bold green)"
error_symbol = "[\\\\\$](bold red)"

[aws]
disabled = true
EOF
