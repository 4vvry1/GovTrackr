<?php
session_start();
require_once 'config.php';
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'student') {
    header("Location: login.php"); exit();
}

$user_id    = $_SESSION['user_id'];
$activePage = 'mock-election';
$pageTitle  = 'Mock Election';
$message    = '';
$msg_type   = '';

$conn = getDatabaseConnection();

// Check if election is open
$settings = $conn->query("SELECT * FROM election_settings LIMIT 1")->fetch_assoc();
$is_open  = (bool)($settings['is_open'] ?? false);

// Check if user already voted
$already_voted = $conn->query("SELECT COUNT(*) AS n FROM votes WHERE voter_id = $user_id")->fetch_assoc()['n'] > 0;

// ── HANDLE LINEUP SAVE ──────────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_lineup'])) {
    $conn->query("DELETE FROM lineups WHERE user_id = $user_id");
    if (!empty($_POST['picks'])) {
        $ins = $conn->prepare("INSERT INTO lineups (user_id, candidate_id, position) VALUES (?,?,?)");
        foreach ($_POST['picks'] as $position => $cand_id) {
            $cand_id  = (int)$cand_id;
            $position = $conn->real_escape_string($position);
            // Validate candidate belongs to position
            $chk = $conn->query("SELECT id FROM candidates WHERE id=$cand_id AND position='$position'");
            if ($chk->num_rows > 0) {
                $ins->bind_param("iis", $user_id, $cand_id, $position);
                $ins->execute();
            }
        }
        $ins->close();
        $message  = "Lineup saved! Review your choices below before casting your vote.";
        $msg_type = 'success';
    }
}

// ── HANDLE FINAL VOTE CAST ─────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['cast_vote']) && $is_open && !$already_voted) {
    // Load saved lineup
    $lineup = $conn->query("SELECT candidate_id, position FROM lineups WHERE user_id = $user_id");
    if ($lineup->num_rows === 0) {
        $message  = "Please save your lineup first before casting your vote.";
        $msg_type = 'error';
    } else {
        $ins = $conn->prepare("INSERT IGNORE INTO votes (voter_id, candidate_id, position) VALUES (?,?,?)");
        while ($lrow = $lineup->fetch_assoc()) {
            $ins->bind_param("iis", $user_id, $lrow['candidate_id'], $lrow['position']);
            $ins->execute();
        }
        $ins->close();
        $already_voted = true;
        $message  = "Your vote has been cast! Thank you for participating.";
        $msg_type = 'success';
    }
}

// ── LOAD POSITIONS & CANDIDATES ────────────────────────────
$positions_res = $conn->query("SELECT DISTINCT position FROM candidates ORDER BY FIELD(position,'President','Vice President') DESC, position");
$positions_list = [];
while ($r = $positions_res->fetch_assoc()) { $positions_list[] = $r['position']; }

// Load user's saved lineup
$saved_lineup = [];
$sl = $conn->query("SELECT candidate_id, position FROM lineups WHERE user_id = $user_id");
while ($r = $sl->fetch_assoc()) { $saved_lineup[$r['position']] = (int)$r['candidate_id']; }

// Load votes cast (for confirmation screen)
$cast_votes = [];
if ($already_voted) {
    $cv = $conn->query("
        SELECT v.position, c.full_name, c.photo, p.name AS partylist
        FROM   votes v
        JOIN   candidates c ON v.candidate_id = c.id
        LEFT JOIN partylists p ON c.partylist_id = p.id
        WHERE  v.voter_id = $user_id
    ");
    while ($r = $cv->fetch_assoc()) { $cast_votes[$r['position']] = $r; }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GovTrackr — Mock Election</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body class="dash-body">

<?php include 'includes/sidebar.php'; ?>

<div style="flex:1; display:flex; flex-direction:column;">
    <?php include 'includes/topbar.php'; ?>

    <main class="dash-content">

        <?php if ($message): ?>
        <div class="alert alert-<?= $msg_type === 'success' ? 'success' : 'error' ?>"><?= $message ?></div>
        <?php endif; ?>

        <!-- Election status banner -->
        <?php if (!$is_open): ?>
        <div class="card card-gold" style="text-align:center; padding:28px;">
            <h2 style="color:var(--purple-dark); margin:8px 0 6px;">Election is Currently Closed</h2>
            <p style="color:#856404; font-size:.92rem;">
                The mock election is not open yet. You can still build your lineup and it will be ready when voting opens.
            </p>
            <?php if ($settings['start_date']): ?>
            <p style="margin-top:10px; font-weight:700; color:var(--purple-dark);">
                Opens: <?= date('F j, Y · g:i A', strtotime($settings['start_date'])) ?>
            </p>
            <?php endif; ?>
        </div>
        <?php endif; ?>

        <?php if ($already_voted): ?>
        <!-- ── CONFIRMATION SCREEN ── -->
        <div class="card" style="text-align:center; padding:32px;">
            <h2 style="color:var(--purple-dark); margin:10px 0 6px;">You Have Already Voted!</h2>
            <p style="color:var(--muted);">Here are the candidates you voted for.</p>
        </div>
        <div class="grid-2">
            <?php foreach ($cast_votes as $pos => $cv): ?>
            <div class="card" style="display:flex; align-items:center; gap:16px;">
                <?php if ($cv['photo']): ?>
                    <img src="<?= htmlspecialchars($cv['photo']) ?>" style="width:56px;height:56px;border-radius:50%;object-fit:cover;border:3px solid var(--gold);">
                <?php else: ?>
                    <div style="width:56px;height:56px;border-radius:50%;background:var(--purple-soft);display:flex;align-items:center;justify-content:center;font-size:1.6rem;border:3px solid var(--gold);">👤</div>
                <?php endif; ?>
                <div>
                    <p style="font-size:.75rem;font-weight:700;text-transform:uppercase;letter-spacing:.06em;color:var(--muted);"><?= htmlspecialchars($pos) ?></p>
                    <p style="font-weight:700;"><?= htmlspecialchars($cv['full_name']) ?></p>
                    <?php if ($cv['partylist']): ?>
                    <span class="party-badge"><?= htmlspecialchars($cv['partylist']) ?></span>
                    <?php endif; ?>
                </div>
            </div>
            <?php endforeach; ?>
        </div>

        <?php else: ?>
        <!-- ── LINEUP + VOTING FORM ── -->
        <form method="POST" action="">
            <?php foreach ($positions_list as $pos): ?>
            <?php
            $cands_for_pos = $conn->query("
                SELECT c.id, c.full_name, c.photo, p.name AS partylist
                FROM   candidates c
                LEFT JOIN partylists p ON c.partylist_id = p.id
                WHERE  c.position = '" . $conn->real_escape_string($pos) . "'
                ORDER BY c.full_name
            ");
            $saved_pick = $saved_lineup[$pos] ?? 0;
            ?>
            <div class="position-section">
                <div class="position-label"><?= htmlspecialchars($pos) ?></div>
                <?php while ($cand = $cands_for_pos->fetch_assoc()): ?>
                <label>
                    <div class="vote-candidate-card <?= $saved_pick === (int)$cand['id'] ? 'picked' : '' ?>" id="vc-<?= $pos ?>-<?= $cand['id'] ?>">
                        <?php if ($cand['photo']): ?>
                            <img src="<?= htmlspecialchars($cand['photo']) ?>" alt="" class="vc-photo">
                        <?php else: ?>
                            <div class="vc-photo">👤</div>
                        <?php endif; ?>
                        <div>
                            <div class="vc-name"><?= htmlspecialchars($cand['full_name']) ?></div>
                            <?php if ($cand['partylist']): ?>
                            <div class="vc-party"><?= htmlspecialchars($cand['partylist']) ?></div>
                            <?php endif; ?>
                        </div>
                        <div class="vc-pick-dot"></div>
                        <input type="radio" name="picks[<?= htmlspecialchars($pos) ?>]"
                               value="<?= $cand['id'] ?>"
                               style="display:none"
                               <?= $saved_pick === (int)$cand['id'] ? 'checked' : '' ?>>
                    </div>
                </label>
                <?php endwhile; ?>
            </div>
            <?php endforeach; ?>

            <div style="display:flex; gap:14px; flex-wrap:wrap; margin-top:8px;">
                <button type="submit" name="save_lineup" class="btn btn-purple">
                    Save Lineup
                </button>
                <?php if ($is_open): ?>
                <button type="submit" name="cast_vote"
                        class="btn btn-gold"
                        onclick="return confirm('Are you sure? This cannot be undone!')">
                    Cast My Vote
                </button>
                <?php endif; ?>
            </div>
        </form>
        <?php endif; ?>

    </main>
</div>

<script>
// Highlight picked radio on click
document.querySelectorAll('.vote-candidate-card').forEach(card => {
    card.addEventListener('click', () => {
        const radio = card.querySelector('input[type=radio]');
        const name  = radio.name;
        // Remove picked from siblings
        document.querySelectorAll(`input[name="${name}"]`).forEach(r => {
            r.closest('.vote-candidate-card').classList.remove('picked');
        });
        card.classList.add('picked');
    });
});
</script>
</body>
</html>
