# Neovim

Neovim 설정은 아래 두 파일로 구성됩니다.

- `chezmoi/dot_config/nvim/init.lua`
- `chezmoi/dot_config/nvim/lua/plugins.lua`

## 기본 설정

- 라인 번호/상대 번호
- 스페이스 2칸 인덴트
- 스마트 검색 옵션
- split 방향 기본값
- 시스템 클립보드 사용

필수적인 개발 경험만 담고, 취향이 크게 갈리는 요소는 최소화했습니다.

기본 리더 키는 스페이스입니다. 자주 쓰는 키맵:

- `<leader>w`: 저장
- `<leader>q`: 닫기
- `<leader>h`: 검색 하이라이트 끄기
- `<leader>f`: 포맷

## 플러그인 구성

`lazy.nvim`으로 플러그인을 관리합니다. 기본 포함:

- Comment.nvim
- which-key.nvim
- gitsigns.nvim
- lualine.nvim
- oil.nvim (`-`, `<leader>e`)
- telescope.nvim (`<leader>ff`, `<leader>fg`, `<leader>fb`, `<leader>fh`)
- nvim-treesitter
- nvim-lspconfig + mason + nvim-cmp + luasnip
- nvim-autopairs
- conform.nvim (포맷)

`which-key.nvim`은 키맵 힌트를 보여줘서 입문자에게 도움이 됩니다.

Mason으로 자동 설치되는 LSP:

- lua_ls
- tsserver
- rust_analyzer

Python LSP:

- ty (바이너리가 있으면 활성화, mason과 별개)

포맷터:

- Python: ruff
- JS/TS/JSON: biome

타입 체크:

- Python: ty (LSP, `ty server`)

`ty`는 `uv tool install ty`로 설치되며, `~/.local/bin` 경로가 필요합니다.
`lspconfig`에 `ty` 서버가 내장되어 있지 않더라도 로컬 설정에서 등록합니다.

## 커스터마이징

- 플러그인 추가/삭제: `plugins.lua` 수정
- 옵션 변경: `init.lua` 수정
- LSP 자동 설치 목록: `mason-lspconfig`의 `ensure_installed` 수정
- Python LSP: `ty` 바이너리가 있으면 자동 활성화

첫 실행 시 `lazy.nvim`이 네트워크로 내려받아집니다.
