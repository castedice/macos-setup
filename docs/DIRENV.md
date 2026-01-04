# direnv

`direnv`는 디렉터리별로 환경 변수를 자동 로드합니다.

## 기본 흐름

1) 프로젝트 루트에 `.envrc` 작성  
2) `direnv allow` 실행  
3) 해당 디렉터리에 들어갈 때 자동 적용

## uv와 함께 쓰기

이 레포는 `~/.config/direnv/direnvrc`에 `use_uv` 함수를 제공합니다.

예시 `.envrc`:

```sh
use_uv
```

`use_uv`는 `.venv`가 없으면 `uv venv`로 생성하고 자동 활성화합니다.

## 주의사항

- `.envrc`에는 비밀키를 직접 넣지 말고, 필요하면 별도 파일로 분리하세요.
- 팀과 공유할 때는 허용된 변수만 넣는 것을 권장합니다.
