# Homebrew

`chezmoi/dot_Brewfile.tmpl`에서 패키지를 관리합니다. 적용은
`brew bundle --global`로 수행됩니다.

## 구성 원칙

- **작게 시작**: 필수 도구만 기본으로 넣고, 나머지는 필요할 때 추가
- **일관성**: macOS 기본 유틸과 GNU 유틸 차이로 인한 스크립트 오작동 최소화
- **성능/UX**: Rust 기반 대체 도구를 우선 고려
- **서버/데스크탑 분리**: GUI 앱은 headless에서 제외

## 카테고리별 선택 이유

### 기본 CLI

- `coreutils`, `gnu-sed`: 스크립트 호환성(리눅스 기준 동작을 기대하는 경우가 많음)
- `git`, `jq`, `wget`, `tree`, `watch`: 대부분의 작업에서 기본으로 필요한 유틸

### Rust 기반 대체 도구

- `bat`, `eza`, `ripgrep`, `fd`, `git-delta` 등은
  - 빠르고, 출력이 읽기 좋고, 기본 사용성(색/하이라이트/미리보기)이 좋습니다.
- 다만 **기본 유틸과 옵션이 1:1로 대응되지 않을 수 있습니다.**
  - 스크립트 호환을 중요하게 생각하면 기본 유틸을 유지하고
    대체 도구는 선택적으로 쓰는 것을 권장합니다.

### 검색/완성

- `fzf`: 파일/히스토리/명령 탐색 효율이 크게 올라가며 다른 도구들과도 잘 통합됩니다.

### 쉘/프롬프트

- `sheldon`: 빠르고 설정이 단순한 zsh 플러그인 매니저
- `starship`: 쉘에 독립적이고 빠른 프롬프트
- `direnv`: 프로젝트별 환경 변수를 안전하게 로드

### 개발 도구

- `gh`: GitHub 작업 흐름을 단순화(PR/이슈/리뷰)
- `neovim`: 가벼운 기본 에디터
- `biome`: JS/TS 포맷/린트를 빠르게 처리

### 언어 런타임

- `uv`, `ruff`: 빠른 파이썬 실행/툴 관리, 린트/포맷
- `node`: JS 런타임 (프로젝트별 버전이 필요하면 별도 도구로 확장)
- `rustup-init`: Rust 설치와 툴체인 관리의 표준

### 컨테이너

- `colima` + `docker` + `docker-compose`: Docker Desktop 없이도 가벼운 컨테이너 환경

## headless 분기

`headless`가 `true`이면 GUI 앱을 설치하지 않습니다.
서버에서는 리소스 사용량과 원격 운영 편의를 우선합니다.

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
