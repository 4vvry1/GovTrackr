<?php
session_start();
require_once 'config.php';
if (!isset($_SESSION['user_id'])) { header("Location: login.php"); exit(); }

$activePage = 'settings';
$pageTitle  = 'Settings';
$message    = '';
$msg_type   = '';

$user_id = $_SESSION['user_id'];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['change_password'])) {
    $current = $_POST['current_password'] ?? '';
    $new_pw  = $_POST['new_password']     ?? '';
    $confirm = $_POST['confirm_password'] ?? '';

    $user = $conn->query("SELECT password FROM users WHERE id=$user_id")->fetch_assoc();

    if (!password_verify($current, $user['password'])) {
        $message = "Current password is incorrect."; $msg_type = 'error';
    } elseif (strlen($new_pw) < 6) {
        $message = "New password must be at least 6 characters."; $msg_type = 'error';
    } elseif ($new_pw !== $confirm) {
        $message = "New passwords do not match."; $msg_type = 'error';
    } else {
        $hash = password_hash($new_pw, PASSWORD_DEFAULT);
        $conn->query("UPDATE users SET password='$hash' WHERE id=$user_id");
        $message = "Password changed successfully."; $msg_type = 'success';
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GovTrackr — Settings</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body class="dash-body">

<?php include 'includes/sidebar.php'; ?>

<div style="flex:1; display:flex; flex-direction:column;">
    <?php include 'includes/topbar.php'; ?>

    <main class="dash-content">
        <?php if ($message): ?>
        <div class="alert alert-<?= $msg_type === 'success' ? 'success' : 'error' ?>"><?= htmlspecialchars($message) ?></div>
        <?php endif; ?>

        <div class="grid-2" style="align-items:start; max-width:860px;">
            <div class="card">
                <h3 class="card-title">Change Password</h3>
                <form method="POST" action="">
                    <div class="form-group">
                        <label class="form-label">Current Password</label>
                            <input type="password" name="current_password" required placeholder="Enter current password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">New Password</label>

                            <input type="password" name="new_password" required placeholder="Min. 6 characters">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Confirm New Password</label>
                            <input type="password" name="confirm_password" required placeholder="Re-enter new password">
                        </div>
                    </div>
                    <button type="submit" name="change_password" class="btn btn-gold btn-full">Update Password</button>
                </form>
            </div>

            <div class="card">
                <h3 class="card-title">About GovTrackr</h3>
                <p style="font-size:.9rem; line-height:1.7; color:var(--muted);">
                    GovTrackr is the Official HAU COMELEC Candidate Tracking System for Holy Angel University.
                    It allows students to view candidates, explore party platforms, participate in mock elections,
                    and stay updated on election schedules.
                </p>
                <hr style="border:none; border-top:1px solid var(--border); margin:16px 0;">
                <p style="font-size:.82rem; color:var(--muted);">Version 1.0.0 · HAU COMELEC</p>
                <a href="logout.php" class="btn btn-danger btn-full" style="margin-top:14px;"
                   onclick="return confirm('Are you sure you want to log out?')">
                    Sign Out
                </a>
            </div>
        </div>
    </main>
</div>

</body>
</html>
