# Neovim

Neovim 설정은 아래 두 파일로 구성됩니다.

- `chezmoi/dot_config/nvim/init.lua`
- `chezmoi/dot_config/nvim/lua/plugins.lua`

## 설계 목표

- **입문 난이도 최소화**: 기본 키맵만으로도 편집/탐색이 가능하게
- **생산성 기본값**: 검색, 파일 탐색, LSP/완성은 기본 제공
- **확장 가능**: 필요할 때 플러그인만 늘리기

## 기본 설정 이유

- 라인 번호/상대 번호: 이동 명령과 함께 사용 시 효율적
- 스페이스 2칸 인덴트: 팀 환경에서 가장 범용적인 기본값
- 스마트 검색 옵션: 대소문자 검색의 피로도 감소
- split 방향 기본값: 예측 가능한 창 배치
- 시스템 클립보드: OS/터미널 간 복사/붙여넣기 일관화
- `undofile`: 종료 후에도 되돌리기 이력 유지

기본 리더 키는 스페이스입니다. 자주 쓰는 키맵:

- `<leader>w`: 저장
- `<leader>q`: 닫기
- `<leader>h`: 검색 하이라이트 끄기
- `<leader>f`: 포맷

## 플러그인 구성과 선택 이유

`lazy.nvim`으로 플러그인을 관리합니다. 기본 포함:

- Comment.nvim: 코드 주석 토글 (학습 비용 낮음)
- which-key.nvim: 키맵 힌트 제공 (입문자에게 중요)
- gitsigns.nvim: 변경 라인 표시 (리뷰/수정에 유용)
- lualine.nvim: 상태바를 간단하게 구성
- oil.nvim: 파일 탐색을 버퍼 기반으로 단순화
- telescope.nvim: 파일/검색/버퍼 탐색의 표준
- nvim-treesitter: 문법 하이라이트 품질 개선
- nvim-lspconfig + mason + nvim-cmp + luasnip: LSP/완성 기본 세트
- nvim-autopairs: 괄호/따옴표 자동 입력
- conform.nvim: 포맷터 통합

## LSP/포맷 구성

Mason으로 자동 설치되는 LSP:

- lua_ls
- tsserver
- rust_analyzer

Python LSP:

- ty (바이너리가 있으면 활성화, mason과 별개)

포맷터:

- Python: ruff
- JS/TS/JSON: biome

`ty`는 `uv tool install ty`로 설치되며, `~/.local/bin` 경로가 필요합니다.
`lspconfig`에 `ty` 서버가 내장되어 있지 않더라도 로컬 설정에서 등록합니다.

## 추천 학습 순서

1) **기본 편집**: `hjkl`, `:w`, `:q`, `u`/`<C-r>`
2) **탐색**: `<leader>ff`, `<leader>fg`, `-` (oil)
3) **LSP 기능**: `gd`, `gr`, `K`, `<leader>rn`, `<leader>ca`

## 확장 가이드

언어를 추가하려면 다음 순서로 확장하면 됩니다.

1) LSP 추가: `mason-lspconfig`의 `ensure_installed`에 추가
2) 포맷터 추가: `conform`의 `formatters_by_ft`에 추가
3) Tree-sitter 파서 추가(필요 시)

예: Go 추가

- `ensure_installed`에 `gopls` 추가
- `formatters_by_ft`에 `gofmt` 추가

## 커스터마이징

- 플러그인 추가/삭제: `plugins.lua` 수정
- 옵션 변경: `init.lua` 수정
- LSP 자동 설치 목록: `mason-lspconfig`의 `ensure_installed` 수정
- Python LSP: `ty` 바이너리가 있으면 자동 활성화

첫 실행 시 `lazy.nvim`이 네트워크로 내려받아집니다.
