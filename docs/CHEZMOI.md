# Chezmoi

이 레포는 `chezmoi/`를 **소스 디렉터리**로 사용합니다. 그래서 레포 루트에는
부트스트랩 관련 파일만 있고, 실제 dotfiles는 `chezmoi/` 아래에 모였습니다.

## 설계 이유

- curl 부트스트랩과 dotfiles를 분리해 초기 진입 장벽을 낮추기 위해
- Git 로그인 없이도 필요한 파일만 내려받아 적용하기 위해
- `chezmoi`가 관리하는 범위를 명확히 해 롤백/업데이트를 단순화하기 위해

## 트레이드오프

- 로컬에 Git 히스토리가 남지 않습니다.
- 업데이트는 아카이브 재다운로드 방식으로 진행해야 합니다.

## 적용 방법

```sh
CHEZMOI_SOURCE_DIR=~/.local/share/macos-setup/chezmoi chezmoi apply --force
```

`bootstrap.sh`는 Git 클론 대신 아카이브를 내려받아 `chezmoi/`만 저장합니다.

## 업데이트

```sh
ARCHIVE=/tmp/macos-setup.tar.gz
curl -fsSL https://github.com/castedice/macos-setup/archive/refs/heads/main.tar.gz -o "$ARCHIVE"
ARCHIVE_PREFIX="$(tar -tf "$ARCHIVE" | head -n1 | cut -d/ -f1)"
tar -xzf "$ARCHIVE" -C ~/.local/share/macos-setup/chezmoi --strip-components=2 "$ARCHIVE_PREFIX/chezmoi"
CHEZMOI_SOURCE_DIR=~/.local/share/macos-setup/chezmoi chezmoi apply --force
```

## 프롬프트

`chezmoi/dot_chezmoi.toml.tmpl`에서 아래 값을 입력받습니다.

- headless 여부
- Git 이름/이메일
- Git SSH 서명 키 경로(선택)

## 개인 정보 관리 가이드

- 이름/이메일/서명키처럼 **환경마다 다른 값**은 템플릿 프롬프트로 분리했습니다.
- 비밀값(토큰/키 등)은 레포에 저장하지 마세요.
  - 로컬에만 존재하는 파일로 관리하거나,
  - `chezmoi`의 ignore 기능을 사용하세요.

## 롤백

chezmoi가 관리하는 파일을 제거합니다.

```sh
CHEZMOI_SOURCE_DIR=~/.local/share/macos-setup/chezmoi chezmoi apply --reverse
```

기존 파일을 덮어쓴 경우, 필요하면 백업에서 복원하세요.

## 파일 네이밍 규칙

- `dot_zshrc` → `~/.zshrc`
- `dot_config/*` → `~/.config/*`
- `run_once_*` → 최초 1회 실행 스크립트
- `run_onchange_*` → 변경 시 실행 스크립트
