<?php
require_once 'auth_guard.php';
$activePage = 'election';
$message = ''; $msg_type = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['toggle_election'])) {
        $new_state = (int)$_POST['new_state'];
        $conn->query("UPDATE election_settings SET is_open=$new_state WHERE id=1");
        $message  = $new_state ? "Mock Election is now OPEN." : "Mock Election is now CLOSED.";
        $msg_type = 'success';
    }
    if (isset($_POST['update_settings'])) {
        $name  = $conn->real_escape_string(trim($_POST['election_name'] ?? 'HAULALAN 2026'));
        $start = $_POST['start_date'] ?? null;
        $end   = $_POST['end_date']   ?? null;
        $conn->query("UPDATE election_settings SET election_name='$name', start_date=" . ($start ? "'$start'" : "NULL") . ", end_date=" . ($end ? "'$end'" : "NULL") . " WHERE id=1");
        $message = "Settings updated."; $msg_type = 'success';
    }
    if (isset($_POST['reset_votes'])) {
        $conn->query("DELETE FROM votes");
        $conn->query("DELETE FROM lineups");
        $message = "All votes and lineups have been reset."; $msg_type = 'success';
    }
}

$settings = $conn->query("SELECT * FROM election_settings LIMIT 1")->fetch_assoc();
$vote_count = $conn->query("SELECT COUNT(*) AS n FROM votes")->fetch_assoc()['n'];
$voter_count = $conn->query("SELECT COUNT(DISTINCT voter_id) AS n FROM votes")->fetch_assoc()['n'];

// Results by position
$results = $conn->query("
    SELECT c.full_name, c.position, p.name AS partylist, COUNT(v.id) AS vote_count
    FROM   candidates c
    LEFT JOIN votes v ON v.candidate_id = c.id
    LEFT JOIN partylists p ON c.partylist_id = p.id
    GROUP BY c.id
    ORDER BY c.position, vote_count DESC
");
$results_by_pos = [];
while ($r = $results->fetch_assoc()) { $results_by_pos[$r['position']][] = $r; }
?>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>GovTrackr — Election Control</title><link rel="stylesheet" href="../css/styles.css"></head>
<body class="dash-body">
<?php include 'sidebar.php'; ?>
<div style="flex:1;display:flex;flex-direction:column;">
<header class="topbar">
    <div class="topbar-left"><p class="topbar-welcome">Admin Panel</p><h1 class="topbar-title">Election Control</h1></div>
</header>
<main class="dash-content">
    <?php if ($message): ?><div class="alert alert-<?= $msg_type === 'success' ? 'success' : 'error' ?>"><?= htmlspecialchars($message) ?></div><?php endif; ?>

    <div class="grid-2" style="align-items:start;">
        <!-- Toggle + Settings -->
        <div style="display:flex;flex-direction:column;gap:16px;">

            <!-- Open/Close toggle -->
            <div class="card" style="text-align:center;padding:32px;">
                <p style="font-size:3rem; margin-bottom:8px;"><?= $settings['is_open'] ? '🟢' : '🔴' ?></p>
                <h2 style="color:var(--purple-dark);margin-bottom:6px;">
                    Mock Election is <?= $settings['is_open'] ? 'OPEN' : 'CLOSED' ?>
                </h2>
                <p style="color:var(--muted);font-size:.88rem;margin-bottom:20px;">
                    <?= $settings['is_open'] ? 'Students can currently cast their votes.' : 'Voting is not available to students right now.' ?>
                </p>
                <form method="POST" action="">
                    <input type="hidden" name="new_state" value="<?= $settings['is_open'] ? '0' : '1' ?>">
                    <button type="submit" name="toggle_election"
                            class="btn <?= $settings['is_open'] ? 'btn-danger' : 'btn-success' ?> btn-full"
                            onclick="return confirm('<?= $settings['is_open'] ? 'Close' : 'Open' ?> the mock election?')">
                        <?= $settings['is_open'] ? 'Close Election' : 'Open Election' ?>
                    </button>
                </form>
            </div>

            <!-- Settings -->
            <div class="card">
                <h3 class="card-title">Election Settings</h3>
                <form method="POST" action="">
                    <div class="form-group">
                        <label class="form-label">Election Name</label>
                        <div class="input-wrap"><input type="text" name="election_name" value="<?= htmlspecialchars($settings['election_name']) ?>"></div>
                    </div>
                    <div class="input-row">
                        <div class="form-group">
                            <label class="form-label">Start Date & Time</label>
                            <div class="input-wrap"><input type="datetime-local" name="start_date" value="<?= $settings['start_date'] ? str_replace(' ','T',$settings['start_date']) : '' ?>"></div>
                        </div>
                        <div class="form-group">
                            <label class="form-label">End Date & Time</label>
                            <div class="input-wrap"><input type="datetime-local" name="end_date" value="<?= $settings['end_date'] ? str_replace(' ','T',$settings['end_date']) : '' ?>"></div>
                        </div>
                    </div>
                    <button type="submit" name="update_settings" class="btn btn-purple">Save Settings</button>
                </form>
            </div>

            <!-- Stats + Reset -->
            <div class="card card-dark">
                <h3 class="card-title">Vote Summary</h3>
                <p style="opacity:.8;font-size:.9rem;">Total votes cast: <strong style="color:var(--gold);"><?= $vote_count ?></strong></p>
                <p style="opacity:.8;font-size:.9rem;margin-top:6px;">Students who voted: <strong style="color:var(--gold);"><?= $voter_count ?></strong></p>
                <form method="POST" style="margin-top:18px;" onsubmit="return confirm('This will DELETE all votes and lineups. This CANNOT be undone. Are you sure?')">
                    <button type="submit" name="reset_votes" class="btn btn-danger btn-full">Reset All Votes</button>
                </form>
            </div>
        </div>

        <!-- Live results -->
        <div class="card">
            <h3 class="card-title">Live Results</h3>
            <?php foreach ($results_by_pos as $pos => $candidates): ?>
            <div class="position-section" style="margin-bottom:20px;">
                <div class="position-label"><?= htmlspecialchars($pos) ?></div>
                <?php foreach ($candidates as $i => $c): ?>
                <?php $max = $candidates[0]['vote_count'] ?: 1; ?>
                <div style="display:flex;align-items:center;gap:12px;margin-bottom:8px;">
                    <div style="width:32px;text-align:center;font-weight:700;color:<?= $i === 0 ? 'var(--gold-dark)' : 'var(--muted)' ?>">
                        <?= $i === 0 ? '1.' : ($i + 1) . '.' ?>
                    </div>
                    <div style="flex:1;">
                        <div style="font-size:.88rem;font-weight:600;"><?= htmlspecialchars($c['full_name']) ?></div>
                        <div style="font-size:.75rem;color:var(--muted);"><?= htmlspecialchars($c['partylist'] ?? 'Independent') ?></div>
                        <div style="background:var(--border);border-radius:30px;height:8px;margin-top:4px;overflow:hidden;">
                            <div style="background:<?= $i === 0 ? 'var(--gold)' : 'var(--purple-light)' ?>;height:100%;width:<?= $max > 0 ? round($c['vote_count']/$max*100) : 0 ?>%;border-radius:30px;transition:width .5s;"></div>
                        </div>
                    </div>
                    <div style="font-weight:700;color:var(--purple-dark);min-width:28px;text-align:right;"><?= $c['vote_count'] ?></div>
                </div>
                <?php endforeach; ?>
            </div>
            <?php endforeach; ?>
        </div>
    </div>

</main>
</div>
</body>
</html>
