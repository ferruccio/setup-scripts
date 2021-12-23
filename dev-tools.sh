#! /usr/bin/env bash

# install cargo-based tools
cargo install --target-dir=/tmp/target \
    cargo-audit cargo-edit cargo-outdated cargo-deny cargo-update \
    ripgrep exa bat fd-find git-delta mcfly mdbook onefetch

# install node & npm using nvm
nvm install 14
nvm install-latest-npm

# install .NET
wget https://dot.net/v1/dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh -c 6.0
cat >>~/.profile <<EOF
# add .NET to path
export PATH="\$HOME/.dotnet:\$PATH"
EOF
source ~/.profile
