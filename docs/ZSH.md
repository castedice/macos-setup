# Zsh + Sheldon

`chezmoi/dot_zshrc`에서 쉘 설정을 관리합니다.

## 설계 목표

- **빠른 로딩**: 플러그인 로딩을 최소화하고 캐시 기반으로 구성
- **단순한 구성**: 프롬프트/플러그인을 분리해서 문제 원인을 빠르게 찾기
- **생산성 기본값**: 기본 작업에 바로 효과가 있는 도구만 포함

## 왜 Sheldon인가

- 설정이 단순하고 TOML 기반이라 관리가 쉽습니다.
- lock 파일을 통해 플러그인 버전을 고정할 수 있습니다.
- Oh My Zsh 같은 프레임워크보다 가볍고 로딩이 빠릅니다.

## 플러그인 선택 이유

현재 포함된 플러그인과 이유는 아래와 같습니다.

- `zsh-autosuggestions`: 명령 입력 속도 향상, 학습 비용이 낮음
- `zsh-completions`: 기본 completion을 강화
- `zsh-history-substring-search`: 히스토리 탐색이 효율적
- `zsh-syntax-highlighting`: 오타/실수 인지
- `zsh-autopair`: 괄호/따옴표 입력 감소
- `fzf-tab`: completion UI 개선, fzf와 궁합이 좋음

## 주요 설정과 이유

- Starship: 프롬프트를 쉘과 분리해 유지보수성을 높임
- `compinit`: 기본 completion 초기화
- `~/.local/bin`, `~/.cargo/bin`: uv/rustup 도구 경로 확보
- direnv 자동 로드: 프로젝트별 환경변수 자동 적용
- zoxide: 디렉터리 이동 속도 개선 (`cd` → `z`)
- fzf 키바인딩/완성: 검색 효율 향상
- Colima 소켓 지정: Docker 명령 일관화

## 플러그인 추가/제거

Sheldon 플러그인 목록은 `chezmoi/dot_config/sheldon/plugins.toml`에 있습니다.

새 플러그인 추가 예시:

```toml
[plugins.zsh-autosuggestions]
github = "zsh-users/zsh-autosuggestions"
```

적용 후 잠금 파일 생성:

```sh
sheldon lock
```

### 제거할 때 고려할 점

- `zsh-syntax-highlighting`은 마지막에 로드되어야 합니다.
- `fzf-tab`은 completion 동작을 바꾸므로 문제가 있으면 우선 비활성화하세요.

## 다른 변경 포인트

- 별칭: `dot_zshrc`의 `alias` 섹션
- fzf 경로: Homebrew 설치 경로가 다르면 경로 수정
- direnv 적용: 프로젝트에서 `direnv allow` 실행
