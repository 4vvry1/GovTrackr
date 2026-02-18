<?php
session_start();
require_once 'config.php';
if (!isset($_SESSION['user_id'])) { header("Location: login.php"); exit(); }

$activePage = 'candidates';
$pageTitle  = 'Candidates';

$conn = getDatabaseConnection();

// Single candidate view
if (isset($_GET['id'])) {
    $id   = (int)$_GET['id'];
    $stmt = $conn->prepare("
        SELECT c.*, p.name AS partylist_name, p.description AS pl_desc
        FROM   candidates c
        LEFT JOIN partylists p ON c.partylist_id = p.id
        WHERE  c.id = ?
    ");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $cand = $stmt->get_result()->fetch_assoc();
    $stmt->close();
    if (!$cand) { header("Location: candidates.php"); exit(); }
}

// List / search view
$search   = trim($_GET['search'] ?? '');
$position_filter = trim($_GET['position'] ?? '');

$sql = "SELECT c.id, c.full_name, c.position, c.photo, c.year_level, c.course, p.name AS partylist
        FROM   candidates c
        LEFT JOIN partylists p ON c.partylist_id = p.id
        WHERE  1=1";
$params = [];
$types  = '';

if ($search) {
    $sql    .= " AND (c.full_name LIKE ? OR c.position LIKE ? OR p.name LIKE ?)";
    $like    = "%$search%";
    $params  = [$like, $like, $like];
    $types   = 'sss';
}
if ($position_filter) {
    $sql    .= " AND c.position = ?";
    $params[] = $position_filter;
    $types   .= 's';
}
$sql .= " ORDER BY c.position, c.full_name";

$stmt = $conn->prepare($sql);
if ($params) { $stmt->bind_param($types, ...$params); }
$stmt->execute();
$candidates = $stmt->get_result();
$stmt->close();

// Distinct positions for filter dropdown
$positions = $conn->query("SELECT DISTINCT position FROM candidates ORDER BY position");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GovTrackr — Candidates</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body class="dash-body">

<?php include 'includes/sidebar.php'; ?>

<div style="flex:1; display:flex; flex-direction:column;">
    <?php include 'includes/topbar.php'; ?>

    <main class="dash-content">

    <?php if (isset($cand)): ?>
    <!-- ── CANDIDATE PROFILE VIEW ── -->
    <a href="candidates.php" class="btn btn-outline btn-sm" style="align-self:flex-start;">← Back to Candidates</a>

    <div style="display:grid; grid-template-columns:280px 1fr; gap:24px; align-items:start;">
        <!-- Photo + party -->
        <div style="display:flex; flex-direction:column; gap:16px;">
            <div class="card" style="text-align:center; padding:28px;">
                <?php if ($cand['photo']): ?>
                    <img src="<?= htmlspecialchars($cand['photo']) ?>" alt="" style="width:160px;height:160px;object-fit:cover;border-radius:50%;border:4px solid var(--gold);margin:0 auto 14px;">
                <?php else: ?>
                    <div style="width:160px;height:160px;border-radius:50%;border:4px solid var(--gold);background:var(--purple-soft);display:flex;align-items:center;justify-content:center;font-size:4rem;margin:0 auto 14px;">👤</div>
                <?php endif; ?>
                <div style="font-size:1.3rem;font-weight:900;"><?= htmlspecialchars($cand['full_name']) ?></div>
                <div style="color:var(--muted);font-size:.88rem;margin-top:4px;"><?= htmlspecialchars($cand['position']) ?></div>
                <?php if ($cand['partylist_name']): ?>
                <span class="party-badge" style="margin:10px auto 0;"><?= htmlspecialchars($cand['partylist_name']) ?></span>
                <?php endif; ?>
            </div>
            <div class="card">
                <h4 class="card-title">Details</h4>
                <?php if ($cand['year_level']): ?>
                <p style="font-size:.88rem;margin-bottom:6px;"><strong>Year Level:</strong> <?= htmlspecialchars($cand['year_level']) ?></p>
                <?php endif; ?>
                <?php if ($cand['course']): ?>
                <p style="font-size:.88rem;"><strong>Course:</strong> <?= htmlspecialchars($cand['course']) ?></p>
                <?php endif; ?>
            </div>
        </div>

        <!-- Bio + platform -->
        <div style="display:flex;flex-direction:column;gap:16px;">
            <?php if ($cand['bio']): ?>
            <div class="card">
                <h3 class="card-title">About</h3>
                <p style="font-size:.92rem;line-height:1.7;color:var(--text);"><?= nl2br(htmlspecialchars($cand['bio'])) ?></p>
            </div>
            <?php endif; ?>
            <?php if ($cand['platform']): ?>
            <div class="card">
                <h3 class="card-title">Platform & Advocacies</h3>
                <p style="font-size:.92rem;line-height:1.7;color:var(--text);"><?= nl2br(htmlspecialchars($cand['platform'])) ?></p>
            </div>
            <?php endif; ?>
            <?php if ($cand['partylist_name']): ?>
            <div class="card card-dark">
                <h3 class="card-title">Partylist: <?= htmlspecialchars($cand['partylist_name']) ?></h3>
                <p style="font-size:.88rem;opacity:.85;line-height:1.6;"><?= htmlspecialchars($cand['pl_desc'] ?? '') ?></p>
                <a href="partylists.php" class="btn btn-gold btn-sm" style="margin-top:12px;">View Full Partylist →</a>
            </div>
            <?php endif; ?>
        </div>
    </div>

    <?php else: ?>
    <!-- ── CANDIDATE LIST / SEARCH ── -->

    <!-- Filters -->
    <div class="card" style="padding:16px 20px;">
        <form method="GET" action="" style="display:flex;gap:12px;flex-wrap:wrap;align-items:center;">
            <div class="input-wrap" style="flex:1;min-width:200px;">
                <span class="icon">🔍</span>
                <input type="text" name="search" placeholder="Search by name, position, partylist…"
                       value="<?= htmlspecialchars($search) ?>">
            </div>
            <select name="position" style="padding:11px 14px;border:1.5px solid var(--border);border-radius:8px;font-size:.92rem;background:#FAFAFA;color:var(--text);outline:none;">
                <option value="">All Positions</option>
                <?php while ($pos = $positions->fetch_assoc()): ?>
                <option value="<?= htmlspecialchars($pos['position']) ?>"
                        <?= $position_filter === $pos['position'] ? 'selected' : '' ?>>
                    <?= htmlspecialchars($pos['position']) ?>
                </option>
                <?php endwhile; ?>
            </select>
            <button type="submit" class="btn btn-purple">Search</button>
            <?php if ($search || $position_filter): ?>
            <a href="candidates.php" class="btn btn-outline">Clear</a>
            <?php endif; ?>
        </form>
    </div>

    <!-- Candidate grid -->
    <?php if ($candidates->num_rows === 0): ?>
    <div class="card" style="text-align:center;padding:48px;">
        <p style="font-size:1.1rem;color:var(--muted);">No candidates found. Try a different search.</p>
    </div>
    <?php else: ?>
    <div class="candidate-grid">
        <?php while ($c = $candidates->fetch_assoc()): ?>
        <a href="candidates.php?id=<?= $c['id'] ?>" class="candidate-card">
            <?php if ($c['photo']): ?>
                <img src="<?= htmlspecialchars($c['photo']) ?>" alt="<?= htmlspecialchars($c['full_name']) ?>" class="photo">
            <?php else: ?>
                <div class="photo">👤</div>
            <?php endif; ?>
            <div class="info">
                <div class="name"><?= htmlspecialchars($c['full_name']) ?></div>
                <div class="position"><?= htmlspecialchars($c['position']) ?></div>
                <?php if ($c['partylist']): ?>
                <span class="party-badge"><?= htmlspecialchars($c['partylist']) ?></span>
                <?php endif; ?>
            </div>
        </a>
        <?php endwhile; ?>
    </div>
    <?php endif; ?>

    <?php endif; // end single vs list view ?>

    </main>
</div>

</body>
</html>
