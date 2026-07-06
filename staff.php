<?php
session_start();

if (!isset($_SESSION['role']) || $_SESSION['role'] !== "staff") {
    header("Location: login.php");
    exit;
}

include "db.php";
$staff_username = $_SESSION['staff_username'];

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    $action    = $_POST['action'];
    $back_id   = $_POST['student_id'];

    if (isset($_POST['remarks_clearance']) && $_POST['remarks_clearance'] === 'clear_all') {
        $remarks = "No outstanding liabilities recorded.";
    } else {
        $flags = isset($_POST['flag_items']) ? $_POST['flag_items'] : [];
        if (!empty($_POST['custom_reason'])) {
            $flags[] = trim($_POST['custom_reason']);
        }
        $remarks = !empty($flags) ? implode(" | ", $flags) : "No outstanding liabilities recorded.";
    }

    if ($action === 'insert_hold') {
        $status  = $_POST['status'];
        $due     = !empty($_POST['due_date']) ? $_POST['due_date'] : NULL;
        $req_id  = $_POST['requirement_id'];

        $stmt = $conn->prepare("INSERT INTO clearance_status (student_id, requirement_id, status, remarks, due_date) VALUES (?, ?, ?, ?, ?)");
        $stmt->bind_param("iisss", $back_id, $req_id, $status, $remarks, $due);
        $stmt->execute();

        header("Location: staff.php?student_id=$back_id&updated=1");
        exit;
    }
    elseif ($action === 'update') {
        $status_id = $_POST['status_id'];
        $status    = $_POST['status'];
        $due       = !empty($_POST['due_date']) ? $_POST['due_date'] : NULL;

        $stmt = $conn->prepare("UPDATE clearance_status SET status = ?, remarks = ?, due_date = ?, date_updated = NOW() WHERE status_id = ?");
        $stmt->bind_param("sssi", $status, $remarks, $due, $status_id);
        $stmt->execute();

        header("Location: staff.php?student_id=$back_id&updated=1");
        exit;
    }
    elseif ($action === 'sign') {
        $status_id  = $_POST['status_id'];
        $auditor_nm = isset($_POST['auditor_name']) ? trim($_POST['auditor_name']) : "Authorized Staff";

        $stmt = $conn->prepare("UPDATE clearance_status SET status='Signed', signed=1, signed_date=NOW(), signed_by=? WHERE status_id=? AND status='Cleared'");
        $stmt->bind_param("si", $auditor_nm, $status_id);
        $stmt->execute();
        header("Location: staff.php?student_id=$back_id&signed=1");
        exit;
    }
    elseif ($action === 'sign_multi') {
        $status_ids = isset($_POST['status_ids']) ? $_POST['status_ids'] : [];
        $auditor_nm = isset($_POST['auditor_name']) ? trim($_POST['auditor_name']) : "Authorized Staff";

        if (!empty($status_ids)) {
            $stmt = $conn->prepare("UPDATE clearance_status SET status='Signed', signed=1, signed_date=NOW(), signed_by=? WHERE status_id=? AND status='Cleared'");
            foreach ($status_ids as $sid) {
                $sid = (int)$sid;
                $stmt->bind_param("si", $auditor_nm, $sid);
                $stmt->execute();
            }
        }
        header("Location: staff.php?student_id=$back_id&signed=1");
        exit;
    }
    elseif ($action === 'unlock') {
        $status_id = $_POST['status_id'];
        $stmt = $conn->prepare("UPDATE clearance_status SET status='Cleared', signed=0, signed_date=NULL, signed_by=NULL WHERE status_id=?");
        $stmt->bind_param("i", $status_id);
        $stmt->execute();
        header("Location: staff.php?student_id=$back_id&unlocked=1");
        exit;
    }
}

$search      = isset($_GET['search']) ? $_GET['search'] : "";
$selected_id = isset($_GET['student_id']) ? $_GET['student_id'] : "";
$updated     = isset($_GET['updated']);
$signedMsg   = isset($_GET['signed']);
$unlockedMsg = isset($_GET['unlocked']);
$filter      = isset($_GET['filter']) ? $_GET['filter'] : "all";
$type_filter = isset($_GET['student_type']) ? $_GET['student_type'] : "all";
$today       = date('Y-m-d');
$searchQS    = ($search !== "" ? "&search=" . urlencode($search) : "") . ($type_filter !== "all" ? "&student_type=" . urlencode($type_filter) : "");

function determineYearLevel($student_no, $type) {
    if ($type === 'Senior High') {
        return "Grade 12";
    } else {
        return "4th Year";
    }
}
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
    <div class="brand">
      <div class="seal">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M12 2L2 7l10 5 10-5-10-5z"/>
          <path d="M7 11.5V16c0 1.5 2.2 2.5 5 2.5s5-1 5-2.5v-4.5"/>
        </svg>
      </div>
      <span class="wm">MMCL Clearance</span>
    </div>
    <div class="right">
      <div class="who"><?php echo htmlspecialchars($_SESSION['office_name']); ?><small>Office Staff</small></div>
      <a class="btn-out" href="logout.php">Sign out</a>
    </div>
  </div>

  <div class="wrap">
    <div class="eyebrow">Office Staff</div>
    <h1 class="page-h serif" style="margin-bottom:22px;">Manage Clearances</h1>

    <?php if ($selected_id === "") { ?>

      <?php
      $cnt = ['Unprocessed'=>0,'Uncleared'=>0,'Cleared'=>0,'Signed'=>0];
      $cstmt = $conn->prepare("SELECT cs.status, COUNT(*) c FROM clearance_status cs JOIN requirements r ON cs.requirement_id=r.requirement_id WHERE r.staff_email=? GROUP BY cs.status");
      $cstmt->bind_param("s", $staff_username);
      $cstmt->execute();
      $cres = $cstmt->get_result();
      while ($cr = $cres->fetch_assoc()) { $cnt[$cr['status']] = $cr['c']; }

      $apstmt = $conn->prepare("SELECT COUNT(*) c FROM students s JOIN requirements r ON r.staff_email = ? AND (r.applies_to = 'Both' OR r.applies_to = s.student_type)");
      $apstmt->bind_param("s", $staff_username);
      $apstmt->execute();
      $applicable_total = $apstmt->get_result()->fetch_assoc()['c'];

      $c_action      = $cnt['Uncleared'];
      $c_cleared     = $cnt['Cleared'];
      $c_signed      = $cnt['Signed'];
      $c_unprocessed = $applicable_total - $c_action - $c_cleared - $c_signed;
      $c_all         = $applicable_total;
      ?>

      <div class="filters">
        <a class="filter-btn <?php echo $filter==='all'?'on':''; ?>" href="staff.php?filter=all<?php echo $searchQS; ?>">All <span class="fcount"><?php echo $c_all; ?></span></a>
        <a class="filter-btn <?php echo $filter==='action'?'on':''; ?>" href="staff.php?filter=action<?php echo $searchQS; ?>">Needs Action <span class="fcount action"><?php echo $c_action; ?></span></a>
        <a class="filter-btn <?php echo $filter==='cleared'?'on':''; ?>" href="staff.php?filter=cleared<?php echo $searchQS; ?>">Cleared <span class="fcount cleared"><?php echo $c_cleared; ?></span></a>
        <a class="filter-btn <?php echo $filter==='signed'?'on':''; ?>" href="staff.php?filter=signed<?php echo $searchQS; ?>">Signed <span class="fcount cleared"><?php echo $c_signed; ?></span></a>
        <a class="filter-btn <?php echo $filter==='unprocessed'?'on':''; ?>" href="staff.php?filter=unprocessed<?php echo $searchQS; ?>">Unprocessed <span class="fcount unprocessed"><?php echo $c_unprocessed; ?></span></a>
      </div>

      <form method="GET" action="staff.php" class="searchbar" id="searchForm" style="align-items: center;">
        <input type="hidden" name="filter" value="<?php echo htmlspecialchars($filter); ?>">
        <label for="searchInput" style="font-size:13.5px; font-weight:600; color:var(--ink-light); white-space:nowrap;">Student name/number:</label>
        <input type="text" name="search" id="searchInput" autocomplete="off" placeholder="e.g. Dela Cruz or 2023150241" value="<?php echo htmlspecialchars($search); ?>" oninput="autoSearch()">

        <select name="student_type" onchange="document.getElementById('searchForm').submit();" style="padding: 9px 12px; height: 41px;">
            <option value="all" <?php if($type_filter === 'all') echo 'selected'; ?>>All Education Levels</option>
            <option value="College" <?php if($type_filter === 'College') echo 'selected'; ?>>College Only</option>
            <option value="Senior High" <?php if($type_filter === 'Senior High') echo 'selected'; ?>>Senior High Only</option>
        </select>
      </form>

      <?php
      $where  = "1=1"; $types  = ""; $params = []; $like = "%" . $search . "%";
      if ($filter === 'action') { $where .= " AND cs.status = 'Uncleared' AND r.staff_email = ?"; $types .= "s"; $params[] = $staff_username; }
      elseif ($filter === 'cleared') { $where .= " AND cs.status = 'Cleared' AND r.staff_email = ?"; $types .= "s"; $params[] = $staff_username; }
      elseif ($filter === 'signed') { $where .= " AND cs.status = 'Signed' AND r.staff_email = ?"; $types .= "s"; $params[] = $staff_username; }
      if ($type_filter !== 'all') { $where .= " AND s.student_type = ?"; $types .= "s"; $params[] = $type_filter; }
      if ($search !== "") { $where .= " AND (s.last_name LIKE ? OR s.first_name LIKE ? OR s.student_no LIKE ?)"; }

      if ($filter === 'all' || $filter === 'unprocessed') {
          $extra = $filter === 'unprocessed' ? " AND (cs.status_id IS NULL OR cs.status = 'Unprocessed')" : "";
          $sql = "SELECT s.student_id, s.student_no, s.last_name, s.first_name, s.student_type,
                         r.office_name, r.requirement_id,
                         IFNULL(cs.status, 'Unprocessed') AS status, IFNULL(cs.remarks, '—') AS remarks, cs.due_date,
                         IFNULL(cs.signed, 0) AS signed, cs.signed_date, cs.signed_by
                  FROM students s
                  JOIN requirements r ON r.staff_email = ? AND (r.applies_to = 'Both' OR r.applies_to = s.student_type)
                  LEFT JOIN clearance_status cs ON cs.student_id = s.student_id AND cs.requirement_id = r.requirement_id
                  WHERE " . ($search !== "" ? "(s.last_name LIKE ? OR s.first_name LIKE ? OR s.student_no LIKE ?)" : "1=1") . ($type_filter !== 'all' ? " AND s.student_type = ?" : "") . $extra . " ORDER BY s.last_name, r.requirement_id";
          $stmt = $conn->prepare($sql);
          if ($search !== "" && $type_filter !== 'all') { $stmt->bind_param("sssss", $staff_username, $like, $like, $like, $type_filter); }
          elseif ($search !== "" && $type_filter === 'all') { $stmt->bind_param("ssss", $staff_username, $like, $like, $like); }
          elseif ($search === "" && $type_filter !== 'all') { $stmt->bind_param("ss", $staff_username, $type_filter); }
          else { $stmt->bind_param("s", $staff_username); }
      } else {
          $sql = "SELECT s.student_id, s.student_no, s.last_name, s.first_name, s.student_type, r.office_name, cs.status, cs.remarks, cs.due_date, cs.signed, cs.signed_date, cs.signed_by FROM clearance_status cs JOIN students s ON cs.student_id = s.student_id JOIN requirements r ON cs.requirement_id = r.requirement_id WHERE $where ORDER BY s.last_name";
          $stmt = $conn->prepare($sql);
          if ($search !== "") { $types .= "sss"; $params[] = $like; $params[] = $like; $params[] = $like; }
          if (!empty($types)) { $stmt->bind_param($types, ...$params); }
      }
      $stmt->execute(); $recs = $stmt->get_result();
      ?>

      <div class="card" style="padding:0; overflow:hidden;">
        <table class="data">
          <tr>
            <th>Student Number</th><th>Name</th><th>Requirements</th><th>Year Level</th><th>Remarks</th><th>Status</th><th>Signed</th><th>Due Date</th><th></th>
          </tr>
          <?php if ($recs->num_rows === 0) { ?>
            <tr><td colspan="9" class="muted" style="text-align:center; padding:22px;">No records found matching this view.</td></tr>
          <?php } else { while ($row = $recs->fetch_assoc()) {
              $overdue = ($row['due_date'] && $row['due_date'] < $today && $row['status'] !== 'Cleared' && $row['status'] !== 'Signed' && $row['status'] !== 'Unprocessed');
              $year_display = determineYearLevel($row['student_no'], $row['student_type']);
          ?>
          <tr>
            <td><?php echo $row['student_no']; ?></td>
            <td style="font-weight:600;"><?php echo htmlspecialchars($row['last_name'] . ", " . $row['first_name']); ?></td>
            <td><?php echo htmlspecialchars($row['office_name']); ?></td>
            <td><?php echo $year_display; ?></td>
            <td class="muted"><?php echo htmlspecialchars($row['remarks']); ?></td>
            <td><span class="pill <?php echo strtolower($row['status']); ?>"><?php echo $row['status']; ?></span></td>
            <td>
              <?php if ($row['signed']) { ?>
                <span class="signed">&#10003; <?php echo date('M j, Y', strtotime($row['signed_date'])); ?></span>
                <?php if (!empty($row['signed_by'])) { echo '<br><small style="color: var(--muted); font-size: 11px; display:block; margin-top:2px;">' . htmlspecialchars($row['signed_by']) . '</small>'; } ?>
              <?php } else { echo "<span class='muted'>—</span>"; } ?>
            </td>
            <td class="muted" style="<?php echo $overdue ? 'color:var(--flagged);font-weight:600;' : ''; ?>"><?php echo $row['due_date'] ? $row['due_date'] : "—"; ?></td>
            <td><a href="staff.php?student_id=<?php echo $row['student_id']; ?>">Manage</a></td>
          </tr>
          <?php } } ?>
        </table>
      </div>

    <?php } else { ?>

      <a class="backlink" href="staff.php">&larr; Back to student list</a>
      <?php
      $stmt = $conn->prepare("SELECT * FROM students WHERE student_id = ?");
      $stmt->bind_param("i", $selected_id); $stmt->execute(); $stu = $stmt->get_result()->fetch_assoc();

      $stmt = $conn->prepare("SELECT r.requirement_id, r.office_name, cs.status_id, IFNULL(cs.status, 'Unprocessed') AS status, cs.remarks, cs.due_date, IFNULL(cs.signed, 0) AS signed, cs.signed_date, cs.signed_by
                               FROM requirements r
                               LEFT JOIN clearance_status cs ON cs.requirement_id = r.requirement_id AND cs.student_id = ?
                               WHERE r.staff_email = ? AND (r.applies_to = 'Both' OR r.applies_to = ?)
                               ORDER BY r.requirement_id");
      $stmt->bind_param("iss", $selected_id, $staff_username, $stu['student_type']);
      $stmt->execute();
      $requirement_rows = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

      $active_holds = [];
      foreach ($requirement_rows as $rr) {
          if ($rr['status'] === 'Uncleared' && !empty($rr['remarks'])) {
              $active_holds[] = $rr['office_name'] . ': ' . $rr['remarks'];
          }
      }
      $active_hold_display = !empty($active_holds) ? implode(" | ", $active_holds) : 'None';

      $is_multi = count($requirement_rows) > 1;
      $all_cleared = count($requirement_rows) > 0;
      $status_ids_to_sign = [];
      foreach ($requirement_rows as $rr) {
          if ($rr['status'] !== 'Cleared') { $all_cleared = false; }
          if ($rr['status_id'] !== null) { $status_ids_to_sign[] = $rr['status_id']; }
      }
      ?>

      <h2 class="page-h serif" style="font-size:21px; margin-bottom:4px;"><?php echo $stu['last_name'] . ", " . $stu['first_name']; ?></h2>
      <p class="page-sub" style="margin-bottom: 25px;"><?php echo $stu['student_no']; ?></p>

      <div style="display: flex; gap: 28px; width: 100%; align-items: flex-start; flex-wrap: wrap;">
         <div style="flex: 1; min-width: 450px;">
           <?php foreach ($requirement_rows as $r) { ?>

              <?php if ($r['status_id'] === null) { ?>
                <form method="POST" action="staff.php" class="manage" style="max-width: 100%; margin: 0 0 16px;" onsubmit="return validateBeforeSubmit(event)">
                  <input type="hidden" name="action" value="insert_hold">
                  <input type="hidden" name="requirement_id" value="<?php echo $r['requirement_id']; ?>">
                  <div class="req-name"><?php echo $r['office_name']; ?> &nbsp; <span class="pill unprocessed">UNPROCESSED</span></div>
                  <div class="field-row" style="margin-bottom:14px;">
                    <label>Set Status:</label>
                    <select name="status" class="statusBox" onchange="toggleLiabilitiesSection(this)">
                       <option value="Cleared">Cleared (Good Standing)</option>
                       <option value="Uncleared" selected>Uncleared</option>
                    </select>
                    <label>Due date:</label>
                    <input type="date" name="due_date" class="dueDateField">
                  </div>
                  <label style="display:block; margin-bottom:8px;">Select outstanding liabilities:</label>
                  <div class="liabilitiesSection" style="background:#FBFAF6; border:1px solid var(--line); border-radius:8px; padding:14px; margin-bottom:16px;">
                    <?php
                    switch($r['office_name']) {
                        case "Library": $opts = ["Unreturned or overdue library books.", "Missing library clearance slip."]; break;
                        case "Treasury": $opts = ["Outstanding tuition balance.", "Unpaid miscellaneous fees."]; break;
                        case "Laboratory": $opts = ["Unreturned laboratory apparatus.", "Damaged equipment being assessed."]; break;
                        case "Guidance": $opts = ["Missed required guidance session.", "Exit interview not yet completed."]; break;
                        case "TOEIC Exam": $opts = ["Has not yet taken the TOEIC exam.", "Failed TOEIC exam, retake required."]; break;
                        case "Exit MELT": $opts = ["Has not yet taken the Exit MELT.", "Failed MELT exam, retake required."]; break;
                        default: $opts = ["Outstanding requirement not yet completed."]; break;
                    }
                    foreach ($opts as $opt) { echo "<div style='margin-bottom:8px; display:flex; align-items:flex-start; gap:8px;'><input type='checkbox' class='liability-checkbox' name='flag_items[]' value=\"$opt\" onchange='handleCheckboxChange(this)'><span style='font-size:13.5px;'>$opt</span></div>"; }
                    ?>
                    <div style="margin-top:12px; border-top:1px dashed var(--line); padding-top:10px;"><label style="font-size:12.5px; display:block; margin-bottom:4px;">Other / Custom Reason:</label><input type="text" class="customReason" name="custom_reason" placeholder="Type custom reason..." style="width:100%;" oninput="handleCheckboxChange(this)"></div>
                  </div>
                  <input type="hidden" name="remarks_clearance" class="remarksClearanceHidden" value="">
                  <input type="hidden" name="student_id" value="<?php echo $selected_id; ?>">
                  <div class="formError" style="display:none; background:#FEE2E2; color:#B91C1C; border:1px solid #B91C1C; border-left:5px solid #B91C1C; border-radius:6px; padding:12px 14px; font-size:13px; font-weight:700; margin-bottom:14px;"></div>
                  <button type="submit" class="btn btn-dark" style="width:100%; display:block; padding:12px;">Initialize Record Status</button>
                </form>

              <?php } elseif ($r['status'] === 'Signed') { ?>
                <div class="manage locked" style="max-width: 100%; margin: 0 0 16px;">
                  <div class="req-name"><?php echo $r['office_name']; ?> &nbsp; <span class="pill signed">Signed</span></div>
                  <p class="locked-note" style="margin:0 0 4px; font-size:13px;">This clearance has been signed and locked. It can no longer be edited.</p>
                  <?php if (!empty($r['signed_by'])) { ?><p style="font-size: 12.5px; margin: 0 0 14px 10px; color: var(--muted);"><strong>Signed By:</strong> <?php echo htmlspecialchars($r['signed_by']); ?></p><?php } ?>
                  <form method="POST" action="staff.php"><input type="hidden" name="action" value="unlock"><input type="hidden" name="status_id" value="<?php echo $r['status_id']; ?>"><input type="hidden" name="student_id" value="<?php echo $selected_id; ?>"><button type="submit" style="width:100%; background:none; border:1px solid var(--muted); color:var(--mmcl-blue); padding:10px; border-radius:6px; font-weight:600; cursor:pointer; font-family:inherit; font-size:14px;">Unlock For Editing</button></form>
                </div>

              <?php } else { ?>
                <form method="POST" action="staff.php" class="manage" style="max-width: 100%; margin: 0 0 16px;" onsubmit="return validateBeforeSubmit(event)">
                  <input type="hidden" name="action" value="update">
                  <div class="req-name"><?php echo $r['office_name']; ?> &nbsp; <span class="pill <?php echo strtolower($r['status']); ?>"><?php echo $r['status']; ?></span></div>
                  <div class="field-row" style="margin-bottom:14px;">
                    <label>Status:</label>
                    <select name="status" class="statusBox" onchange="toggleLiabilitiesSection(this)">
                      <option value="Cleared" <?php if ($r['status']==='Cleared') echo 'selected'; ?>>Cleared</option>
                      <option value="Uncleared" <?php if ($r['status']==='Uncleared') echo 'selected'; ?>>Uncleared</option>
                    </select>
                    <label>Due date:</label>
                    <input type="date" name="due_date" class="dueDateField" value="<?php echo $r['due_date'] ?? ''; ?>">
                  </div>
                  <label style="display:block; margin-bottom:8px;">Manage outstanding liabilities:</label>
                  <div class="liabilitiesSection" style="background:#FBFAF6; border:1px solid var(--line); border-radius:8px; padding:14px; margin-bottom:16px;">
                    <?php
                    switch($r['office_name']) {
                        case "Library": $opts = ["Unreturned or overdue library books.", "Missing library clearance slip."]; break;
                        case "Treasury": $opts = ["Outstanding tuition balance.", "Unpaid miscellaneous fees."]; break;
                        case "Laboratory": $opts = ["Unreturned laboratory apparatus.", "Damaged equipment being assessed."]; break;
                        case "Guidance": $opts = ["Missed required guidance session.", "Exit interview not yet completed."]; break;
                        case "TOEIC Exam": $opts = ["Has not yet taken the TOEIC exam.", "Failed TOEIC exam, retake required."]; break;
                        case "Exit MELT": $opts = ["Has not yet taken the Exit MELT.", "Failed MELT exam, retake required."]; break;
                        default: $opts = ["Outstanding requirement not yet completed."]; break;
                    }
                    foreach ($opts as $opt) {
                        $checked = (strpos($r['remarks'], $opt) !== false) ? 'checked' : '';
                        echo "<div style='margin-bottom:8px; display:flex; align-items:flex-start; gap:8px;'><input type='checkbox' class='liability-checkbox' name='flag_items[]' value=\"$opt\" $checked onchange='handleCheckboxChange(this)'><span style='font-size:13.5px;'>$opt</span></div>";
                    }
                    ?>
                    <div style="margin-top:12px; border-top:1px dashed var(--line); padding-top:10px;"><label style="font-size:12.5px; display:block; margin-bottom:4px;">Other / Custom Reason:</label><input type="text" class="customReason" name="custom_reason" placeholder="Type custom reason..." style="width:100%;" oninput="handleCheckboxChange(this)"></div>
                  </div>
                  <input type="hidden" name="remarks_clearance" class="remarksClearanceHidden" value="">
                  <input type="hidden" name="status_id" value="<?php echo $r['status_id']; ?>"><input type="hidden" name="student_id" value="<?php echo $selected_id; ?>">
                  <div class="formError" style="display:none; background:#FEE2E2; color:#B91C1C; border:1px solid #B91C1C; border-left:5px solid #B91C1C; border-radius:6px; padding:12px 14px; font-size:13px; font-weight:700; margin-bottom:14px;"></div>
                  <button type="submit" class="btn btn-dark" style="width: 100%; display:block; padding:12px;">Save Changes</button>
                </form>

                <?php if ($r['status'] === 'Cleared' && !$is_multi) { ?>
                  <div class="sign-bar" style="max-width: 100%; margin-top: -6px; margin-bottom:16px; background: #f9f9f9; border: 1px solid var(--line); padding: 14px; border-radius: 10px;">
                    <form method="POST" action="staff.php" style="width:100%;">
                      <input type="hidden" name="action" value="sign"><input type="hidden" name="status_id" value="<?php echo $r['status_id']; ?>"><input type="hidden" name="student_id" value="<?php echo $selected_id; ?>">
                      <label style="display:block; margin-bottom:6px; font-size:13px; font-weight:600;">Signatory Staff Member Name:</label>
                      <select name="auditor_name" style="width: 100%; margin-bottom: 12px; padding: 8px;" required>
                         <option value="" disabled selected>-- Select your name --</option>
                         <?php
                         switch($r['office_name']) {
                             case "Library": echo '<option value="Realyn Bautista">Realyn Bautista</option><option value="Marco Villar">Marco Villar</option><option value="Denisse Ocampo">Denisse Ocampo</option>'; break;
                             case "Treasury": echo '<option value="Rochelle Santos">Rochelle Santos</option><option value="Mark Mendoza">Mark Mendoza</option><option value="Francis Cruz">Francis Cruz</option>'; break;
                             case "Laboratory": echo '<option value="Janice Villanueva">Janice Villanueva</option><option value="Alan Torrentera">Alan Torrentera</option><option value="Robert Samson">Robert Samson</option>'; break;
                             case "Guidance": echo '<option value="Theresa Perez">Theresa Perez</option><option value="Dominic Bautista">Dominic Bautista</option><option value="Patricia Lim">Patricia Lim</option>'; break;
                             case "TOEIC Exam": case "Exit MELT": echo '<option value="Sophia Mendoza">Sophia Mendoza</option><option value="Christian Macfancy">Christian Macfancy</option><option value="Evelyn Custodio">Evelyn Custodio</option>'; break;
                             default: echo '<option value="Authorized Staff">Authorized Staff</option>'; break;
                         }
                         ?>
                      </select>
                      <button type="submit" class="btn btn-green" style="width:100%;">✓ Sign &amp; Finalize Clearance</button>
                    </form>
                  </div>
                <?php } ?>
              <?php } ?>
           <?php } ?>

           <?php if ($is_multi && $all_cleared) { ?>
             <div class="sign-bar" style="max-width: 100%; margin-top: -6px; margin-bottom:16px; background: #f9f9f9; border: 1px solid var(--line); padding: 14px; border-radius: 10px;">
               <form method="POST" action="staff.php" style="width:100%;">
                 <input type="hidden" name="action" value="sign_multi">
                 <?php foreach ($status_ids_to_sign as $sid) { ?>
                   <input type="hidden" name="status_ids[]" value="<?php echo $sid; ?>">
                 <?php } ?>
                 <input type="hidden" name="student_id" value="<?php echo $selected_id; ?>">
                 <label style="display:block; margin-bottom:6px; font-size:13px; font-weight:600;">Both requirements are Cleared. Signatory Staff Member Name:</label>
                 <select name="auditor_name" style="width: 100%; margin-bottom: 12px; padding: 8px;" required>
                    <option value="" disabled selected>-- Select your name --</option>
                    <option value="Sophia Mendoza">Sophia Mendoza</option>
                    <option value="Christian Macfancy">Christian Macfancy</option>
                    <option value="Evelyn Custodio">Evelyn Custodio</option>
                 </select>
                 <button type="submit" class="btn btn-green" style="width:100%;">✓ Sign &amp; Finalize Both Requirements</button>
               </form>
             </div>
           <?php } ?>
         </div>

         <div style="flex: 1; min-width: 380px; background: #fff; border: 1px solid var(--line); border-radius: 12px; padding: 22px; box-shadow: var(--shadow);">
             <h3 style="margin-top: 0; font-size: 16px; border-bottom: 2px solid var(--mmcl-blue); padding-bottom: 8px;">Student Dossier &amp; Status Overview</h3>
             <table style="width: 100%; font-size: 13.5px; border-collapse: collapse; margin-top: 10px;">
                 <tr style="border-bottom: 1px solid #f0f0f0;"><td style="padding: 8px 0; color: var(--muted); font-weight:500;">Institutional Email:</td><td style="padding: 8px 0; text-align: right; font-weight: 600;"><?php echo $stu['email']; ?></td></tr>
                 <tr style="border-bottom: 1px solid #f0f0f0;"><td style="padding: 8px 0; color: var(--muted); font-weight:500;">Academic Program:</td><td style="padding: 8px 0; text-align: right; font-weight: 600;"><?php echo $stu['course']; ?></td></tr>
                 <tr style="border-bottom: 1px solid #f0f0f0;"><td style="padding: 8px 0; color: var(--muted); font-weight:500;">Enrolment Division:</td><td style="padding: 8px 0; text-align: right; font-weight: 600;"><?php echo $stu['student_type']; ?></td></tr>
                 <tr style="border-bottom: 1px solid #f0f0f0;"><td style="padding: 8px 0; color: var(--muted); font-weight:500;">Calculated Year Track:</td><td style="padding: 8px 0; text-align: right; font-weight: 600;"><?php echo determineYearLevel($stu['student_no'], $stu['student_type']); ?></td></tr>
                 <tr><td style="padding: 8px 0; color: var(--muted); font-weight:500;">Active Hold Remarks:</td><td style="padding: 8px 0; text-align: right; color: var(--flagged); font-weight: 600; max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><?php echo htmlspecialchars($active_hold_display); ?></td></tr>
             </table>
         </div>
      </div>
    <?php } ?>
  </div>

  <script>
    function toggleLiabilitiesSection(selectEl) {
        var form = selectEl.closest('form');
        var section = form.querySelector('.liabilitiesSection');
        var hiddenClear = form.querySelector('.remarksClearanceHidden');
        var errorBox = form.querySelector('.formError');
        if (selectEl.value === 'Cleared') {
            if (section) section.style.display = 'none';
            if (hiddenClear) hiddenClear.value = 'clear_all';
        } else {
            if (section) section.style.display = 'block';
            if (hiddenClear) hiddenClear.value = '';
        }
        if (errorBox) errorBox.style.display = 'none';
    }

    function handleCheckboxChange(el) {
        var form = el.closest('form');
        var statusBox = form.querySelector('.statusBox');
        var checkboxes = form.querySelectorAll('.liability-checkbox');
        var customReason = form.querySelector('.customReason');
        var anyChecked = false;
        checkboxes.forEach(function(cb) { if (cb.checked) anyChecked = true; });
        if (customReason && customReason.value.trim() !== '') anyChecked = true;
        if (anyChecked && statusBox) { statusBox.value = "Uncleared"; }
    }

    function validateBeforeSubmit(event) {
        var form = event.target;
        var statusBox = form.querySelector('.statusBox');
        var dateField = form.querySelector('.dueDateField');
        var errorBox = form.querySelector('.formError');
        var checkboxes = form.querySelectorAll('.liability-checkbox');
        var customReason = form.querySelector('.customReason');

        if (statusBox && statusBox.value === 'Uncleared') {
            var hasDueDate = dateField && dateField.value !== '';
            var anyChecked = false;
            checkboxes.forEach(function(cb){ if (cb.checked) anyChecked = true; });
            if (customReason && customReason.value.trim() !== '') anyChecked = true;

            var missing = [];
            if (!hasDueDate) missing.push('a due date');
            if (!anyChecked) missing.push('at least one liability or a custom reason');

            if (missing.length > 0) {
                event.preventDefault();
                if (errorBox) {
                    errorBox.style.display = 'block';
                    errorBox.innerHTML = '⚠ Please provide ' + missing.join(' and ') + ' before saving — this requirement is marked Uncleared.';
                }
                return false;
            }
        }
        if (errorBox) errorBox.style.display = 'none';
        return true;
    }

    window.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.statusBox').forEach(function(sel) {
            toggleLiabilitiesSection(sel);
        });
    });

    var searchTimer; function autoSearch(){ clearTimeout(searchTimer); searchTimer = setTimeout(function(){ document.getElementById('searchForm').submit(); }, 500); }
    window.addEventListener('load', function(){ var inp = document.getElementById('searchInput'); if (inp && inp.value !== '') { inp.focus(); inp.setSelectionRange(inp.value.length, inp.value.length); } });
  </script>
</body>
</html>