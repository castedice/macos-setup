# Starship

`chezmoi/dot_config/starship.toml.tmpl`에서 프롬프트를 설정합니다.

## 설계 목표

- **실수 방지**: 어떤 호스트/디렉터리인지 즉시 파악
- **속도 우선**: 헤드리스 환경에서는 최소 정보만 표시
- **가독성**: 짧고 명확한 색/모듈 구성

## headless/desktop 분기 이유

- headless(헤드리스): SSH 접속이 많아 **짧고 빠른 프롬프트**가 중요합니다.
- desktop(데스크탑): 로컬에서 작업이 길어져 **맥락 정보**를 더 보여줍니다.

## 모듈 선택 이유

- `username`, `hostname`: 다른 호스트에서 작업 중 실수 방지
- `directory`: 현재 위치 확인, repo 기준으로 축약해 가독성 유지
- `read_only`: 쓰기 불가 디렉터리 경고
- `git_branch`, `git_status`: 작업 중 브랜치/상태 확인
- `jobs`: 백그라운드 작업 수 확인
- `status`: 실패한 명령 즉시 확인
- `cmd_duration`: 오래 걸린 명령 확인
- `time`: 현재 시간(세션 길어질 때 유용)

## 변경 방법

- `format` 문자열을 원하는 형태로 수정
- 모듈별 설정을 추가/제거

성능이 걱정된다면:

- 대형 레포에서 `git_status`는 느려질 수 있으므로 필요하면 끄세요.
- 최소 프롬프트가 필요하면 `status`, `cmd_duration`, `time`을 끌 수 있습니다.

예시(최소화):

```toml
format = "$directory$character"
[git_status]
disabled = true
[status]
disabled = true
```

적용 후 새 터미널에서 확인됩니다.
