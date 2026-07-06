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
-- Table structure for table `clearance_status`
--

CREATE TABLE `clearance_status` (
  `status_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `requirement_id` int(11) NOT NULL,
  `status` enum('Unprocessed','Uncleared','Cleared','Signed') DEFAULT 'Unprocessed',
  `remarks` text DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `signed` tinyint(1) DEFAULT 0,
  `signed_date` datetime DEFAULT NULL,
  `date_updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `signed_by` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `clearance_status`
--

INSERT INTO `clearance_status` (`status_id`, `student_id`, `requirement_id`, `status`, `remarks`, `due_date`, `signed`, `signed_date`, `date_updated`, `signed_by`) VALUES
(19, 1, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(20, 1, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(21, 1, 3, 'Uncleared', 'Damaged equipment being assessed.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(22, 1, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(23, 1, 5, 'Uncleared', 'Has not yet taken the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(24, 1, 6, 'Uncleared', 'Exam result verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(25, 2, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(26, 2, 2, 'Uncleared', 'Unpaid miscellaneous fees.', '2026-07-24', 0, NULL, '2026-07-03 15:13:51', NULL),
(27, 2, 3, 'Uncleared', 'Equipment check in progress.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(28, 2, 4, 'Uncleared', 'Awaiting exit interview schedule.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(29, 2, 5, 'Cleared', 'Passed the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(30, 2, 6, 'Uncleared', 'Exam result verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(31, 3, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(32, 3, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(33, 3, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(34, 3, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(35, 3, 5, 'Signed', 'Passed the TOEIC exam.', '2026-07-24', 1, '2026-07-03 10:32:00', '2026-07-03 12:18:58', 'Janice Villanueva'),
(36, 3, 6, 'Uncleared', 'Exam result verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(37, 4, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(38, 4, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(39, 4, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 10:13:00', '2026-07-03 12:18:58', 'Rochelle Santos'),
(40, 4, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(41, 4, 5, 'Cleared', 'Passed the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(42, 4, 6, 'Signed', 'Passed the Mapua MELT exit exam.', '2026-07-24', 1, '2026-07-03 12:05:00', '2026-07-03 12:18:58', 'Janice Villanueva'),
(43, 5, 1, 'Uncleared', '2 overdue library books unreturned.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(44, 5, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 09:15:00', '2026-07-03 12:18:58', 'Rochelle Santos'),
(45, 5, 3, 'Uncleared', 'Unreturned laboratory apparatus.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(46, 5, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 15:12:00', '2026-07-03 12:18:58', 'Alan Torrentera'),
(47, 5, 5, 'Cleared', 'Passed the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(48, 5, 6, 'Cleared', 'Passed the Mapua MELT exit exam.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(49, 6, 1, 'Uncleared', '2 overdue library books unreturned.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(50, 6, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 11:55:00', '2026-07-03 12:18:58', 'Sophia Mendoza'),
(51, 6, 3, 'Uncleared', 'Equipment check in progress.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(52, 6, 4, 'Uncleared', 'Missed required guidance session.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(53, 6, 5, 'Signed', 'Passed the TOEIC exam.', '2026-07-24', 1, '2026-07-03 07:09:00', '2026-07-03 12:18:58', 'Mark Mendoza'),
(54, 6, 6, 'Cleared', 'Passed the Mapua MELT exit exam.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(55, 11, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 11:24:00', '2026-07-03 12:18:58', 'Rochelle Santos'),
(56, 11, 2, 'Uncleared', 'Balance verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(57, 11, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(58, 11, 4, 'Uncleared', 'Missed required guidance session.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(59, 17, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(60, 17, 2, 'Uncleared', 'Pending payment confirmation.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(61, 17, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(62, 17, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 09:19:00', '2026-07-03 12:18:58', 'Mark Mendoza'),
(63, 19, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 10:10:00', '2026-07-03 12:18:58', 'Sophia Mendoza'),
(64, 19, 2, 'Uncleared', 'Outstanding tuition balance.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(65, 19, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 13:03:00', '2026-07-03 12:18:58', 'Rochelle Santos'),
(66, 19, 4, 'Uncleared', 'Guidance requirements incomplete.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(67, 21, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 13:16:00', '2026-07-03 12:18:58', 'Alan Torrentera'),
(68, 21, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 11:33:00', '2026-07-03 12:18:58', 'Mark Mendoza'),
(69, 21, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 09:14:00', '2026-07-03 12:18:58', 'Alan Torrentera'),
(70, 21, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 12:18:58', NULL),
(71, 7, 1, 'Unprocessed', NULL, NULL, 0, NULL, '2026-07-03 12:19:14', NULL),
(72, 7, 2, 'Unprocessed', NULL, NULL, 0, NULL, '2026-07-03 12:19:14', NULL),
(73, 7, 3, 'Unprocessed', NULL, NULL, 0, NULL, '2026-07-03 12:19:14', NULL),
(74, 7, 4, 'Unprocessed', NULL, NULL, 0, NULL, '2026-07-03 12:19:14', NULL),
(75, 7, 5, 'Unprocessed', NULL, NULL, 0, NULL, '2026-07-03 12:19:14', NULL),
(76, 7, 6, 'Unprocessed', NULL, NULL, 0, NULL, '2026-07-03 12:19:14', NULL),
(77, 8, 1, 'Unprocessed', NULL, NULL, 0, NULL, '2026-07-03 12:19:14', NULL),
(78, 8, 2, 'Unprocessed', NULL, NULL, 0, NULL, '2026-07-03 12:19:14', NULL),
(79, 24, 1, 'Unprocessed', NULL, NULL, 0, NULL, '2026-07-03 12:19:14', NULL),
(80, 24, 2, 'Unprocessed', NULL, NULL, 0, NULL, '2026-07-03 12:19:14', NULL),
(81, 62, 2, 'Cleared', 'No outstanding liabilities recorded.', '2026-07-03', 0, NULL, '2026-07-03 15:23:54', NULL),
(82, 62, 5, 'Cleared', 'No outstanding liabilities recorded.', NULL, 0, NULL, '2026-07-03 16:57:59', NULL),
(83, 62, 6, 'Cleared', 'No outstanding liabilities recorded.', '2026-07-23', 0, NULL, '2026-07-03 16:58:01', NULL),
(84, 27, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 10:00:00', '2026-07-03 17:05:53', 'Sophia Mendoza'),
(85, 27, 2, 'Uncleared', 'Outstanding tuition balance.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(86, 27, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 07:52:00', '2026-07-03 17:05:53', 'Alan Torrentera'),
(87, 27, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 13:16:00', '2026-07-03 17:05:53', 'Janice Villanueva'),
(88, 27, 5, 'Signed', 'Passed the TOEIC exam.', '2026-07-24', 1, '2026-07-03 13:47:00', '2026-07-03 17:05:53', 'Sophia Mendoza'),
(89, 27, 6, 'Signed', 'Passed the Mapua MELT exit exam.', '2026-07-24', 1, '2026-07-03 08:35:00', '2026-07-03 17:05:53', 'Sophia Mendoza'),
(90, 28, 1, 'Uncleared', '2 overdue library books unreturned.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(91, 28, 2, 'Uncleared', 'Unpaid miscellaneous fees.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(92, 28, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 07:54:00', '2026-07-03 17:05:53', 'Janice Villanueva'),
(93, 28, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(94, 28, 5, 'Uncleared', 'Has not yet taken the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(95, 28, 6, 'Signed', 'Passed the Mapua MELT exit exam.', '2026-07-24', 1, '2026-07-03 15:51:00', '2026-07-03 17:05:53', 'Sophia Mendoza'),
(96, 29, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 15:16:00', '2026-07-03 17:05:53', 'Alan Torrentera'),
(97, 29, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(98, 29, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(99, 29, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(100, 30, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 16:27:00', '2026-07-03 17:05:53', 'Alan Torrentera'),
(101, 30, 2, 'Uncleared', 'Balance verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(102, 30, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 14:43:00', '2026-07-03 17:05:53', 'Alan Torrentera'),
(103, 30, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 15:25:00', '2026-07-03 17:05:53', 'Janice Villanueva'),
(104, 30, 5, 'Cleared', 'Passed the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(105, 30, 6, 'Signed', 'Passed the Mapua MELT exit exam.', '2026-07-24', 1, '2026-07-03 13:12:00', '2026-07-03 17:05:53', 'Janice Villanueva'),
(106, 31, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 07:09:00', '2026-07-03 17:05:53', 'Sophia Mendoza'),
(107, 31, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 12:58:00', '2026-07-03 17:05:53', 'Mark Mendoza'),
(108, 31, 3, 'Uncleared', 'Unreturned laboratory apparatus.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(109, 31, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(110, 32, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 11:20:00', '2026-07-03 17:05:53', 'Alan Torrentera'),
(111, 32, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 14:44:00', '2026-07-03 17:05:53', 'Sophia Mendoza'),
(112, 32, 3, 'Uncleared', 'Equipment check in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(113, 32, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 08:41:00', '2026-07-03 17:05:53', 'Janice Villanueva'),
(114, 32, 5, 'Signed', 'Passed the TOEIC exam.', '2026-07-24', 1, '2026-07-03 08:12:00', '2026-07-03 17:05:53', 'Alan Torrentera'),
(115, 32, 6, 'Uncleared', 'Exam result verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(116, 33, 1, 'Uncleared', '2 overdue library books unreturned.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(117, 33, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(118, 33, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 10:07:00', '2026-07-03 17:05:53', 'Sophia Mendoza'),
(119, 34, 1, 'Uncleared', 'Missing library clearance slip.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(120, 34, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 09:00:00', '2026-07-03 17:05:53', 'Janice Villanueva'),
(121, 34, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 09:34:00', '2026-07-03 17:05:53', 'Mark Mendoza'),
(122, 34, 5, 'Cleared', 'Passed the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(123, 34, 6, 'Signed', 'Passed the Mapua MELT exit exam.', '2026-07-24', 1, '2026-07-03 08:26:00', '2026-07-03 17:05:53', 'Mark Mendoza'),
(124, 35, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 15:26:00', '2026-07-03 17:05:53', 'Alan Torrentera'),
(125, 35, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 13:00:00', '2026-07-03 17:05:53', 'Rochelle Santos'),
(126, 35, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(127, 35, 4, 'Uncleared', 'Missed required guidance session.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(128, 36, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 07:32:00', '2026-07-03 17:05:53', 'Alan Torrentera'),
(129, 36, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(130, 36, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(131, 36, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(132, 36, 5, 'Cleared', 'Passed the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(133, 36, 6, 'Uncleared', 'Exam result verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(134, 37, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(135, 37, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(136, 37, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 15:25:00', '2026-07-03 17:05:53', 'Rochelle Santos'),
(137, 37, 4, 'Uncleared', 'Awaiting exit interview schedule.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(138, 38, 1, 'Uncleared', 'Missing library clearance slip.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(139, 38, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 14:55:00', '2026-07-03 17:05:53', 'Mark Mendoza'),
(140, 38, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(141, 38, 4, 'Uncleared', 'Guidance requirements incomplete.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(142, 38, 5, 'Uncleared', 'Exam result verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(143, 38, 6, 'Uncleared', 'Exam result verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(144, 39, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(145, 39, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:05:53', NULL),
(146, 39, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(147, 39, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(148, 40, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(149, 40, 2, 'Uncleared', 'Balance verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(150, 40, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(151, 40, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(152, 40, 5, 'Signed', 'Passed the TOEIC exam.', '2026-07-24', 1, '2026-07-03 10:00:00', '2026-07-03 17:08:31', 'Rochelle Santos'),
(153, 40, 6, 'Signed', 'Passed the Mapua MELT exit exam.', '2026-07-24', 1, '2026-07-03 13:34:00', '2026-07-03 17:08:31', 'Mark Mendoza'),
(154, 41, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 09:22:00', '2026-07-03 17:08:31', 'Sophia Mendoza'),
(155, 41, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 08:39:00', '2026-07-03 17:08:31', 'Janice Villanueva'),
(156, 41, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(157, 42, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(158, 42, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 08:50:00', '2026-07-03 17:08:31', 'Janice Villanueva'),
(159, 42, 3, 'Uncleared', 'Unreturned laboratory apparatus.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(160, 42, 4, 'Uncleared', 'Guidance requirements incomplete.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(161, 42, 5, 'Uncleared', 'Has not yet taken the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(162, 42, 6, 'Signed', 'Passed the Mapua MELT exit exam.', '2026-07-24', 1, '2026-07-03 08:32:00', '2026-07-03 17:08:31', 'Janice Villanueva'),
(163, 43, 1, 'Uncleared', 'Book return verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(164, 43, 2, 'Uncleared', 'Outstanding tuition balance.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(165, 43, 3, 'Uncleared', 'Unreturned laboratory apparatus.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(166, 43, 4, 'Uncleared', 'Missed required guidance session.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(167, 44, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 13:00:00', '2026-07-03 17:08:31', 'Rochelle Santos'),
(168, 44, 2, 'Cleared', 'No outstanding liabilities recorded.', '2026-07-24', 0, NULL, '2026-07-03 17:21:24', NULL),
(169, 44, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(170, 44, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 12:49:00', '2026-07-03 17:08:31', 'Alan Torrentera'),
(171, 44, 5, 'Cleared', 'Passed the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-04 01:00:53', NULL),
(172, 44, 6, 'Cleared', 'No outstanding liabilities recorded.', '2026-07-24', 0, NULL, '2026-07-04 01:01:09', NULL),
(173, 45, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(174, 45, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 13:18:00', '2026-07-03 17:08:31', 'Janice Villanueva'),
(175, 45, 3, 'Uncleared', 'Damaged equipment being assessed.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(176, 45, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(177, 46, 1, 'Uncleared', '2 overdue library books unreturned.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(178, 46, 2, 'Uncleared', 'Balance verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(179, 46, 3, 'Uncleared', 'Unreturned laboratory apparatus.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(180, 46, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(181, 46, 5, 'Cleared', 'Passed the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(182, 46, 6, 'Uncleared', 'Exam result verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(183, 47, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 09:39:00', '2026-07-03 17:08:31', 'Rochelle Santos'),
(184, 47, 2, 'Uncleared', 'Balance verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(185, 47, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(186, 48, 1, 'Uncleared', 'Missing library clearance slip.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(187, 48, 2, 'Uncleared', 'Outstanding tuition balance.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(188, 48, 3, 'Cleared', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(189, 48, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 09:11:00', '2026-07-03 17:08:31', 'Sophia Mendoza'),
(190, 48, 5, 'Uncleared', 'Has not yet taken the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(191, 48, 6, 'Signed', 'Passed the Mapua MELT exit exam.', '2026-07-24', 1, '2026-07-03 10:01:00', '2026-07-03 17:08:31', 'Rochelle Santos'),
(192, 49, 1, 'Uncleared', '2 overdue library books unreturned.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(193, 49, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(194, 49, 3, 'Uncleared', 'Damaged equipment being assessed.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(195, 49, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(196, 50, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(197, 50, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(198, 50, 3, 'Uncleared', 'Equipment check in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(199, 50, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 14:03:00', '2026-07-03 17:08:31', 'Mark Mendoza'),
(200, 50, 5, 'Signed', 'Passed the TOEIC exam.', '2026-07-24', 1, '2026-07-03 13:45:00', '2026-07-03 17:08:31', 'Janice Villanueva'),
(201, 50, 6, 'Signed', 'Passed the Mapua MELT exit exam.', '2026-07-24', 1, '2026-07-03 15:53:00', '2026-07-03 17:08:31', 'Janice Villanueva'),
(202, 51, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(203, 51, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(204, 51, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 16:19:00', '2026-07-03 17:08:31', 'Mark Mendoza'),
(205, 51, 4, 'Uncleared', 'Missed required guidance session.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(206, 52, 1, 'Uncleared', 'Book return verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:08:31', NULL),
(207, 52, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 07:40:00', '2026-07-03 17:08:31', 'Mark Mendoza'),
(208, 52, 3, 'Uncleared', 'Unreturned laboratory apparatus.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(209, 52, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(210, 52, 6, 'Uncleared', 'Exam result verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(211, 53, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 15:13:00', '2026-07-03 17:09:48', 'Sophia Mendoza'),
(212, 53, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(213, 53, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 15:33:00', '2026-07-03 17:09:48', 'Mark Mendoza'),
(214, 53, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 08:09:00', '2026-07-03 17:09:48', 'Alan Torrentera'),
(215, 54, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(216, 54, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(217, 54, 3, 'Uncleared', 'Unreturned laboratory apparatus.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(218, 54, 4, 'Uncleared', 'Missed required guidance session.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(219, 54, 5, 'Cleared', 'Passed the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(220, 54, 6, 'Uncleared', 'Exam result verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(221, 55, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 13:22:00', '2026-07-03 17:09:48', 'Sophia Mendoza'),
(222, 55, 2, 'Uncleared', 'Unpaid miscellaneous fees.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(223, 55, 3, 'Uncleared', 'Unreturned laboratory apparatus.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(224, 55, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(225, 56, 1, 'Uncleared', 'Book return verification in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(226, 56, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(227, 56, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 12:19:00', '2026-07-03 17:09:48', 'Mark Mendoza'),
(228, 56, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(229, 56, 5, 'Uncleared', 'Has not yet taken the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(230, 57, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(231, 57, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(232, 57, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 14:58:00', '2026-07-03 17:09:48', 'Alan Torrentera'),
(233, 57, 4, 'Uncleared', 'Guidance requirements incomplete.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(234, 58, 1, 'Uncleared', '2 overdue library books unreturned.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(235, 58, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 16:22:00', '2026-07-03 17:09:48', 'Rochelle Santos'),
(236, 58, 3, 'Uncleared', 'Equipment check in progress.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(237, 58, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 11:48:00', '2026-07-03 17:09:48', 'Mark Mendoza'),
(238, 58, 5, 'Uncleared', 'Has not yet taken the TOEIC exam.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(239, 58, 6, 'Cleared', 'Passed the Mapua MELT exit exam.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(240, 59, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(241, 59, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(242, 60, 1, 'Uncleared', '2 overdue library books unreturned.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(243, 60, 2, 'Uncleared', 'Unpaid miscellaneous fees.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(244, 60, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 13:53:00', '2026-07-03 17:09:48', 'Sophia Mendoza'),
(245, 60, 4, 'Cleared', 'Completed required guidance sessions and exit interview.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(246, 61, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(247, 61, 2, 'Cleared', 'No outstanding tuition or fee balances.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(248, 61, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 11:53:00', '2026-07-03 17:09:48', 'Alan Torrentera'),
(249, 61, 4, 'Uncleared', 'Guidance requirements incomplete.', '2026-07-24', 0, NULL, '2026-07-03 17:09:48', NULL),
(250, 62, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 12:09:00', '2026-07-03 17:09:48', 'Sophia Mendoza'),
(251, 62, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 07:35:00', '2026-07-03 17:11:47', 'Janice Villanueva'),
(252, 62, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 08:43:00', '2026-07-03 17:11:47', 'Alan Torrentera'),
(253, 63, 1, 'Uncleared', '2 overdue library books unreturned.', '2026-07-24', 0, NULL, '2026-07-03 17:11:47', NULL),
(254, 63, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 15:33:00', '2026-07-03 17:11:47', 'Janice Villanueva'),
(255, 63, 3, 'Uncleared', 'Damaged equipment being assessed.', '2026-07-24', 0, NULL, '2026-07-03 17:11:47', NULL),
(256, 63, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 14:54:00', '2026-07-03 17:11:47', 'Alan Torrentera'),
(257, 64, 1, 'Cleared', 'No unreturned books or library materials.', '2026-07-24', 0, NULL, '2026-07-03 17:11:47', NULL),
(258, 64, 2, 'Signed', 'No outstanding tuition or fee balances.', '2026-07-24', 1, '2026-07-03 11:20:00', '2026-07-03 17:11:47', 'Rochelle Santos'),
(259, 64, 3, 'Signed', 'No unreturned or damaged laboratory equipment.', '2026-07-24', 1, '2026-07-03 15:17:00', '2026-07-03 17:11:47', 'Sophia Mendoza'),
(260, 64, 4, 'Signed', 'Completed required guidance sessions and exit interview.', '2026-07-24', 1, '2026-07-03 15:44:00', '2026-07-03 17:11:47', 'Mark Mendoza'),
(261, 64, 6, 'Cleared', 'Passed the Mapua MELT exit exam.', '2026-07-24', 0, NULL, '2026-07-03 17:11:47', NULL),
(262, 65, 1, 'Signed', 'No unreturned books or library materials.', '2026-07-24', 1, '2026-07-03 12:14:00', '2026-07-03 17:11:47', 'Alan Torrentera'),
(263, 65, 2, 'Uncleared', 'Unpaid miscellaneous fees.', '2026-07-24', 0, NULL, '2026-07-03 17:11:47', NULL),
(264, 65, 3, 'Uncleared', 'Unreturned laboratory apparatus.', '2026-07-24', 0, NULL, '2026-07-03 17:11:47', NULL),
(265, 65, 4, 'Uncleared', 'Missed required guidance session.', '2026-07-24', 0, NULL, '2026-07-03 17:11:47', NULL),
(266, 20, 2, 'Uncleared', 'Outstanding tuition balance.', '2026-07-24', 0, NULL, '2026-07-03 17:21:50', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clearance_status`
--
ALTER TABLE `clearance_status`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `uq_student_requirement` (`student_id`,`requirement_id`),
  ADD KEY `requirement_id` (`requirement_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clearance_status`
--
ALTER TABLE `clearance_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=267;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
