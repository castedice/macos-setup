# 부트스트랩

`bootstrap.sh`는 **최소 설치**만 수행합니다. 설정 파일은 필요할 때만
레포를 내려받아 적용하도록 설계했습니다.

## 동작 흐름

1) Xcode CLI 도구 설치 확인  
2) Homebrew 설치  
3) chezmoi 설치  
4) dotfiles 적용 여부를 묻고, 선택 시 아카이브로 내려받아 적용

## 왜 이렇게 구성했나

- curl 한 번으로 시작하되, 모든 설정을 강제로 끌어오지 않기 위해
- Git 로그인 없이 필요한 파일만 적용하기 위해
 - 레포 전체를 저장하지 않고 `chezmoi/`만 보관하기 위해

## 커스터마이징 포인트

- 레포 URL: `bootstrap.sh`의 `REPO_URL`
- 아카이브 URL: `bootstrap.sh`의 `ARCHIVE_URL`
- 저장 위치: `bootstrap.sh`의 `REPO_DIR`
- Apple Silicon 체크: `uname -m` 검증 로직

## 포크 사용자 가이드

포크한 레포를 쓰려면:

- `bootstrap.sh` URL의 `castedice`를 본인 ID로 변경
- 실행 시 프롬프트에 본인 GitHub ID 입력
