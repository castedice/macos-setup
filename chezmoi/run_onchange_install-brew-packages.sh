#!/bin/bash

# Brewfile 해시: {{ include "dot_Brewfile.tmpl" | sha256sum }}

echo "📦 Brewfile 변경 감지! 패키지 동기화 중..."
brew bundle --global

if command -v uv &> /dev/null && ! command -v ty &> /dev/null; then
    echo "🐍 ty 설치..."
    uv tool install ty
fi

if command -v rustup-init &> /dev/null && ! command -v rustup &> /dev/null; then
    echo "🦀 rustup 초기화..."
    rustup-init -y --no-modify-path --profile minimal
    if [ -x "$HOME/.cargo/bin/rustup" ]; then
        "$HOME/.cargo/bin/rustup" default stable
        "$HOME/.cargo/bin/rustup" component add rustfmt clippy || true
    fi
fi
