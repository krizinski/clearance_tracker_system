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
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `student_no` varchar(15) NOT NULL,
  `student_type` enum('College','Senior High') NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `course` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `student_no`, `student_type`, `last_name`, `first_name`, `middle_name`, `course`, `email`, `password`) VALUES
(1, '2023150241', 'College', 'YOO', 'KALIVER ZERENITY', 'LIM', 'BASS', '2023kzyoo@live.mcl.edu.ph', 'kaliver123'),
(2, '2023154823', 'College', 'HERRERA', 'WYVREN AVERY', 'DIZON', 'BSCE', '2023waherrera@live.mcl.edu.ph', 'wyvren123'),
(3, '2023173291', 'College', 'CHAVEZ', 'NADIA LEE', 'SANTOS', 'BASS', '2023nlchavez@live.mcl.edu.ph', 'nadia123'),
(4, '2023149811', 'College', 'HERMANO', 'YAVI JYLENE', 'GOMEZ', 'BSED', '2023yjhermano@live.mcl.edu.ph', 'yavi123'),
(5, '2023162045', 'College', 'MENDOZA', 'SEVEN GAIZER', 'CRUZ', 'BSCHE', '2023sgmendoza@live.mcl.edu.ph', 'seven123'),
(6, '2023155462', 'College', 'PEREZ', 'JIRO DEVON', 'ALVAREZ', 'BSCOE', '2023jdperez@live.mcl.edu.ph', 'jiro123'),
(7, '2023168874', 'College', 'SALVADOR', 'KRISHANELLE LUCY', 'REYES', 'BSCE', '2023klsalvador@live.mcl.edu.ph', 'krishanelle123'),
(8, '2023151390', 'College', 'SAAVEDRA', 'RILEY JAILLEN', 'TORRES', 'BSEE', '2023rjsaavedra@live.mcl.edu.ph', 'riley123'),
(9, '2023179512', 'College', 'DE MIGUEL', 'SKY EVIAN', 'CASTRO', 'ABCOMM', '2023sedemiguel@live.mcl.edu.ph', 'sky123'),
(10, '2023164089', 'College', 'PACHECO', 'JACE SAVIERO', 'VALENCIA', 'BSDEVCOMM', '2023jspacheco@live.mcl.edu.ph', 'jace123'),
(11, '2027278931', 'Senior High', 'DOMINGO', 'ANGELICA', 'SALAZAR', 'STEM', '2027asdomingo@live.mcl.edu.ph', 'angelica123'),
(12, '2027281044', 'Senior High', 'PASCUAL', 'MIGUEL', 'TORRES', 'STEM', '2027mtpascual@live.mcl.edu.ph', 'miguel123'),
(13, '2027269317', 'Senior High', 'OCAMPO', 'NATHAN', 'AGUILAR', 'STEM', '2027naocampo@live.mcl.edu.ph', 'nathan123'),
(14, '2027273588', 'Senior High', 'SORIANO', 'ISABEL', 'VELASCO', 'STEM', '2027ivsoriano@live.mcl.edu.ph', 'isabel123'),
(15, '2027285602', 'Senior High', 'RAMOS', 'PATRICK', 'FERNANDEZ', 'STEM', '2027pframos@live.mcl.edu.ph', 'patrick123'),
(16, '2023190822', 'College', 'MORAN', 'MICH JERIEL', 'ALCANTARA', 'BSPT', '2023mjamoran@live.mcl.edu.ph', 'mich123'),
(17, '2027214952', 'Senior High', 'FUENTES', 'CYWELL ASHLEIGH', 'BERNARDO', 'ABM', '2027cabfuentes@live.mcl.edu.ph', 'cywell123'),
(18, '2023114958', 'College', 'KANG', 'HEAVEN WYATT', 'CONCEPCION', 'BSED', '2023hwckang@live.mcl.edu.ph', 'heaven123'),
(19, '2027230481', 'Senior High', 'JUAREZ', 'VERONICA JAIDE', 'DELA CRUZ', 'HUMSS', '2027vjdjuarez@live.mcl.edu.ph', 'veronica123'),
(20, '2023184950', 'College', 'ALVAREZ', 'YVONNE JAYDEE', 'ESTRADA', 'BSCOE', '2023yjealvarez@live.mcl.edu.ph', 'yvonne123'),
(21, '2027248102', 'Senior High', 'VERGARA', 'NICHOLAS ETHAN', 'FAJARDO', 'ICT', '2027nefvergara@live.mcl.edu.ph', 'nicholas123'),
(22, '2023105931', 'College', 'SANTIAGO', 'SHELDON MACK', 'GUTIERREZ', 'BSIT', '2023smgsantiago@live.mcl.edu.ph', 'sheldon123'),
(23, '2023155823', 'College', 'HERNANDEZ', 'YAKIRA JAZZ', 'HILARIO', 'BSCS', '2023yjhhernandez@live.mcl.edu.ph', 'yakira123'),
(24, '2027284910', 'Senior High', 'JAVIER', 'CHLOE EZRA', 'IGNACIO', 'ABM', '2027ceijavier@live.mcl.edu.ph', 'chloe123'),
(25, '2023149502', 'College', 'LAURIER', 'HESTIA ALEXIS', 'JAVIER', 'BASS', '2023hajlaurier@live.mcl.edu.ph', 'hestia123'),
(26, '2027210492', 'Senior High', 'MORAN', 'MICHAEL JAVIEN', 'PASCUAL', 'HUMSS', '2027mjkmoran@live.mcl.edu.ph', 'michael123'),
(27, '2023118492', 'College', 'MORAN', 'MIKAELA JERAE', 'LAGMAN', 'BSCHE', '2023mjlmoran@live.mcl.edu.ph', 'mikaela123'),
(28, '2023104921', 'College', 'HERRERA', 'WYVER AVRIELLE', 'MANALILI', 'BSECE', '2023wamherrera@live.mcl.edu.ph', 'wyver123'),
(29, '2027295012', 'Senior High', 'HERRERA', 'ELLIOT ACEY', 'NATIVIDAD', 'ICT', '2027eanherrera@live.mcl.edu.ph', 'elliot123'),
(30, '2023139401', 'College', 'HERRERA', 'RORY TYRELLE', 'OCAMPO', 'BSCOE', '2023rtoherrera@live.mcl.edu.ph', 'rory123'),
(31, '2027218402', 'Senior High', 'HERRERA', 'YVES NIXON', 'PALMA', 'STEM', '2027ynpherrera@live.mcl.edu.ph', 'yves123'),
(32, '2023148591', 'College', 'HERRERA', 'STEEL GAYLE', 'QUINTOS', 'BSCHE', '2023sgqherrera@live.mcl.edu.ph', 'steel123'),
(33, '2027284951', 'Senior High', 'HERRERA', 'DARELL JAY', 'ROXAS', 'HUMSS', '2027djrherrera@live.mcl.edu.ph', 'darell123'),
(34, '2023105942', 'College', 'HERRERA', 'JAXX SYNCLAIR', 'SALAZAR', 'BASS', '2023jssherrera@live.mcl.edu.ph', 'jaxx123'),
(35, '2027248105', 'Senior High', 'YOO', 'KLOVER', 'TAN', 'ICT', '2027ktyoo@live.mcl.edu.ph', 'klover123'),
(36, '2023184930', 'College', 'YOO', 'ELIJAH LYDELL', 'UMALI', 'BSES', '2023eluyoo@live.mcl.edu.ph', 'elijah123'),
(37, '2027218490', 'Senior High', 'AZALEA', 'ELORA AZRIEL', 'VALDEZ', 'STEM', '2027eavazalea@live.mcl.edu.ph', 'elora123'),
(38, '2023148104', 'College', 'FUENTES', 'CHASE MURIEL', 'WONG', 'BSCS', '2023cmwfuentes@live.mcl.edu.ph', 'chase123'),
(39, '2027239401', 'Senior High', 'SALVADOR', 'LAIXELLE JEN', 'JAVIER', 'ABM', '2027ljxsalvador@live.mcl.edu.ph', 'laixelle123'),
(40, '2023148502', 'College', 'SAAVEDRA', 'MADELEINE KATE', 'YAP', 'BSBA', '2023mkysaavedra@live.mcl.edu.ph', 'madeleine123'),
(41, '2027218405', 'Senior High', 'HERRERA', 'ELIXIO HEIDI', 'ZAMORA', 'HUMSS', '2027ehzherrera@live.mcl.edu.ph', 'elixio123'),
(42, '2023118420', 'College', 'DE MIGUEL', 'SEAN SKYLER', 'ALVAREZ', 'BSME', '2023ssademiguel@live.mcl.edu.ph', 'sean123'),
(43, '2027205931', 'Senior High', 'PACHECO', 'JACIEN DRAKE', 'BONDOC', 'STEM', '2027jdbpacheco@live.mcl.edu.ph', 'jacien123'),
(44, '2023118494', 'College', 'ALVAREZ', 'CALYX ARTEMIS', 'CRUZ', 'BSMARE', '2023caealvarez@live.mcl.edu.ph', 'calyx123'),
(45, '2027258391', 'Senior High', 'AZALEA', 'EZEKIEL IVORY', 'DELGADO', 'ICT', '2027eidazalea@live.mcl.edu.ph', 'ezekiel123'),
(46, '2023110482', 'College', 'AZALEA', 'ELTON SAPPHIRE', 'ESPINOSA', 'BSAERO', '2023eseazalea@live.mcl.edu.ph', 'elton123'),
(47, '2027219402', 'Senior High', 'FORD', 'KIERAN SIENNA', 'FLORES', 'ABM', '2027ksfford@live.mcl.edu.ph', 'kieran123'),
(48, '2023119502', 'College', 'TAN', 'RADLEIGH YAEL', 'GOMEZ', 'BSARCH', '2023rytgradleigh@live.mcl.edu.ph', 'radleigh123'),
(49, '2027248195', 'Senior High', 'DAVIS', 'VALERIAN JAIRO', 'HERNANDEZ', 'STEM', '2027vjhdavis@live.mcl.edu.ph', 'valerian123'),
(50, '2023118496', 'College', 'SALVATORE', 'SHAUN HARVEY', 'ILAGAN', 'BSMARE', '2023shisalvatore@live.mcl.edu.ph', 'shaun123'),
(51, '2027258301', 'Senior High', 'IGNACIO', 'ZEUS LEVIATHAN', 'JIMENEZ', 'ICT', '2027zljignacio@live.mcl.edu.ph', 'zeus123'),
(52, '2023184952', 'College', 'WEST', 'CHAOS RAZEN', 'KAPUNAN', 'BSCE', '2023crkwest@live.mcl.edu.ph', 'chaos123'),
(53, '2027210482', 'Senior High', 'PARKER', 'SEBASTIAN HAYDEN', 'LUNA', 'HUMSS', '2027shlparker@live.mcl.edu.ph', 'sebastian123'),
(54, '2023118459', 'College', 'HERRERA', 'ALEXAVIER TYREE', 'MEDINA', 'BAPOLSCI', '2023atmherrera@live.mcl.edu.ph', 'alexavier123'),
(55, '2027248106', 'Senior High', 'HERRERA', 'KIARA ALESSIO', 'NAVARRO', 'ABM', '2027kanherrera@live.mcl.edu.ph', 'kiara123'),
(56, '2023114859', 'College', 'BAUTISTA', 'BRIELLE AUDREY', 'ORTEGA', 'BSN', '2023baobautista@live.mcl.edu.ph', 'brielle123'),
(57, '2027219405', 'Senior High', 'AZALEA', 'YUWELL JANE', 'PANGANIBAN', 'STEM', '2027yjpazalea@live.mcl.edu.ph', 'yuwell123'),
(58, '2023184024', 'College', 'AZALEA', 'HERA AUDRIELLE', 'QUISON', 'BSIT', '2023haqazalea@live.mcl.edu.ph', 'hera123'),
(59, '2027258394', 'Senior High', 'AZALEA', 'GERALD', 'REYES', 'HUMSS', '2027grazalea@live.mcl.edu.ph', 'gerald123'),
(60, '2023119504', 'College', 'AZALEA', 'ELIJAH TOPAZ', 'SANTIAGO', 'BSMEDTECH', '2023etsazalea@live.mcl.edu.ph', 'elijah123'),
(61, '2027248197', 'Senior High', 'LARSON', 'JAVION NOAH', 'TOLENTINO', 'ABM', '2027jntlarson@live.mcl.edu.ph', 'javion123'),
(62, '2023118598', 'College', 'ADLER', 'JETT MAVERICK', 'UMALI', 'BSMEDTECH', '2023jmuadler@live.mcl.edu.ph', 'jett123'),
(63, '2027258310', 'Senior High', 'YOO', 'KALVIN ZACHARY', 'VILLANUEVA', 'STEM', '2027kzvyoo@live.mcl.edu.ph', 'kalvin123'),
(64, '2023119408', 'College', 'HERRERA', 'WAYNE AIDEN', 'ROMERO', 'BSARCH', '2023wawherrera@live.mcl.edu.ph', 'wayne123'),
(65, '2027258104', 'Senior High', 'HERRERA', 'ERIN AGATHA', 'JAVIER', 'HUMSS', '2027eaxherrera@live.mcl.edu.ph', 'erin123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `student_no` (`student_no`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
