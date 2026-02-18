<?php
require_once 'auth_guard.php';
$activePage = 'users';
$users = $conn->query("
    SELECT u.*, (SELECT COUNT(*) FROM votes WHERE voter_id=u.id) AS vote_count
    FROM   users u
    WHERE  u.role = 'student'
    ORDER BY u.created_at DESC
");
?>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>GovTrackr — Students</title><link rel="stylesheet" href="../css/styles.css"></head>
<body class="dash-body">
<?php include 'sidebar.php'; ?>
<div style="flex:1;display:flex;flex-direction:column;">
<header class="topbar">
    <div class="topbar-left"><p class="topbar-welcome">Admin Panel</p><h1 class="topbar-title">Registered Students</h1></div>
</header>
<main class="dash-content">
    <div class="card">
        <div style="overflow-x:auto;">
            <table class="data-table">
                <thead><tr><th>#</th><th>Name</th><th>Student Number</th><th>Registered</th><th>Voted?</th></tr></thead>
                <tbody>
                    <?php $i=1; while ($u = $users->fetch_assoc()): ?>
                    <tr>
                        <td><?= $i++ ?></td>
                        <td><strong><?= htmlspecialchars($u['first_name'].' '.$u['last_name']) ?></strong></td>
                        <td><?= htmlspecialchars($u['student_number']) ?></td>
                        <td><?= date('M j, Y', strtotime($u['created_at'])) ?></td>
                        <td>
                            <span class="badge <?= $u['vote_count'] > 0 ? 'badge-green' : 'badge-red' ?>">
                                <?= $u['vote_count'] > 0 ? 'Yes' : 'Not yet' ?>
                            </span>
                        </td>
                    </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
    </div>
</main>
</div>
</body>
</html>
