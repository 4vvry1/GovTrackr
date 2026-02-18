-- ============================================================
--  Holy Angel University COMELEC
-- ============================================================

CREATE DATABASE IF NOT EXISTS govtrackr
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE govtrackr;

-- ── 1. USERS ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
    id          INT          AUTO_INCREMENT PRIMARY KEY,
    student_number VARCHAR(20)  NOT NULL UNIQUE,
    first_name     VARCHAR(80)  NOT NULL,
    last_name      VARCHAR(80)  NOT NULL,
    password       VARCHAR(255) NOT NULL,          
    role           ENUM('student','admin') DEFAULT 'student',
    profile_pic    VARCHAR(255) DEFAULT NULL,
    created_at     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ── 2. PARTYLISTS ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS partylists (
    id          INT          AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(120) NOT NULL,
    description TEXT,
    logo        VARCHAR(255) DEFAULT NULL,
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- ── 3. CANDIDATES ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS candidates (
    id           INT          AUTO_INCREMENT PRIMARY KEY,
    full_name    VARCHAR(150) NOT NULL,
    position     VARCHAR(100) NOT NULL,             
    partylist_id INT          DEFAULT NULL,
    photo        VARCHAR(255) DEFAULT NULL,
    bio          TEXT,
    platform     TEXT,                             
    year_level   VARCHAR(20)  DEFAULT NULL,
    course       VARCHAR(100) DEFAULT NULL,
    created_at   TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (partylist_id) REFERENCES partylists(id) ON DELETE SET NULL
);

-- ── 4. EVENTS / ELECTION CALENDAR ─────────────────────────
CREATE TABLE IF NOT EXISTS events (
    id          INT          AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    description TEXT,
    event_date  DATE         NOT NULL,
    event_time  TIME         DEFAULT NULL,
    location    VARCHAR(200) DEFAULT NULL,
    created_by  INT          DEFAULT NULL,
    created_at  TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ── 5. LINEUPS ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS lineups (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT NOT NULL,
    candidate_id INT NOT NULL,
    position     VARCHAR(100) NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY one_pick_per_position (user_id, position),
    FOREIGN KEY (user_id)      REFERENCES users(id)      ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE
);

-- ── 6. MOCK ELECTION VOTES ─────────────────────────────────
CREATE TABLE IF NOT EXISTS votes (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    voter_id     INT NOT NULL,
    candidate_id INT NOT NULL,
    position     VARCHAR(100) NOT NULL,
    voted_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY one_vote_per_position (voter_id, position),
    FOREIGN KEY (voter_id)     REFERENCES users(id)      ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE
);
-- ── 7. ELECTION SETTINGS ───────────────────────────────────
CREATE TABLE IF NOT EXISTS election_settings (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    election_name VARCHAR(200) DEFAULT 'HAULALAN 2026',
    is_open       TINYINT(1)   DEFAULT 0,            
    start_date    DATETIME     DEFAULT NULL,
    end_date      DATETIME     DEFAULT NULL,
    updated_at    TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO users (student_number, first_name, last_name, password, role)
VALUES ('00000000', 'HAU', 'COMELEC',
        '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');
        -- !! Change hash above before going live !!

INSERT INTO events (title, description, event_date, event_time, location) VALUES
    ('Filing of COC',              'Deadline for filing Certificates of Candidacy', '2026-02-20', '08:00:00', 'COMELEC Office, Admin Building'),
    ('Campaign Period Starts',     'Official start of the campaign period',          '2026-02-25', '06:00:00', 'All Campus Areas'),
    ('Candidates'' Forum',         'Open forum with all official candidates',        '2026-03-02', '13:00:00', 'HAU Gym'),
    ('Mock Election Day',          'Cast your votes at your assigned precinct',      '2026-03-05', '07:00:00', 'Precincts per College'),
    ('Proclamation of Winners',    'Official proclamation of elected officers',      '2026-03-07', '15:00:00', 'HAU Covered Court');

INSERT INTO election_settings (election_name, is_open, start_date, end_date) VALUES
    ('HAULALAN 2026', 0, '2026-03-05 07:00:00', '2026-03-05 17:00:00');
