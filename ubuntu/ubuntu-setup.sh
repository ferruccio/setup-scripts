#! /usr/bin/env bash

set -x

mkdir ~/tmp && pushd $_

sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y

# install dependencies and tools
sudo apt install -y htop \
    docker.io docker-compose jq xclip zip unzip \
    python3-pip dotnet6 cmake gcc libmagic-dev libssl-dev pkg-config

sudo usermod -aG docker $USER

pip install git-remote-codecommit

# install AWS CLI (pick one)
curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
#curl https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip -o awscliv2.zip
unzip awscliv2.zip
sudo ./aws/install

# install Rust, Cargo plugins & tools
which rustc || curl --proto '=https' --tlsv1.2 -sSf -q https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

cargo install --target-dir=/tmp/target starship just mcfly fnm

cargo install --target-dir=/tmp/target \
    cargo-audit cargo-edit cargo-outdated cargo-deny cargo-update \
    cargo-lambda wasm-bindgen-cli wasm-pack \
    ripgrep exa bat fd-find difftastic mdbook onefetch

# generate bash completion scripts
starship completions bash >~/bin/starship-completions.sh
just --completions bash >~/bin/just-completions.sh
fnm completions >~/bin/fnm-completions.sh

# install nerd fonts
curl https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip -o JetBrainsMono.zip
mkdir -p ~/.local/share/fonts
unzip -n -d ~/.local/share/fonts JetBrainsMono.zip

# install Deno
curl -fsSL https://deno.land/x/install/install.sh | sh
cat >>~/.profile <<EOF
# add deno to path
export DENO_INSTALL="/home/fgb/.deno"
export PATH="\$DENO_INSTALL/bin:\$PATH"
EOF

popd

# update .bashrc
cat .bashrc >>~/.bashrc

# create .gitconfig
\cp .gitconfig ~

# create .bash_aliases
\cp .bash_aliases ~

# create .config/starship.toml
mkdir -p ~/.config
\cp starship.toml ~/.config

# create .editorconfig
\cp .editorconfig ~/.editorconfig

# create .cargo/config.toml
\cp config.toml ~/.cargo/config.toml

# no longer cromulent; replaced by .editorconfig
# create .omnisharp/omnisharp.json
#mkdir -p ~/.omnisharp
#\cp omnisharp.json ~/.omnisharp

cat <<EOF

To complete setup:

    * reboot system

    * run after login:
        aws configure
        fnm default 18
        npm install -g aws-cdk

EOF
