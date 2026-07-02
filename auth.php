<?php
session_start();
include "db.php";

$role     = $_POST['role'];
$username = $_POST['username'];
$password = $_POST['password'];

if ($role === "student") {
    // Students log in with their student number
    $stmt = $conn->prepare("SELECT * FROM students WHERE student_no = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows === 1) {
        $student = $result->fetch_assoc();
        $_SESSION['role'] = "student";
        $_SESSION['student_id'] = $student['student_id'];
        $_SESSION['name'] = $student['first_name'] . " " . $student['last_name'];
        header("Location: student.php");
        exit;
    }
} else {
    // Staff log in with the username/password stored in requirements
    $stmt = $conn->prepare("SELECT * FROM requirements WHERE staff_username = ? AND staff_password = ?");
    $stmt->bind_param("ss", $username, $password);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows >= 1) {
        $office = $result->fetch_assoc();
        $_SESSION['role'] = "staff";
        $_SESSION['office_name'] = $office['office_name'];
        $_SESSION['staff_username'] = $username;
        header("Location: staff.php");
        exit;
    }
}

// If we reach here, login failed
header("Location: login.php?error=1");
exit;
?>