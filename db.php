<?php
// Connects to the clearance database in XAMPP
$conn = new mysqli("localhost", "root", "", "clearance_db");

// Stop and show an error if the connection fails
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>