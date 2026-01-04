# Git

`chezmoi/dot_gitconfig.tmpl`에 기본 Git 설정이 들어있습니다.

## 설계 목표

- **가독성**: diff/로그를 더 빠르게 이해
- **실수 방지**: 브랜치/원격 설정 자동화
- **충돌 대응**: 재해결 비용 감소

## 포함 설정과 선택 이유

- 기본 브랜치: `main` (대부분의 서비스 기본값)
- pager: `delta` (diff 가독성 향상)
- `diff.colorMoved`: 이동된 코드 식별이 쉬움
- `merge.conflictstyle=diff3`: 충돌 원인 파악에 유리
- pull 시 `rebase` 기본값: 히스토리 깔끔 유지
- rebase `autoStash`: 작업 중인 변경이 있을 때 편의성
- `rerere` 활성화: 반복되는 충돌을 자동으로 재적용
- `fetch.prune`: 삭제된 원격 브랜치 정리
- `push.autoSetupRemote`: 새 브랜치 push 시 업스트림 자동 설정
- GitHub HTTPS URL을 SSH로 자동 변환: SSH 사용 기본값 보장

## SSH 서명 사용

`chezmoi` 프롬프트에서 SSH 공개키 경로를 입력하면
`signingkey`, `gpg.format=ssh`, `commit.gpgsign=true`가 자동 설정됩니다.

서명을 끄고 싶다면:

- 프롬프트에서 서명 키를 비워두거나
- `dot_gitconfig.tmpl`의 서명 관련 블록을 제거

## 변경 방법

- 이름/이메일: `dot_chezmoi.toml.tmpl` 프롬프트 또는 `dot_gitconfig.tmpl` 직접 수정
- delta 옵션: `dot_gitconfig.tmpl`의 `[delta]` 섹션 수정
- 전역 ignore: `dot_config/git/ignore` 수정
- alias: `dot_gitconfig.tmpl`의 `[alias]` 섹션 수정
- SSH 자동 변환 끄기: `dot_gitconfig.tmpl`의 `[url "git@github.com:"]` 섹션 제거

## 트레이드오프

- `pull.rebase=true`는 merge 커밋을 피하지만 팀 정책에 따라 충돌할 수 있습니다.
- `rerere`는 편리하지만 충돌 해결을 자동으로 재적용하므로
  의도하지 않은 결과가 없는지 확인이 필요합니다.
