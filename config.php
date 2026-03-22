<?php
/**
 * Database Configuration File
 * GovTrackr Web Application
 
*/

// Database credentials
define('DB_HOST', getenv('MYSQLHOST') ?: 'localhost');
define('DB_USER', getenv('MYSQLUSER') ?: 'root');
define('DB_PASS', getenv('MYSQLPASSWORD') ?: '');
define('DB_NAME', getenv('MYSQLDATABASE') ?: 'govtrackr');
define('DB_PORT', getenv('MYSQLPORT') ?: 3306);

// Create database connection
function getDatabaseConnection() {
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    
    // Check connection
    if ($conn->connect_error) {
        die("Database connection failed: " . $conn->connect_error);
    }
    
    // Set charset to utf8mb4 for full Unicode support
    $conn->set_charset("utf8mb4");
    
    return $conn;
}

// Function to close database connection
function closeDatabaseConnection($conn) {
    if ($conn && !$conn->connect_error) {
        $conn->close();
    }
}
?>
