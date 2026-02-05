<?php
session_start();

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}

// Logout functionality
if (isset($_GET['logout'])) {
    session_destroy();
    header('Location: login.php');
    exit();
}

$full_name = $_SESSION['full_name'] ?? 'User';
$username = $_SESSION['username'] ?? '';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - GovTrackr</title>
    <link href="css/styles.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

</head>
<body>
    <header>
        <div class="logo-container">
            <div class="logo">GT</div>
            <div class="app-name">GovTrackr</div>
        </div>
        <div class="user-section">
            <div class="user-info">
                Welcome, <strong><?php echo htmlspecialchars($full_name); ?></strong>
            </div>
            <a href="?logout=1" class="logout-btn">Logout</a>
        </div>
    </header>

    <div class="dashboard-container">
        <div class="welcome-card">
            <div class="success-message">
                <svg width="24" height="24" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                </svg>
                Login Successful!
            </div>
            <h1>Welcome to GovTrackr!</h1>
            <p>Your platform for staying informed about student government candidates</p>
        </div>

        <div class="feature-grid">
            <div class="feature-card">
                <h3>🔍 Search Candidates</h3>
                <p>Easily search and filter through current running candidates to find representatives who align with your values.</p>
            </div>

            <div class="feature-card">
                <h3>👤 View Profiles</h3>
                <p>Access detailed candidate profiles including their platforms, backgrounds, and campaign promises.</p>
            </div>

            <div class="feature-card">
                <h3>📊 Track Elections</h3>
                <p>Stay updated on election schedules, voting dates, and real-time results for your student government.</p>
            </div>

            <div class="feature-card">
                <h3>💬 Engage & Connect</h3>
                <p>Connect with candidates, ask questions, and engage with your student government community.</p>
            </div>
        </div>
    </div>
</body>
</html>
