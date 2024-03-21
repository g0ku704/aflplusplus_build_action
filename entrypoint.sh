#!/bin/bash

set -eu

# Parse input parameters
FILE_NAME="$1"
SOURCE_DIR="$2"
COMPILER="$3"
USE_ASAN="$4"

# Compile target with AFL++ compiler
case "$COMPILER" in
    "gcc")
        AFL_COMPILER="afl-gcc"
        AFL_COMPILER_CXX="afl-g++"
        ;;
    "clang-fast")
        AFL_COMPILER="afl-clang-fast"
        AFL_COMPILER_CXX="afl-clang-fast++"
        ;;
    "clang-lto")
        AFL_COMPILER="afl-clang-lto"
        AFL_COMPILER_CXX="afl-clang-lto++"
        ;;
    *)
        echo "Invalid compiler choice: $COMPILER"
        exit 1
        ;;
esac

# Change directory to source
cd $SOURCE_DIR

# Create build directory
mkdir -p build
cd build

# Configure project with AFL++ compiler
cmake -DCMAKE_C_COMPILER="$AFL_COMPILER" -DCMAKE_CXX_COMPILER="$AFL_COMPILER_CXX" ..

# Build project
make

# Move binary to workspace
mv "$FILE_NAME" /github/workspace

# Output binary path
echo "::set-output name=binary_path::/github/workspace/$FILE_NAME"