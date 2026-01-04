# Homebrew

`chezmoi/dot_Brewfile.tmpl`에서 패키지를 관리합니다. 적용은
`brew bundle --global`로 수행됩니다.

## 구성 원칙

- 기본 유틸은 GNU 계열을 기본으로 둡니다.
- 속도/사용성 개선을 위해 Rust 기반 대체 도구를 우선합니다.
- GUI 앱은 headless 모드에서 제외합니다.

## 카테고리

- 기본 CLI: git, jq, coreutils, gnu-sed, wget, tree, watch
- Rust 기반 도구: bat, eza, ripgrep, fd, git-delta, zoxide, procs, duf,
  dust, bottom, sd, hyperfine, xh, tealdeer
- 쉘/프롬프트: sheldon, starship, direnv
- 개발: neovim, gh
- Python 도구: uv, ruff
- 언어 런타임: node, rustup-init
- JS/TS 도구: biome
- 컨테이너: colima, docker, docker-compose

## headless 분기

`headless`가 `true`이면 GUI 앱을 설치하지 않습니다.

## 변경 방법

- 새 패키지 추가: `brew "패키지명"` 또는 `cask "앱명"`을 추가
- 제거: 해당 라인을 삭제
- 분기: `{{- if .headless }}` 조건 블록에 넣기

Rust는 `rustup-init`으로 설치하고 `rustup`을 사용합니다.

`ty`는 `uv tool install ty`로 설치합니다. (brew 패키지가 아닌 Python 툴)

적용 후 다시 동기화하려면:

```sh
brew bundle --global
```
