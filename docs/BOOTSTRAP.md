# 부트스트랩

`bootstrap.sh`는 **최소 설치**만 수행합니다. 설정 파일은 필요할 때만
레포를 내려받아 적용하도록 설계했습니다.

## 설계 목표

- 처음 실행을 빠르고 단순하게 (Xcode CLI, Homebrew, chezmoi만 설치)
- Git 로그인 없이 시작 가능 (curl + 아카이브 기반)
- 설정 적용을 선택형으로 분리 (원할 때만 dotfiles 적용)
- 실패 지점을 분리해 디버깅하기 쉽게

## 동작 흐름

1) Xcode CLI 도구 설치 확인  
2) Homebrew 설치  
3) chezmoi 설치  
4) dotfiles 적용 여부를 묻고, 선택 시 아카이브로 내려받아 적용

## 왜 이렇게 구성했나

- curl 한 번으로 시작하되, 모든 설정을 강제로 끌어오지 않기 위해
- Git 로그인 없이 필요한 파일만 적용하기 위해
- 부트스트랩 단계에서는 “도구 설치”만 하고, 설정은 이후에 천천히 적용하기 위해

## 트레이드오프

- Git 클론 대신 아카이브를 쓰므로 로컬에 Git 히스토리가 남지 않습니다.
- 업데이트 시에도 아카이브를 다시 내려받아야 합니다.

## 안전 가이드 (권장)

- 바로 실행하기 전에 파일을 내려받아 내용 확인을 권장합니다.

```sh
curl -fsSL https://raw.githubusercontent.com/castedice/macos-setup/main/bootstrap.sh -o /tmp/bootstrap.sh
sed -n '1,160p' /tmp/bootstrap.sh
bash /tmp/bootstrap.sh
```

## 커스터마이징 포인트

- 레포 URL: `bootstrap.sh`의 `REPO_URL`
- 아카이브 URL: `bootstrap.sh`의 `ARCHIVE_URL`
- 저장 위치: `bootstrap.sh`의 `REPO_DIR`
- Apple Silicon 체크: `uname -m` 검증 로직

## 포크 사용자 가이드

포크한 레포를 쓰려면:

- `bootstrap.sh` URL의 `castedice`를 본인 ID로 변경
- 실행 시 프롬프트에 본인 GitHub ID 입력
