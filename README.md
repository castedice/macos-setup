# macos-setup

Apple Silicon용 macOS 부트스트랩 + dotfiles 세트입니다. `bootstrap.sh`는
필수 도구만 설치하고, 설정 파일은 필요할 때만 레포를 내려받아 적용합니다.

## 특징

- curl로 부트스트랩만 실행 가능
- chezmoi 기반 dotfiles 관리
- headless/desktop 분기 지원
- Rust 기반 대체 도구 중심의 기본 CLI 세트
- Git 로그인 없이 필요한 파일만 적용

## 지원 환경

- Apple Silicon(macOS)
- 네트워크 연결 필요(Homebrew/chezmoi 설치)

## 빠른 시작 (castedice 기본 설정)

```sh
curl -fsSL https://raw.githubusercontent.com/castedice/macos-setup/main/bootstrap.sh | bash
```

스크립트 실행 후 GitHub ID를 묻는 프롬프트에 `castedice`를 입력하면,
이 레포의 기본 설정이 적용됩니다.

원하면 먼저 파일을 내려받아 내용을 확인한 뒤 실행할 수도 있습니다.

```sh
curl -fsSL https://raw.githubusercontent.com/castedice/macos-setup/main/bootstrap.sh -o /tmp/bootstrap.sh
bash /tmp/bootstrap.sh
```

## 내 설정으로 사용하기 (포크 권장)

1) 이 레포를 포크합니다.
2) `chezmoi/` 아래의 파일을 원하는 대로 수정합니다.
3) `bootstrap.sh` URL의 `castedice`를 본인 GitHub ID로 바꿉니다.
4) 실행 중 프롬프트에 본인 GitHub ID를 입력합니다.

## 적용/업데이트/롤백

처음에는 부트스트랩만 실행하고, 이후에 dotfiles만 적용할 수 있습니다.
Git 로그인 없이 아카이브를 내려받아 적용하는 방식입니다.

```sh
ARCHIVE=/tmp/macos-setup.tar.gz
curl -fsSL https://github.com/castedice/macos-setup/archive/refs/heads/main.tar.gz -o "$ARCHIVE"
ARCHIVE_PREFIX="$(tar -tf "$ARCHIVE" | head -n1 | cut -d/ -f1)"
mkdir -p ~/.local/share/macos-setup/chezmoi
tar -xzf "$ARCHIVE" -C ~/.local/share/macos-setup/chezmoi --strip-components=2 "$ARCHIVE_PREFIX/chezmoi"
CHEZMOI_SOURCE_DIR=~/.local/share/macos-setup/chezmoi chezmoi apply --force
```

포크 사용 시 `castedice`를 본인 GitHub ID로 바꾸세요.

업데이트도 동일하게 아카이브를 다시 내려받아 덮어씁니다.

롤백(chezmoi가 관리하는 파일 제거):

```sh
CHEZMOI_SOURCE_DIR=~/.local/share/macos-setup/chezmoi chezmoi apply --reverse
```

## 폴더 구조

- `bootstrap.sh`: 부트스트랩 스크립트 (curl로 실행)
- `chezmoi/`: dotfiles 소스
- `docs/`: 설정 문서

## 문서

- `docs/README.md`: 문서 인덱스
- `docs/BOOTSTRAP.md`: 부트스트랩 흐름
- `docs/CHEZMOI.md`: chezmoi 구조/프롬프트/롤백
- `docs/BREW.md`: Homebrew 패키지 구성
- `docs/RUNTIMES.md`: 언어 런타임 선택
- `docs/DIRENV.md`: direnv 사용
- `docs/ZSH.md`: zsh + sheldon
- `docs/STARSHIP.md`: 프롬프트 설정
- `docs/GIT.md`: Git 설정 및 SSH 서명
- `docs/NVIM.md`: Neovim 기본 설정/플러그인
- `docs/MACOS.md`: macOS 기본값
