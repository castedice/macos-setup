# 언어 런타임 선택

이 레포는 `uv`(Python), `node`(JS), `rustup`(Rust) 조합을 기본으로 둡니다.

Rust는 `rustup-init`을 Homebrew로 설치한 뒤,
`run_onchange_install-brew-packages.sh`에서 `rustup-init -y`로 초기화합니다.
필수 컴포넌트로 `rustfmt`, `clippy`를 추가합니다.

Python 도구는 `uv`의 `tool` 기능으로 관리합니다. (예: `ty`)
Neovim에서는 `ty`의 LSP 서버(`ty server`)를 사용하도록 설정되어 있습니다.

`uv tool`로 설치한 바이너리는 기본적으로 `~/.local/bin`에 들어가므로
쉘에서 해당 경로를 PATH에 추가합니다.

## 왜 mise/asdf를 쓰지 않았나

- 각 언어의 전용 도구가 더 빠르고 안정적인 경우가 많습니다.
- 설정 복잡도를 낮추고, 문제가 생겼을 때 원인을 좁히기 쉽습니다.

## 언제 mise를 고려할까

- 여러 언어 버전을 프로젝트별로 자주 바꿔야 할 때
- 팀 표준이 mise/asdf로 통일되어 있을 때

그런 경우에는 `mise`를 도입하고, zsh 초기화와 `.mise.toml`만 추가하면
쉽게 전환할 수 있습니다.
