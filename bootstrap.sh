#!/bin/bash
set -e

echo "🚀 Mac 부트스트랩 시작!"

# 0. 플랫폼 확인 (Apple Silicon 전용)
if [ "$(uname -m)" != "arm64" ]; then
    echo "❌ Apple Silicon(arm64) 전용 스크립트입니다."
    exit 1
fi

# 1. Xcode CLI (간편 체크)
if ! xcode-select -p &> /dev/null; then
    echo "🛠 Xcode CLI 설치 (팝업이 뜨면 설치해주세요)..."
    xcode-select --install
    echo "설치가 완료되면 엔터를 눌러주세요."
    read
fi

# 2. Homebrew
if ! command -v brew &> /dev/null; then
    echo "🍺 Homebrew 설치..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    BREW_SHELLENV='eval "$(/opt/homebrew/bin/brew shellenv)"'
    if ! grep -Fqs "$BREW_SHELLENV" "$HOME/.zprofile"; then
        echo "$BREW_SHELLENV" >> "$HOME/.zprofile"
    fi
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 3. Chezmoi 설치 및 적용
if ! command -v chezmoi &> /dev/null; then
    echo "🏠 Chezmoi 설치..."
    brew install chezmoi
fi

read -p "dotfiles 적용할까요? (y/N): " APPLY_DOTFILES
if [[ "$APPLY_DOTFILES" =~ ^[Yy]$ ]]; then
    echo ""
    read -p "GitHub User ID (예: park-kibum): " GITHUB_USER
    if [ -z "$GITHUB_USER" ]; then echo "❌ ID 입력 필요"; exit 1; fi

    REPO_URL="https://github.com/$GITHUB_USER/macos-setup"
    ARCHIVE_URL="$REPO_URL/archive/refs/heads/main.tar.gz"
    REPO_DIR="$HOME/.local/share/macos-setup"
    CHEZMOI_DIR="$REPO_DIR/chezmoi"
    TMP_DIR="$(mktemp -d)"
    ARCHIVE_PATH="$TMP_DIR/macos-setup.tar.gz"

    echo "⬇️  dotfiles 아카이브 다운로드 중..."
    mkdir -p "$HOME/.local/share"
    curl -fsSL "$ARCHIVE_URL" -o "$ARCHIVE_PATH"

    ARCHIVE_PREFIX="$(tar -tf "$ARCHIVE_PATH" | head -n1 | cut -d/ -f1)"
    if [ -z "$ARCHIVE_PREFIX" ]; then
        echo "❌ 아카이브 확인 실패"
        exit 1
    fi

    rm -rf "$CHEZMOI_DIR"
    mkdir -p "$CHEZMOI_DIR"
    tar -xzf "$ARCHIVE_PATH" -C "$CHEZMOI_DIR" --strip-components=2 "$ARCHIVE_PREFIX/chezmoi"
    rm -rf "$TMP_DIR"

    echo "🔄 dotfiles 적용 중..."
    # --force: 기존 설정 덮어쓰기
    CHEZMOI_SOURCE_DIR="$CHEZMOI_DIR" chezmoi apply --force
else
    echo "ℹ️  dotfiles 적용은 건너뜁니다."
    echo "   나중에 적용하려면 아래 명령을 실행하세요:"
    echo "   ARCHIVE=/tmp/macos-setup.tar.gz"
    echo "   curl -fsSL https://github.com/<github-user>/macos-setup/archive/refs/heads/main.tar.gz -o \"\$ARCHIVE\""
    echo "   ARCHIVE_PREFIX=\"\$(tar -tf \"\$ARCHIVE\" | head -n1 | cut -d/ -f1)\""
    echo "   mkdir -p ~/.local/share/macos-setup/chezmoi"
    echo "   tar -xzf \"\$ARCHIVE\" -C ~/.local/share/macos-setup/chezmoi --strip-components=2 \"\$ARCHIVE_PREFIX/chezmoi\""
    echo "   CHEZMOI_SOURCE_DIR=~/.local/share/macos-setup/chezmoi chezmoi apply --force"
fi

echo "✨ 모든 설정 완료! 터미널을 재시작하세요."
