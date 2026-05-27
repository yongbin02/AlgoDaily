# 🧠 AlgoDaily

> AI 기반 알고리즘 학습 플랫폼 — 매일 3문제, 내 수준에 맞게, 듀오링고처럼.

[![React](https://img.shields.io/badge/React-18-61DAFB?logo=react)](https://react.dev/)
[![Node.js](https://img.shields.io/badge/Node.js-Express-339933?logo=node.js)](https://nodejs.org/)
[![Claude API](https://img.shields.io/badge/Claude-API-orange)](https://www.anthropic.com/)
[![Judge0](https://img.shields.io/badge/Judge0-Code%20Execution-blue)](https://judge0.com/)

---

## 📌 프로젝트 소개

AI 개발 도구의 발전으로 알고리즘이나 자료구조 같은 CS 기초 없이 코드를 작성하는 개발자가 늘어나고 있습니다.

**AlgoDaily**는 이 문제를 해결하기 위해 만든 AI 기반 알고리즘 학습 플랫폼입니다.

- 초기 레벨 테스트로 사용자 수준을 분석하고
- 매일 수준에 맞는 문제 3개를 배정하며
- 제출한 코드를 기반으로 AI가 맞춤 해설을 제공합니다
- 듀오링고처럼 스트릭과 경험치로 꾸준한 학습을 유도합니다

---

## ✨ 주요 기능

| 기능 | 설명 |
|------|------|
| 🎯 레벨 테스트 | 5문제로 초급 / 중급 / 고급 수준 자동 분류 |
| 📅 일일 문제 배정 | 매일 난이도 맞춤 문제 3개 자동 배정 |
| 💻 코드 에디터 | 브라우저에서 바로 코드 작성 및 실행 |
| 🤖 AI 해설 | 내 코드 기반으로 Claude API가 맞춤 피드백 제공 |
| 🔥 스트릭 시스템 | 연속 학습일 추적 및 경험치 / 레벨업 보상 |
| 📊 취약점 분석 | 개념 태그별 정답률로 약점 시각화 |

---

## 🛠 기술 스택

### Frontend
- React 18
- TailwindCSS
- Monaco Editor (코드 에디터)

### Backend
- Node.js + Express
- PostgreSQL
- JWT 인증

### AI / 외부 API
- Claude API (AI 코드 해설)
- Judge0 API (코드 실행 및 채점)

### 배포
- Vercel (Frontend)
- Render (Backend)

---

## 🗺 서비스 플로우

```
회원가입 / 로그인
    ↓
레벨 테스트 (5문제) → 수준 분석
    ↓
메인 대시보드 — 오늘의 문제 3개
    ↓
풀이 화면 — 코드 작성 → 실행 → 제출
    ↓
AI 해설 — 내 코드 기반 맞춤 피드백
    ↓
보상 — 스트릭 +1, 경험치 획득, 레벨업
```

---

## 📁 프로젝트 구조

```
AlgoDaily/
├── client/                  # React 프론트엔드
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   └── api/
│   └── package.json
├── server/                  # Node.js 백엔드
│   ├── routes/
│   ├── controllers/
│   ├── models/
│   └── package.json
├── .gitignore
└── README.md
```

---

## 🚀 로컬 실행 방법

```bash
# 레포 클론
git clone https://github.com/{username}/AlgoDaily.git
cd AlgoDaily

# 백엔드 실행
cd server
npm install
npm run dev

# 프론트엔드 실행
cd ../client
npm install
npm run dev
```

### 환경변수 설정

`server/.env`
```
DATABASE_URL=your_postgresql_url
JWT_SECRET=your_jwt_secret
ANTHROPIC_API_KEY=your_claude_api_key
JUDGE0_API_KEY=your_judge0_api_key
```

---

## 👤 개발자

| 이름 | 역할 | GitHub                                  |
|------|------|-----------------------------------------|
| Kozel | Full Stack / AI | yongbin02(https://github.com/yongbin02) |

---

## 📄 라이선스

MIT License
