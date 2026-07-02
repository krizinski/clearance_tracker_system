<?php
session_start();
$error = isset($_GET['error']) ? "Invalid login. Please try again." : "";
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>MCL Clearance — Login</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <div class="login-bg">
    <div class="login-card">
      <div class="brand">
        <span class="seal"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.9" stroke-linecap="round" stroke-linejoin="round"><path d="M21.5 10 12 5.2 2.5 10 12 14.8 21.5 10Z"/><path d="M6.5 12.2V16.5c0 1.2 2.5 2.3 5.5 2.3s5.5-1.1 5.5-2.3V12.2"/><path d="M21.5 10v4"/></svg></span>
        <span class="wm">MCL Clearance</span>
      </div>
      <h1>Sign in</h1>
      <p class="sub">Access your clearance records.</p>

      <?php if ($error) { echo "<div class='error'>$error</div>"; } ?>

      <form method="POST" action="auth.php">
        <div class="field">
          <label>I am a:</label>
          <select name="role" id="role" onchange="updateLabel()">
            <option value="student">Student</option>
            <option value="staff">Office Staff</option>
          </select>
        </div>
        <div class="field">
          <label id="idLabel">Student Number</label>
          <input type="text" name="username" id="idInput" required>
        </div>
        <div class="field">
          <label>Password</label>
          <input type="password" name="password" id="pw" required>
        </div>
        <label class="show-pass"><input type="checkbox" onclick="togglePw()"> Show password</label>
        <button type="submit" class="btn">Sign In</button>
      </form>

      <div class="help-wrap">
        <button type="button" class="help-toggle" onclick="toggleHelp()">Have trouble logging in?</button>
      </div>
      <div id="helpBox" class="help-box" style="display:none;">
        Feel free to contact:<br>
        <b>Information Technology Services Office</b><br>
        Second Floor, J.P. Rizal Building<br>
        (049) 832 – 4000, local 1200<br><br>
        <a href="https://mcl.edu.ph/maps-and-directories/" target="_blank" rel="noopener">Other concern/s?</a>
      </div>
    </div>
  </div>

  <script>
    function updateLabel(){
      var role  = document.getElementById('role').value;
      var label = document.getElementById('idLabel');
      var input = document.getElementById('idInput');
      if (role === 'student') {
        label.textContent = 'Student Number';
      } else {
        label.textContent = 'Username';
      }
    }
    function togglePw(){
      var p = document.getElementById('pw');
      p.type = (p.type === 'password') ? 'text' : 'password';
    }
    function toggleHelp(){
      var h = document.getElementById('helpBox');
      h.style.display = (h.style.display === 'none') ? 'block' : 'none';
    }
    updateLabel();
  </script>
</body>
</html>