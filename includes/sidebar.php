<?php
// includes/sidebar.php
// Usage: include 'includes/sidebar.php';
// Requires $activePage variable set before including, e.g. $activePage = 'dashboard';

$pages = [
    'dashboard'    => ['label' => 'Dashboard',      'href' => '/govtrackr/dashboard.php'],
    'candidates'   => ['label' => 'Candidates',      'href' => '/govtrackr/candidates.php'],
    'partylists'   => ['label' => 'Partylists',      'href' => '/govtrackr/partylists.php'],
    'mock-election'=> ['label' => 'Mock Election',   'href' => '/govtrackr/mock_election.php'],
    'profile'      => ['label' => 'Profile',         'href' => '/govtrackr/profile.php'],
];
$active = $activePage ?? '';
?>
<aside class="sidebar">
    <div class="sidebar-brand">
        <span class="brand-gov">Gov</span><span class="brand-trackr">Trackr</span>
    </div>
    <nav class="sidebar-nav">
        <?php foreach ($pages as $key => $p): ?>
        <a href="<?= $p['href'] ?>"
           class="nav-item <?= $active === $key ? 'active' : '' ?>"
           title="<?= $p['label'] ?>">
            <span class="nav-label"><?= $p['label'] ?></span>
        </a>
        <?php endforeach; ?>
    </nav>
    <a href="/govtrackr/logout.php" class="nav-item nav-logout" title="Logout">
        <span class="nav-label">Logout</span>
    </a>
</aside>
