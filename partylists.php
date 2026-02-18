<?php
session_start();
require_once 'config.php';
if (!isset($_SESSION['user_id'])) { header("Location: login.php"); exit(); }

$activePage = 'partylists';
$pageTitle  = 'Partylists';

$partylists = $conn->query("SELECT * FROM partylists ORDER BY name");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GovTrackr — Partylists</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body class="dash-body">

<?php include 'includes/sidebar.php'; ?>

<div style="flex:1; display:flex; flex-direction:column;">
    <?php include 'includes/topbar.php'; ?>

    <main class="dash-content">
        <div class="grid-2">
        <?php while ($pl = $partylists->fetch_assoc()): ?>
        <?php
        // Get members for this partylist
        $members = $conn->query("
            SELECT id, full_name, position, photo
            FROM   candidates
            WHERE  partylist_id = {$pl['id']}
            ORDER BY position, full_name
        ");
        $member_count = $members->num_rows;
        ?>
        <div class="partylist-card">
            <div class="pl-header">
                <?php if ($pl['logo']): ?>
                    <img src="<?= htmlspecialchars($pl['logo']) ?>" alt="" class="pl-logo">
                <?php else: ?>
                <?php endif; ?>
                <div>
                    <div class="pl-name"><?= htmlspecialchars($pl['name']) ?></div>
                    <?php if ($pl['description']): ?>
                    <div class="pl-desc"><?= htmlspecialchars($pl['description']) ?></div>
                    <?php endif; ?>
                </div>
            </div>
            <div class="pl-body">
                <p class="pl-members-count">👥 <?= $member_count ?> candidate<?= $member_count !== 1 ? 's' : '' ?></p>

                <?php if ($member_count > 0): ?>
                <div style="display:flex; flex-wrap:wrap; gap:12px;">
                    <?php while ($m = $members->fetch_assoc()): ?>
                    <a href="candidates.php?id=<?= $m['id'] ?>" class="mini-cand">
                        <?php if ($m['photo']): ?>
                            <img src="<?= htmlspecialchars($m['photo']) ?>" alt="" class="mc-photo">
                        <?php else: ?>
                            <div class="mc-photo">👤</div>
                        <?php endif; ?>
                        <span class="mc-name"><?= htmlspecialchars($m['full_name']) ?></span>
                    </a>
                    <?php endwhile; ?>
                </div>
                <?php else: ?>
                    <p style="color:var(--muted); font-size:.88rem;">No candidates yet.</p>
                <?php endif; ?>
            </div>
        </div>
        <?php endwhile; ?>
        </div>
    </main>
</div>

</body>
</html>
