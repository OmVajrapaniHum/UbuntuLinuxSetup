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
    ruff \
    mypy \
    python3-pytest \
    python3-coverage


# Shell scripting linters, formatters & testing
sudo apt install -y \
    shellcheck \
    shfmt \
    bats
