-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2026 at 11:55 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clearance_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `requirements`
--

CREATE TABLE `requirements` (
  `requirement_id` int(11) NOT NULL,
  `office_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `applies_to` enum('College','Senior High','Both') DEFAULT 'Both',
  `staff_email` varchar(100) NOT NULL,
  `staff_password` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `requirements`
--

INSERT INTO `requirements` (`requirement_id`, `office_name`, `description`, `applies_to`, `staff_email`, `staff_password`) VALUES
(1, 'Library', 'No unreturned books or library materials.', 'Both', 'library@mcl.edu.ph', 'lib123'),
(2, 'Treasury', 'No outstanding tuition or fee balances.', 'Both', 'treasury@mcl.edu.ph', 'treasury123'),
(3, 'Laboratory', 'No unreturned or damaged laboratory equipment.', 'Both', 'laboratory@mcl.edu.ph', 'lab123'),
(4, 'Guidance', 'Completed required guidance sessions and exit interview.', 'Both', 'guidance@mcl.edu.ph', 'guid123'),
(5, 'TOEIC Exam', 'Passed the TOEIC exam.', 'College', 'opqm@mcl.edu.ph', 'opqm123'),
(6, 'Exit MELT', 'Passed the Mapua MELT exit exam.', 'College', 'opqm@mcl.edu.ph', 'opqm123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `requirements`
--
ALTER TABLE `requirements`
  ADD PRIMARY KEY (`requirement_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `requirements`
--
ALTER TABLE `requirements`
  MODIFY `requirement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
