# macOS 기본값

`chezmoi/run_once_set-macos.sh.tmpl`에서 기본값을 설정합니다.
개발 편의성과 예측 가능한 동작을 우선한 설정입니다.

## 적용되는 항목

- Finder: 확장자 표시, 경로/상태 막대
- Finder: 숨김 파일 표시, 폴더 우선 정렬
- Finder: 확장자 변경 경고 비활성화
- Finder: 검색 범위 기본값을 “현재 폴더”로
- Finder: 타이틀에 전체 경로 표시
- Finder: 최근 태그 숨김
- Finder: 기본 보기(리스트), 퀵룩 텍스트 선택
- 스크롤바 항상 표시
- 저장/인쇄 패널 기본 확장
- iCloud 저장 기본값 해제
- 스마트 입력(따옴표/대시/마침표/대문자) 비활성화
- 자동 텍스트 완성 비활성화
- 키 반복 속도 개선 및 길게 누르기 비활성화
- 스크린샷 저장 위치/형식 설정
- 스크린샷 그림자 비활성화
- Dock: 최근 앱 숨기기, 앱별 최소화
- Dock: 공간 자동 재배치 비활성화
- .DS_Store 생성 방지 (네트워크/USB)
- headless: 절전/스크린세이버 비활성화, Dock 자동 숨김
- desktop: 기본 절전, Dock 자동 숨김 해제
- desktop: 탭 투 클릭 활성화
- Library 폴더 표시

## 변경 방법

1) `run_once_set-macos.sh.tmpl`에서 원하는 항목 수정
2) `chezmoi apply`로 다시 적용

특정 항목을 되돌리려면 `defaults delete`로 개별 키를 삭제하세요.
