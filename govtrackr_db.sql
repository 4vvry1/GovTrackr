-- GovTrackr Database Setup
-- This file creates the necessary database and tables for the GovTrackr application

-- Create database
CREATE DATABASE IF NOT EXISTS govtrackr;
USE govtrackr;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('admin', 'student', 'candidate') DEFAULT 'student',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create candidates table (for future use)
CREATE TABLE IF NOT EXISTS candidates (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    user_id INT(11) NOT NULL,
    position VARCHAR(100) NOT NULL,
    platform TEXT,
    image_url VARCHAR(255),
    status ENUM('running', 'elected', 'withdrawn') DEFAULT 'running',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- NOTE: User accounts are created using the setup_users.php script
-- This ensures password hashes are generated correctly using PHP's password_hash() function
-- 
-- To create users, run: http://localhost/govtrackr/setup_users.php
-- 
-- Default credentials after running setup_users.php:
-- Admin: username = admin, password = admin123
-- Student: username = student, password = student123
