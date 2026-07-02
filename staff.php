<?php
session_start();

if (!isset($_SESSION['role']) || $_SESSION['role'] !== "staff") {
    header("Location: login.php");
    exit;
}

include "db.php";
$staff_username = $_SESSION['staff_username'];

// ----- Handle actions: update / sign / unlock -----
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    $action    = $_POST['action'];
    $status_id = $_POST['status_id'];
    $back_id   = $_POST['student_id'];

    if ($action === 'update') {
        $status  = $_POST['status'];
        $remarks = $_POST['remarks'];
        $due     = $_POST['due_date'];
        if (trim($due) === '') {
            header("Location: staff.php?student_id=$back_id&nodate=1");
            exit;
        }
        $stmt = $conn->prepare("CALL sp_UpdateClearance(?, ?, ?, ?)");
        $stmt->bind_param("isss", $status_id, $status, $remarks, $due);
        $stmt->execute();
        header("Location: staff.php?student_id=$back_id&updated=1");
        exit;
    }
    elseif ($action === 'sign') {
        $stmt = $conn->prepare("UPDATE clearance_status SET signed=1, signed_date=NOW() WHERE status_id=? AND status='Cleared'");
        $stmt->bind_param("i", $status_id);
        $stmt->execute();
        header("Location: staff.php?student_id=$back_id&signed=1");
        exit;
    }
    elseif ($action === 'unlock') {
        $stmt = $conn->prepare("UPDATE clearance_status SET signed=0, signed_date=NULL WHERE status_id=?");
        $stmt->bind_param("i", $status_id);
        $stmt->execute();
        header("Location: staff.php?student_id=$back_id&unlocked=1");
        exit;
    }
}

$search      = isset($_GET['search']) ? $_GET['search'] : "";
$selected_id = isset($_GET['student_id']) ? $_GET['student_id'] : "";
$updated     = isset($_GET['updated']);
$nodate      = isset($_GET['nodate']);
$signedMsg   = isset($_GET['signed']);
$unlockedMsg = isset($_GET['unlocked']);
$filter      = isset($_GET['filter']) ? $_GET['filter'] : "all";
$today       = date('Y-m-d');
$searchQS    = $search !== "" ? "&search=" . urlencode($search) : "";
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Manage Clearances</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="topbar">
    <div class="brand"><span class="seal"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><path d="M21.5 10 12 5.2 2.5 10 12 14.8 21.5 10Z"/><path d="M6.5 12.2V16.5c0 1.2 2.5 2.3 5.5 2.3s5.5-1.1 5.5-2.3V12.2"/><path d="M21.5 10v4"/></svg></span><span class="wm">MCL Clearance</span></div>
    <div class="right">
      <div class="who"><?php echo $_SESSION['office_name']; ?><small>Office Staff</small></div>
      <a class="btn-out" href="logout.php">Sign out</a>
    </div>
  </div>

  <div class="wrap">
    <div class="eyebrow">Office Staff</div>
    <h1 class="page-h serif" style="margin-bottom:22px;">Manage Clearances</h1>

    <?php if ($selected_id === "") { ?>

      <?php
      // ---- counts for the filter badges ----
      $cnt = ['Pending'=>0,'Cleared'=>0,'Flagged'=>0];
      $cstmt = $conn->prepare("SELECT cs.status, COUNT(*) c FROM clearance_status cs JOIN requirements r ON cs.requirement_id=r.requirement_id WHERE r.staff_username=? GROUP BY cs.status");
      $cstmt->bind_param("s", $staff_username);
      $cstmt->execute();
      $cres = $cstmt->get_result();
      while ($cr = $cres->fetch_assoc()) { $cnt[$cr['status']] = $cr['c']; }
      $c_all     = $cnt['Pending'] + $cnt['Cleared'] + $cnt['Flagged'];
      $c_action  = $cnt['Pending'] + $cnt['Flagged'];
      $c_cleared = $cnt['Cleared'];

      $sstmt = $conn->prepare("SELECT COUNT(*) c FROM clearance_status cs JOIN requirements r ON cs.requirement_id=r.requirement_id WHERE r.staff_username=? AND cs.signed=1");
      $sstmt->bind_param("s", $staff_username);
      $sstmt->execute();
      $c_signed = $sstmt->get_result()->fetch_assoc()['c'];
      ?>

      <!-- ===== FILTER TABS (on top) ===== -->
      <div class="filters">
        <a class="filter-btn <?php echo $filter==='all'?'on':''; ?>" href="staff.php?filter=all<?php echo $searchQS; ?>">All <span class="fcount"><?php echo $c_all; ?></span></a>
        <a class="filter-btn <?php echo $filter==='action'?'on':''; ?>" href="staff.php?filter=action<?php echo $searchQS; ?>">Needs Action <span class="fcount action"><?php echo $c_action; ?></span></a>
        <a class="filter-btn <?php echo $filter==='cleared'?'on':''; ?>" href="staff.php?filter=cleared<?php echo $searchQS; ?>">Cleared <span class="fcount cleared"><?php echo $c_cleared; ?></span></a>
        <a class="filter-btn <?php echo $filter==='signed'?'on':''; ?>" href="staff.php?filter=signed<?php echo $searchQS; ?>">Signed <span class="fcount cleared"><?php echo $c_signed; ?></span></a>
      </div>

      <!-- ===== SEARCH (below the tabs, auto-submits) ===== -->
      <form method="GET" action="staff.php" class="searchbar" id="searchForm">
        <input type="hidden" name="filter" value="<?php echo htmlspecialchars($filter); ?>">
        <input type="text" name="search" id="searchInput" autocomplete="off"
               placeholder="Search a student by name or student no."
               value="<?php echo htmlspecialchars($search); ?>" oninput="autoSearch()">
        <button type="submit" class="btn">Search</button>
      </form>

      <?php
      $where  = "r.staff_username = ?";
      $types  = "s";
      $params = [$staff_username];
      if ($filter === 'action')      { $where .= " AND cs.status IN ('Pending','Flagged')"; }
      elseif ($filter === 'cleared') { $where .= " AND cs.status = 'Cleared'"; }
      elseif ($filter === 'signed')  { $where .= " AND cs.signed = 1"; }
      if ($search !== "") {
          $where .= " AND (s.last_name LIKE ? OR s.first_name LIKE ? OR s.student_no LIKE ?)";
          $like = "%" . $search . "%";
          $types .= "sss";
          $params[] = $like; $params[] = $like; $params[] = $like;
      }
      $sql = "SELECT s.student_id, s.student_no, s.last_name, s.first_name,
                     r.office_name, cs.status, cs.due_date, cs.signed, cs.signed_date,
                     (SELECT COUNT(*) FROM clearance_status x
                      WHERE x.student_id = s.student_id AND x.signed = 0) AS unsigned_count
              FROM clearance_status cs
              JOIN students s     ON cs.student_id = s.student_id
              JOIN requirements r ON cs.requirement_id = r.requirement_id
              WHERE $where
              ORDER BY s.last_name";
      $stmt = $conn->prepare($sql);
      $stmt->bind_param($types, ...$params);
      $stmt->execute();
      $recs = $stmt->get_result();
      ?>

      <div class="card" style="padding:0; overflow:hidden;">
        <table class="data">
          <tr><th>Student No</th><th>Name</th><th>Requirement</th><th>Status</th><th>Signed</th><th>Due Date</th><th></th></tr>
          <?php if ($recs->num_rows === 0) { ?>
            <tr><td colspan="7" class="muted" style="text-align:center; padding:22px;">No records match this view.</td></tr>
          <?php } else { while ($row = $recs->fetch_assoc()) {
              $overdue = ($row['due_date'] && $row['due_date'] < $today && $row['status'] !== 'Cleared');
          ?>
          <tr>
            <td><?php echo $row['student_no']; ?></td>
            <td style="font-weight:600;"><?php echo $row['last_name'] . ", " . $row['first_name']; ?>
              <?php if ($row['unsigned_count'] == 0) echo '<br><span class="mini-cleared">&#10003; Fully signed</span>'; ?>
            </td>
            <td class="muted"><?php echo $row['office_name']; ?></td>
            <td><span class="pill <?php echo strtolower($row['status']); ?>"><?php echo $row['status']; ?></span></td>
            <td>
              <?php if ($row['signed']) { ?>
                <span class="signed">&#10003; <?php echo date('M j, Y', strtotime($row['signed_date'])); ?></span>
              <?php } else { ?>
                <span class="muted">—</span>
              <?php } ?>
            </td>
            <td class="muted" style="<?php echo $overdue ? 'color:var(--flagged);font-weight:600;' : ''; ?>">
              <?php echo $row['due_date'] ? $row['due_date'] : "—"; ?>
            </td>
            <td><a href="staff.php?student_id=<?php echo $row['student_id']; ?>">Manage</a></td>
          </tr>
          <?php } } ?>
        </table>
      </div>

    <?php } else { ?>

      <!-- ===== SELECTED STUDENT ===== -->
      <a class="backlink" href="staff.php">&larr; Back to student search</a>

      <?php
      $stmt = $conn->prepare("SELECT * FROM students WHERE student_id = ?");
      $stmt->bind_param("i", $selected_id);
      $stmt->execute();
      $stu = $stmt->get_result()->fetch_assoc();

      $stmt = $conn->prepare("
          SELECT cs.status_id, r.office_name, cs.status, cs.remarks, cs.due_date, cs.signed, cs.signed_date
          FROM clearance_status cs
          JOIN requirements r ON cs.requirement_id = r.requirement_id
          WHERE cs.student_id = ? AND r.staff_username = ?
          ORDER BY r.requirement_id");
      $stmt->bind_param("is", $selected_id, $staff_username);
      $stmt->execute();
      $recs = $stmt->get_result();
      ?>

      <h2 class="page-h serif" style="font-size:21px;">
        <?php echo $stu['last_name'] . ", " . $stu['first_name']; ?>
        <span class="muted" style="font-weight:500; font-size:14px;">(<?php echo $stu['student_no']; ?>)</span>
      </h2>
      <p class="page-sub"><?php echo $stu['course'] . " &middot; " . $stu['student_type']; ?></p>

      <?php if ($updated)     { echo "<div class='notice'>&#10003; Saved successfully.</div><br>"; } ?>
      <?php if ($signedMsg)   { echo "<div class='notice'>&#10003; Signed and locked.</div><br>"; } ?>
      <?php if ($unlockedMsg) { echo "<div class='notice'>Record unlocked \u2014 you can edit it again.</div><br>"; } ?>
      <?php if ($nodate)      { echo "<div class='error'>Please set a due date before saving.</div><br>"; } ?>

      <?php if ($recs->num_rows === 0) { ?>
        <p class="muted"><em>This student has no requirement under your office.</em></p>
      <?php } else { ?>
        <?php while ($r = $recs->fetch_assoc()) { ?>

          <?php if ($r['signed']) { ?>
            <div class="manage locked">
              <div class="req-name">
                <?php echo $r['office_name']; ?>
                &nbsp; <span class="pill cleared">Cleared</span>
                &nbsp; <span class="signed">&#10003; Signed <?php echo date('M j, Y', strtotime($r['signed_date'])); ?> — Locked</span>
              </div>
              <p class="locked-note" style="margin:0 0 12px;">This clearance has been signed and locked. It can no longer be edited.</p>
              <form method="POST" action="staff.php">
                <input type="hidden" name="action" value="unlock">
                <input type="hidden" name="status_id" value="<?php echo $r['status_id']; ?>">
                <input type="hidden" name="student_id" value="<?php echo $selected_id; ?>">
                <button type="submit" class="btn-out">Unlock</button>
              </form>
            </div>

          <?php } else { ?>
            <form method="POST" action="staff.php" class="manage" onsubmit="return checkDate(this);">
              <input type="hidden" name="action" value="update">
              <div class="req-name">
                <?php echo $r['office_name']; ?>
                &nbsp; <span class="pill <?php echo strtolower($r['status']); ?>"><?php echo $r['status']; ?></span>
              </div>
              <div class="field-row">
                <label>Status:</label>
                <select name="status">
                  <option <?php if ($r['status']==='Pending') echo 'selected'; ?>>Pending</option>
                  <option <?php if ($r['status']==='Cleared') echo 'selected'; ?>>Cleared</option>
                  <option <?php if ($r['status']==='Flagged') echo 'selected'; ?>>Flagged</option>
                </select>
                <label>Due date:</label>
                <input type="date" name="due_date" required value="<?php echo $r['due_date'] ?? ''; ?>">
              </div>
              <div class="field-row" style="margin-top:12px;">
                <label>Remarks:</label>
                <input type="text" name="remarks" style="flex:1; min-width:220px;"
                       value="<?php echo htmlspecialchars($r['remarks'] ?? ''); ?>" placeholder="(optional)">
                <input type="hidden" name="status_id" value="<?php echo $r['status_id']; ?>">
                <input type="hidden" name="student_id" value="<?php echo $selected_id; ?>">
                <button type="submit" class="btn btn-dark">Save</button>
              </div>
            </form>

            <?php if ($r['status'] === 'Cleared') { ?>
              <div class="sign-bar">
                <form method="POST" action="staff.php">
                  <input type="hidden" name="action" value="sign">
                  <input type="hidden" name="status_id" value="<?php echo $r['status_id']; ?>">
                  <input type="hidden" name="student_id" value="<?php echo $selected_id; ?>">
                  <button type="submit" class="btn btn-green">&#10003; Sign &amp; Finalize</button>
                </form>
                <span class="locked-note">Signing locks this record so it can no longer be edited.</span>
              </div>
            <?php } ?>

          <?php } ?>

        <?php } ?>
      <?php } ?>

    <?php } ?>

  </div>

  <script>
    // auto-submit search shortly after typing stops (keeps current tab)
    var searchTimer;
    function autoSearch(){
      clearTimeout(searchTimer);
      searchTimer = setTimeout(function(){ document.getElementById('searchForm').submit(); }, 500);
    }
    // keep focus in the search box after the auto reload, cursor at the end
    window.addEventListener('load', function(){
      var inp = document.getElementById('searchInput');
      if (inp && inp.value !== '') { inp.focus(); inp.setSelectionRange(inp.value.length, inp.value.length); }
    });
    // due-date required on save
    function checkDate(form){
      var d = form.querySelector('input[name=due_date]');
      if (!d.value) { alert('Please set a due date before saving.'); d.focus(); return false; }
      return true;
    }
  </script>
</body>
</html>