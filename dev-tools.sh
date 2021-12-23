#! /usr/bin/env bash

source "$NVM_DIR/nvm.sh"

# install cargo-based tools
cargo install --target-dir=/tmp/target \
    cargo-audit cargo-edit cargo-outdated cargo-deny cargo-update \
    ripgrep exa bat fd-find git-delta mdbook onefetch

# install node & npm using nvm
nvm install 14
nvm install-latest-npm

# install .NET
pushd ~/tmp
wget https://dot.net/v1/dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh -c 6.0
cat >>~/.profile <<EOF
# add .NET to path
export PATH="\$HOME/.dotnet:\$PATH"
EOF
source ~/.profile
popd

printf "\nsome commands will not be available until the next login"
