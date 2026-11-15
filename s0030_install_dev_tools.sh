#!/bin/sh
set -e

sudo apt -y update

# C / C++ development toolchain, build systems, debuggers & analysis
sudo apt install -y \
    build-essential \
    gdb \
    clang \
    clangd \
    clang-format \
    clang-tidy \
    cppcheck \
    cmake \
    ninja-build \
    pkg-config \
    valgrind \
    strace

# Python development tools, linters, formatters & testing (Ubuntu PEP 668 compliant)
sudo apt install -y \
    python3-full \
    python3-dev \
    python3-pip \
    pipx \
    black \
    mypy \
    python3-pytest \
    python3-coverage

# Shell scripting linters, formatters & testing
sudo apt install -y \
    shellcheck \
    shfmt \
    bats

# Ensure ~/.local/bin is in PATH and install ruff via pipx
pipx ensurepath
pipx install ruff

# Configure global C/C++ clang-format defaults (only if not already present)
if [ ! -f "$HOME/.clang-format" ]; then
    cat <<'EOF' >"$HOME/.clang-format"
BasedOnStyle: LLVM
IndentWidth: 4
TabWidth: 4
UseTab: Never
ColumnLimit: 100
EOF
fi

# Configure GDB history and disable pagination (only if not already present)
if [ ! -f "$HOME/.gdbinit" ]; then
    cat <<'EOF' >"$HOME/.gdbinit"
set pagination off
set history save on
set history size 10000
set history filename ~/.gdb_history
EOF
fi

# Configure global Ruff defaults to match Black line length (only if not already present)
mkdir -p "$HOME/.config/ruff"
if [ ! -f "$HOME/.config/ruff/ruff.toml" ]; then
    cat <<'EOF' >"$HOME/.config/ruff/ruff.toml"
line-length = 88
target-version = "py312"

[lint]
select = ["E", "F", "I", "UP", "B"]
EOF
fi
