#! /usr/bin/env bash

set -x

mkdir ~/tmp && cd $_

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
    cargo-audit cargo-edit cargo-outdated cargo-deny cargo-update \
    ripgrep exa bat fd-find git-delta starship just mcfly mdbook onefetch

# install nvm, node & npm
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh -o install.sh
source install.sh
source ~/.bashrc
nvm install 14
nvm install-latest-npm

# install AWS CLI
curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
unzip awscliv2.zip
sudo ./aws/install

# build fast from source
mkdir ~/bin
git clone https://github.com/ferruccio/fast.git
pushd fast
cargo build --release
cp ./target/release/fast ~/bin
popd

# generate completions
starship completions bash >~/bin/starship-completions.sh
just --completions bash >~/bin/just-completions.sh

# install .NET
wget https://dot.net/v1/dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh -c 6.0
cat >>~/.profile <<EOF
# add .NET to path
export PATH="\$HOME/.dotnet:\$PATH"
EOF
source ~/.profile

# configure AWS
aws configure
fast ~/.aws/credentials git

# update .bashrc
cat .bashrc >>~/.bashrc

# create .gitconfig
cat .gitconfig >~/.gitconfig

# create .bash_aliases
cat .bash_aliases >~/.bash_aliases

# create .config/starship.toml
cat starship.toml >~/.config/starship.toml
