# Zsh + Sheldon

`chezmoi/dot_zshrc`에서 쉘 설정을 관리합니다.

## 구성 이유

- 프롬프트는 Starship으로 통일
- 플러그인은 Sheldon으로 빠르게 로딩
- fzf, zoxide 등 생산성 도구를 기본 제공

## 주요 설정

- Starship 초기화
- Sheldon 플러그인 로더
- fzf 키바인딩/완성 스니펫
- zoxide alias (`cd` → `z`)
- `~/.local/bin` 경로 추가(uv tool 설치 바이너리)
- direnv 자동 로드
- Colima 사용 시 Docker 소켓 지정

## 플러그인 추가/제거

Sheldon 플러그인 목록은 `chezmoi/dot_config/sheldon/plugins.toml`에 있습니다.

현재 포함:

- zsh-autosuggestions
- zsh-completions
- zsh-history-substring-search
- zsh-syntax-highlighting
- zsh-autopair
- fzf-tab

새 플러그인 추가 예시:

```toml
[plugins.zsh-autosuggestions]
github = "zsh-users/zsh-autosuggestions"
```

적용 후 잠금 파일 생성:

```sh
sheldon lock
```

## 다른 변경 포인트

- 별칭: `dot_zshrc`의 `alias` 섹션
- fzf 경로: Homebrew 설치 경로가 다르면 경로 수정
- direnv 적용: 프로젝트에서 `direnv allow` 실행
