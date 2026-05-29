-- =============================================
-- AlgoDaily Database Schema
-- =============================================


-- ---------------------------------------------
-- 1. users
-- 회원 정보 및 게이미피케이션 데이터 저장
-- ---------------------------------------------
CREATE TABLE users (
    id SERIAL PRIMARY KEY,                    -- 유저 고유 ID
    email VARCHAR(255) UNIQUE NOT NULL,       -- 로그인 이메일
    password_hash VARCHAR(255) NOT NULL,      -- 암호화된 비밀번호
    nickname VARCHAR(50) UNIQUE NOT NULL,     -- 닉네임
    level INTEGER DEFAULT 1,                  -- 현재 레벨 (1~50)
    xp INTEGER DEFAULT 0,                     -- 누적 경험치
    coin INTEGER DEFAULT 0,                   -- 보유 코인
    current_streak INTEGER DEFAULT 0,         -- 현재 연속 학습일
    longest_streak INTEGER DEFAULT 0,         -- 최장 연속 학습일 기록
    last_active_date DATE,                    -- 마지막 학습 날짜
    email_verified BOOLEAN DEFAULT FALSE,     -- 이메일 인증 여부
    created_at TIMESTAMP DEFAULT NOW()        -- 가입 시각
);

COMMENT ON TABLE users IS '회원 정보 및 게이미피케이션 데이터';
COMMENT ON COLUMN users.email IS '로그인 이메일';
COMMENT ON COLUMN users.password_hash IS '암호화된 비밀번호';
COMMENT ON COLUMN users.nickname IS '닉네임';
COMMENT ON COLUMN users.level IS '현재 레벨 (1~50)';
COMMENT ON COLUMN users.xp IS '누적 경험치';
COMMENT ON COLUMN users.coin IS '보유 코인';
COMMENT ON COLUMN users.current_streak IS '현재 연속 학습일';
COMMENT ON COLUMN users.longest_streak IS '최장 연속 학습일 기록';
COMMENT ON COLUMN users.last_active_date IS '마지막 학습 날짜';
COMMENT ON COLUMN users.email_verified IS '이메일 인증 여부';
COMMENT ON COLUMN users.created_at IS '가입 시각';


-- ---------------------------------------------
-- 2. problems
-- 알고리즘 문제 저장
-- ---------------------------------------------
CREATE TABLE problems (
    id SERIAL PRIMARY KEY,                    -- 문제 고유 ID
    title VARCHAR(255) NOT NULL,              -- 문제 제목
    description TEXT NOT NULL,               -- 문제 설명
    difficulty VARCHAR(10) NOT NULL,          -- 난이도 (입문/초급/중급/고급)
    tags TEXT[],                              -- 개념 태그 (DP, 재귀, 해시맵 등)
    test_cases JSONB NOT NULL,               -- 공개 테스트케이스
    hidden_cases JSONB NOT NULL,             -- 히든 테스트케이스 (채점용)
    created_at TIMESTAMP DEFAULT NOW()        -- 등록 시각
);

COMMENT ON TABLE problems IS '알고리즘 문제 저장';
COMMENT ON COLUMN problems.title IS '문제 제목';
COMMENT ON COLUMN problems.description IS '문제 설명';
COMMENT ON COLUMN problems.difficulty IS '난이도 (입문/초급/중급/고급)';
COMMENT ON COLUMN problems.tags IS '개념 태그 배열 (DP, 재귀, 해시맵 등)';
COMMENT ON COLUMN problems.test_cases IS '공개 테스트케이스 (JSON)';
COMMENT ON COLUMN problems.hidden_cases IS '히든 테스트케이스, 채점용 비공개 (JSON)';
COMMENT ON COLUMN problems.created_at IS '문제 등록 시각';


-- ---------------------------------------------
-- 3. submissions
-- 유저가 문제에 제출한 코드 기록
-- ---------------------------------------------
CREATE TABLE submissions (
    id SERIAL PRIMARY KEY,                    -- 제출 고유 ID
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,       -- 제출한 유저
    problem_id INTEGER REFERENCES problems(id) ON DELETE CASCADE, -- 제출한 문제
    code TEXT NOT NULL,                       -- 제출한 코드
    language VARCHAR(20) NOT NULL,            -- 사용 언어 (Python/Java/C/C++)
    status VARCHAR(20) NOT NULL,              -- 채점 결과 (pass/fail)
    attempt_count INTEGER DEFAULT 1,          -- 시도 횟수 (최대 3회)
    hint_used BOOLEAN DEFAULT FALSE,          -- 힌트 사용 여부
    hint_level INTEGER DEFAULT 0,             -- 사용한 힌트 단계 (0=미사용, 1~3단계)
    submitted_at TIMESTAMP DEFAULT NOW()      -- 제출 시각
);

COMMENT ON TABLE submissions IS '유저가 문제에 제출한 코드 기록';
COMMENT ON COLUMN submissions.user_id IS '제출한 유저 ID';
COMMENT ON COLUMN submissions.problem_id IS '제출한 문제 ID';
COMMENT ON COLUMN submissions.code IS '제출한 코드';
COMMENT ON COLUMN submissions.language IS '사용 언어 (Python/Java/C/C++)';
COMMENT ON COLUMN submissions.status IS '채점 결과 (pass/fail)';
COMMENT ON COLUMN submissions.attempt_count IS '시도 횟수, 최대 3회';
COMMENT ON COLUMN submissions.hint_used IS '힌트 사용 여부';
COMMENT ON COLUMN submissions.hint_level IS '사용한 힌트 단계 (0=미사용, 1~3단계)';
COMMENT ON COLUMN submissions.submitted_at IS '제출 시각';


-- ---------------------------------------------
-- 4. daily_problems
-- 매일 유저에게 배정되는 문제 3개 관리
-- ---------------------------------------------
CREATE TABLE daily_problems (
    id SERIAL PRIMARY KEY,                    -- 고유 ID
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,  -- 유저
    date DATE NOT NULL,                       -- 배정 날짜
    problem_ids INTEGER[],                    -- 배정된 문제 ID 배열 (3개)
    completed_count INTEGER DEFAULT 0,        -- 완료한 문제 수 (0~3)
    created_at TIMESTAMP DEFAULT NOW()        -- 배정 시각
);

COMMENT ON TABLE daily_problems IS '매일 유저에게 배정되는 문제 3개 관리';
COMMENT ON COLUMN daily_problems.user_id IS '배정 대상 유저 ID';
COMMENT ON COLUMN daily_problems.date IS '문제 배정 날짜';
COMMENT ON COLUMN daily_problems.problem_ids IS '배정된 문제 ID 배열 (3개)';
COMMENT ON COLUMN daily_problems.completed_count IS '오늘 완료한 문제 수 (0~3)';
COMMENT ON COLUMN daily_problems.created_at IS '배정 시각';


-- ---------------------------------------------
-- 5. streak_history
-- 유저의 날짜별 학습 기록
-- ---------------------------------------------
CREATE TABLE streak_history (
    id SERIAL PRIMARY KEY,                    -- 고유 ID
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,  -- 유저
    study_date DATE NOT NULL,                 -- 학습한 날짜
    created_at TIMESTAMP DEFAULT NOW()        -- 기록 시각
);

COMMENT ON TABLE streak_history IS '유저의 날짜별 학습 기록';
COMMENT ON COLUMN streak_history.user_id IS '학습한 유저 ID';
COMMENT ON COLUMN streak_history.study_date IS '학습한 날짜';
COMMENT ON COLUMN streak_history.created_at IS '기록 생성 시각';


-- ---------------------------------------------
-- 6. badges
-- 유저가 달성한 뱃지 기록
-- ---------------------------------------------
CREATE TABLE badges (
    id SERIAL PRIMARY KEY,                    -- 고유 ID
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,  -- 유저
    badge_type VARCHAR(50) NOT NULL,          -- 뱃지 종류 (first_step, week_warrior 등)
    earned_at TIMESTAMP DEFAULT NOW()         -- 달성 시각
);

COMMENT ON TABLE badges IS '유저가 달성한 뱃지 기록';
COMMENT ON COLUMN badges.user_id IS '뱃지를 달성한 유저 ID';
COMMENT ON COLUMN badges.badge_type IS '뱃지 종류 (first_step/week_warrior/month_master 등)';
COMMENT ON COLUMN badges.earned_at IS '뱃지 달성 시각';


-- ---------------------------------------------
-- 7. friends
-- 유저 간 친구 관계 관리
-- ---------------------------------------------
CREATE TABLE friends (
    id SERIAL PRIMARY KEY,                    -- 고유 ID
    requester_id INTEGER REFERENCES users(id) ON DELETE CASCADE,  -- 친구 요청 보낸 유저
    receiver_id INTEGER REFERENCES users(id) ON DELETE CASCADE,   -- 친구 요청 받은 유저
    status VARCHAR(20) DEFAULT 'pending',     -- 상태 (pending/accepted/rejected)
    created_at TIMESTAMP DEFAULT NOW()        -- 요청 시각
);

COMMENT ON TABLE friends IS '유저 간 친구 관계 관리';
COMMENT ON COLUMN friends.requester_id IS '친구 요청을 보낸 유저 ID';
COMMENT ON COLUMN friends.receiver_id IS '친구 요청을 받은 유저 ID';
COMMENT ON COLUMN friends.status IS '친구 상태 (pending/accepted/rejected)';
COMMENT ON COLUMN friends.created_at IS '친구 요청 시각';


-- ---------------------------------------------
-- 8. shop_items
-- 꾸미기 상점 아이템 목록
-- ---------------------------------------------
CREATE TABLE shop_items (
    id SERIAL PRIMARY KEY,                    -- 아이템 고유 ID
    name VARCHAR(100) NOT NULL,              -- 아이템 이름
    type VARCHAR(20) NOT NULL,               -- 아이템 종류 (icon/theme)
    price INTEGER NOT NULL,                  -- 가격 (코인)
    image_url VARCHAR(255),                  -- 아이템 이미지 URL
    created_at TIMESTAMP DEFAULT NOW()        -- 등록 시각
);

COMMENT ON TABLE shop_items IS '꾸미기 상점 아이템 목록';
COMMENT ON COLUMN shop_items.name IS '아이템 이름';
COMMENT ON COLUMN shop_items.type IS '아이템 종류 (icon/theme)';
COMMENT ON COLUMN shop_items.price IS '구매 가격 (코인)';
COMMENT ON COLUMN shop_items.image_url IS '아이템 이미지 URL';
COMMENT ON COLUMN shop_items.created_at IS '아이템 등록 시각';


-- ---------------------------------------------
-- 9. user_items
-- 유저가 구매한 아이템 목록
-- ---------------------------------------------
CREATE TABLE user_items (
    id SERIAL PRIMARY KEY,                    -- 고유 ID
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,       -- 유저
    item_id INTEGER REFERENCES shop_items(id) ON DELETE CASCADE,  -- 구매한 아이템
    equipped BOOLEAN DEFAULT FALSE,           -- 현재 장착 여부
    purchased_at TIMESTAMP DEFAULT NOW()      -- 구매 시각
);

COMMENT ON TABLE user_items IS '유저가 구매한 아이템 목록';
COMMENT ON COLUMN user_items.user_id IS '구매한 유저 ID';
COMMENT ON COLUMN user_items.item_id IS '구매한 아이템 ID';
COMMENT ON COLUMN user_items.equipped IS '현재 장착 여부';
COMMENT ON COLUMN user_items.purchased_at IS '구매 시각';


-- ---------------------------------------------
-- 10. notifications
-- 유저 알림 기록
-- ---------------------------------------------
CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,                    -- 알림 고유 ID
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,  -- 알림 받은 유저
    type VARCHAR(50) NOT NULL,               -- 알림 종류 (poke/streak_warning/badge 등)
    message TEXT NOT NULL,                   -- 알림 내용
    is_read BOOLEAN DEFAULT FALSE,           -- 읽음 여부
    created_at TIMESTAMP DEFAULT NOW()        -- 알림 발송 시각
);

COMMENT ON TABLE notifications IS '유저 알림 기록';
COMMENT ON COLUMN notifications.user_id IS '알림을 받은 유저 ID';
COMMENT ON COLUMN notifications.type IS '알림 종류 (poke/streak_warning/badge 등)';
COMMENT ON COLUMN notifications.message IS '알림 내용';
COMMENT ON COLUMN notifications.is_read IS '읽음 여부';
COMMENT ON COLUMN notifications.created_at IS '알림 발송 시각';
