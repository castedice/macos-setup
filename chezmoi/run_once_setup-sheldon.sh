#!/bin/bash

echo "🔌 Sheldon 플러그인 확인 및 초기화..."

if ! command -v sheldon &> /dev/null; then
    echo "   >> sheldon 미설치: 스킵"
    exit 0
fi

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/sheldon"
if [ ! -f "$CONFIG_DIR/plugins.toml" ]; then
    echo "   >> plugins.toml 없음: 스킵"
    exit 0
fi

if ! sheldon lock; then
    echo "   >> sheldon lock 실패: 스킵"
fi
