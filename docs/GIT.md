# Git

`chezmoi/dot_gitconfig.tmpl`에 기본 Git 설정이 들어있습니다.

## 포함 설정

- 기본 브랜치: `main`
- pager: `delta`
- SSH 커밋 서명(선택)
- 전역 ignore 사용 (`~/.config/git/ignore`)
- 자주 쓰는 alias 제공
- delta 꾸미기 옵션(파일/커밋 헤더 강조)
- pull 시 rebase 기본값, 자동 stash
- rerere 활성화(충돌 해결 재사용)
- GitHub HTTPS URL을 SSH로 자동 변환

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
