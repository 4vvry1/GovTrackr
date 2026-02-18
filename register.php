<?php
session_start();
require_once 'config.php';

$conn = getDatabaseConnection();

if (isset($_SESSION['user_id'])) {
    header("Location: dashboard.php"); exit();
}

$error = $success = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $sn    = trim($_POST['student_number'] ?? '');
    $fname = trim($_POST['first_name']     ?? '');
    $lname = trim($_POST['last_name']      ?? '');
    $pw    = $_POST['password']            ?? '';
    $cpw   = $_POST['confirm_password']    ?? '';

    if (!$sn || !$fname || !$lname || !$pw || !$cpw) {
        $error = "Please fill in all fields.";
    } elseif (strlen($pw) < 6) {
        $error = "Password must be at least 6 characters.";
    } elseif ($pw !== $cpw) {
        $error = "Passwords do not match.";
    } else {
        // Check for duplicate student number
        $chk = $conn->prepare("SELECT id FROM users WHERE student_number = ?");
        $chk->bind_param("s", $sn);
        $chk->execute();
        $chk->store_result();

        if ($chk->num_rows > 0) {
            $error = "Student number already registered.";
        } else {
            $hash = password_hash($pw, PASSWORD_DEFAULT);
            $ins  = $conn->prepare("INSERT INTO users (student_number, first_name, last_name, password, role) VALUES (?,?,?,?,'student')");
            $ins->bind_param("ssss", $sn, $fname, $lname, $hash);
            if ($ins->execute()) {
                $success = "Account created! You can now sign in.";
            } else {
                $error = "Something went wrong. Please try again.";
            }
            $ins->close();
        }
        $chk->close();
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GovTrackr — Register</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body class="auth-body auth-page">

<div class="auth-card">
    <div class="auth-left">
        <h1>Welcome to<br><span class="brand-gov">Gov</span><span style="color:#fff">Trackr</span></h1>
        <p>Official HAU COMELEC Candidate Tracking System.</p>
        <ul class="auth-features">
            <li>Mock Election</li>
            <li>Real-time Results</li>
            <li>Election Calendar</li>
            <li>Candidate Profiles</li>
        </ul>
    </div>

    <div class="auth-right">
        <h2>Create Account</h2>
        <p class="sub">Fill in your information below</p>

        <?php if ($error):   ?><div class="alert alert-error"><?=   htmlspecialchars($error)   ?></div><?php endif; ?>
        <?php if ($success): ?><div class="alert alert-success"><?= htmlspecialchars($success) ?></div><?php endif; ?>

        <?php if (!$success): ?>
        <form method="POST" action="">
            <div class="input-row">
                <div class="form-group">
                    <label class="form-label">First Name</label>
                    <div class="input-wrap">
                        <input type="text" name="first_name" placeholder="First Name"
                               value="<?= htmlspecialchars($_POST['first_name'] ?? '') ?>" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Last Name</label>
                    <div class="input-wrap">
                        <input type="text" name="last_name" placeholder="Last Name"
                               value="<?= htmlspecialchars($_POST['last_name'] ?? '') ?>" required>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Student Number</label>
                <div class="input-wrap">
                    <input type="text" name="student_number" placeholder="e.g. 2024-00001"
                           value="<?= htmlspecialchars($_POST['student_number'] ?? '') ?>" required>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Password</label>
                <div class="input-wrap">
                    <input type="password" name="password" placeholder="Min. 6 characters" required>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Confirm Password</label>
                <div class="input-wrap">
                    <input type="password" name="confirm_password" placeholder="Re-enter password" required>
                </div>
            </div>
            <button type="submit" class="btn btn-gold btn-full">Sign Up</button>
        </form>
        <?php else: ?>
            <a href="login.php" class="btn btn-purple btn-full" style="margin-top:10px">Go to Sign In →</a>
        <?php endif; ?>

        <p class="auth-link">Already have an account? <a href="login.php">Sign In</a></p>
    </div>
</div>

</body>
</html>
