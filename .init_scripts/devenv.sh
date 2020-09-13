
# Get distro information
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  OS="${NAME}"
  VER="${VERSION_ID}"
elif type lsb_release >/dev/null 2>&1; then
  OS="$(lsb_release -si)"
  VER="$(lsb_release -sr)"
fi

# Distro specific actions
if [[ "${OS}" == "Ubuntu" ]]; then
  # PPA's
  sudo add-apt-repository ppa:longsleep/golang-backports -y

  # Update
  sudo apt update

  # Install
  sudo apt install golang-go -y
  sudo apt install neovim -y
  sudo apt install ctags -y
  sudo apt install openjdk-14-jdk-headless -y
  sudo apt install gcc -y
  sudo apt install make -y
  sudo apt install zsh -y
elif [[ "${OS}" == "Manjaro Linux" || "${OS}" = "Arch Linux" ]]; then
  sudo pacman -S go --noconfirm
  sudo pacman -S neovim --noconfirm
  sudo pacman -S ctags --noconfirm
  sudo pacman -S jdk-openjdk --noconfirm
  sudo pacman -S gcc --noconfirm
  sudo pacman -S make --noconfirm
  sudo pacman -S zsh --noconfirm
else
  echo "OS: ${OS}; VER: ${VER}; Not currently supported."
  exit 1
fi

# Set shell
SH="$(getent passwd $LOGNAME | cut -d: -f7)"
if [[ "${SH##*/}" != "zsh" ]]; then
  sudo chsh -s "$(which zsh)" "${USER}"
fi

## Dist independent setup
# Nodejs lts
curl -sL install-node.now.sh/lts | bash

# Python packages
python3 -m pip install --user msgpack
python3 -m pip install --user pynvim
python3 -m pip install --user jedi

# Rust
sh <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs) -y --no-modify-path
# Temporarily add rust to path and add nightly
export PATH="${PATH}:${HOME}/.cargo/bin"
# Add nightly toochain
rustup toolchain add nightly
# Racer
cargo +nightly install racer
rustup component add rust-src

# Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim +PlugInstall +qa
nvim +CocInstall coc-json coc-tsserver
nvim +CocInstall coc-java
