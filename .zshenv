# Pre Path
export DOCKER_HOST="unix://${XDG_RUNTIME_DIR}/docker.sock"

# Path
export GOPATH="${HOME}/go"
export GOBIN="${GOPATH}/bin"
export PATH="${PATH}:${GOBIN}"
export PATH="${PATH}:${HOME}/.cargo/bin"
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="${PATH}:${HOME}/.local/custom/bin"
export PATH="${PATH}:/opt/cuda/bin"

# Post Path
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
