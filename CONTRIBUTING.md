# AlgoDaily 개발 규칙

## 브랜치 전략

```
main        배포용 (직접 커밋 금지)
dev         개발 통합 브랜치
feat/xxx    기능 개발 브랜치 (dev에서 분기)
fix/xxx     버그 수정 브랜치 (dev에서 분기)
chore/xxx   설정, 패키지 등 기능 외 작업
refactor/xxx 코드 구조 개선 (기능 변화 없음)
```

### 작업 흐름

```
dev에서 기능 브랜치 생성
    ↓
작업 완료 후 feat/xxx → dev로 PR
    ↓
배포할 때만 dev → main으로 PR
```

```bash
# 기능 개발 시작할 때
git checkout dev
git checkout -b feat/login

# 작업 완료 후
git add .
git commit -m "feat: 로그인 기능 추가"
git push origin feat/login

# GitHub에서 feat/login → dev 로 PR 생성
```

---

## 브랜치 이름 규칙

브랜치 하나 = 독립적으로 PR 올릴 수 있는 기능 단위

| 브랜치 | 작업 범위 |
|---|---|
| `feat/signup` | 회원가입 API + UI |
| `feat/login` | 로그인 API + UI + JWT 저장 |
| `feat/email-verify` | 인증 메일 발송 + 토큰 검증 |
| `feat/password-reset` | 비밀번호 찾기 + 재설정 |
| `feat/onboarding` | 수준 선택 + 레벨 테스트 5문제 |
| `feat/dashboard-layout` | 대시보드 뼈대 UI |
| `feat/daily-problems` | 오늘 문제 배정 로직 |
| `feat/streak-calendar` | 스트릭 + 7일 달력 |
| `feat/xp-bar` | 경험치 바 + 레벨 표시 |
| `feat/code-editor` | Monaco 에디터 + 언어 선택 |
| `feat/judge0-submit` | Judge0 연동 + 채점 |
| `feat/hint-system` | 힌트 단계 + 코인 차감 |
| `feat/claude-explain` | Claude API 해설 화면 |
| `feat/reward-system` | 코인 + XP 지급 로직 |
| `feat/badge-system` | 뱃지 조건 + 달성 모달 |
| `feat/levelup-modal` | 레벨업 모달 + 애니메이션 |
| `feat/mypage` | 마이페이지 뼈대 + 프로필 |
| `feat/wrong-note` | 오답 노트 + 복습 노트 |
| `feat/history` | 풀이 히스토리 |
| `feat/shop` | 꾸미기 상점 |
| `feat/friends` | 친구 목록 + 찌르기 |
| `feat/ranking` | 친구 랭킹보드 |

---

## 커밋 메시지 규칙

```
feat: 회원가입 API 추가
fix: 이메일 인증 토큰 만료 오류 수정
chore: dotenv 패키지 설치
refactor: JWT 미들웨어 분리
style: 로그인 버튼 색상 수정
```

| 타입 | 사용 상황 |
|---|---|
| `feat` | 새 기능 추가 |
| `fix` | 버그 수정 |
| `chore` | 패키지 설치, 설정 변경 등 |
| `refactor` | 기능 변화 없는 코드 구조 개선 |
| `style` | UI 스타일 수정 |

---

## PR 규칙

- 제목: 커밋 메시지와 동일한 형식 (`feat: 로그인 기능`)
- 대상 브랜치: 반드시 `dev` (main 직접 PR 금지)
- 하나의 PR = 하나의 기능 브랜치
