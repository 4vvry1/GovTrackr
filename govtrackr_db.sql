SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `govtrackr`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `govtrackr`;

-- ── CANDIDATES ─────────────────────────────────────────────
CREATE TABLE `candidates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(150) NOT NULL,
  `position` varchar(100) NOT NULL,
  `college` varchar(150) DEFAULT NULL,
  `partylist_id` int(11) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `platform` text DEFAULT NULL,
  `year_level` varchar(20) DEFAULT NULL,
  `course` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `partylist_id` (`partylist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `candidates` (`id`, `full_name`, `position`, `college`, `partylist_id`, `photo`, `bio`, `platform`, `year_level`, `course`, `created_at`) VALUES
(1, '𝗖𝘂𝘆𝘂𝗴𝗮𝗻, Sophia Nicole B.', 'President', NULL, 1, 'assets/uploads/cand_1774016234_952.jpg', '', '', '', '', '2026-03-20 13:46:14'),
(2, '𝗠𝗶𝗹𝗹𝗮𝗺𝗮, Leister Benedict M.', 'Vice-President', NULL, 2, 'assets/uploads/cand_1774016259_956.jpg', '', '', '', '', '2026-03-20 13:46:33'),
(3, '𝗦𝘂𝘀𝗶, Jeo Patrick N.', 'Vice-President', NULL, 1, 'assets/uploads/cand_1774016253_285.jpg', '', '', '', '', '2026-03-20 13:46:47'),
(4, '𝐀𝐝𝐫𝐢𝐚𝐧𝐨, Earl Lawrence B.', 'Director', NULL, 2, 'assets/uploads/cand_1774016301_288.jpg', '', '', '', '', '2026-03-20 13:47:09'),
(5, '𝐀𝐪𝐮𝐢𝐧𝐨, Francis Jay M.', 'Director', NULL, 2, 'assets/uploads/cand_1774016288_114.jpg', '', '', '', '', '2026-03-20 13:47:20'),
(6, '𝐁𝐚𝐥𝐝𝐞𝐦𝐨𝐫, Anne Gethro C.', 'Director', NULL, 1, 'assets/uploads/cand_1774016310_654.jpg', '', '', '', '', '2026-03-20 13:47:37'),
(7, '𝐁𝐚𝐮𝐭𝐢𝐬𝐭𝐚, Murphy C.', 'Director', NULL, 1, 'assets/uploads/cand_1774016324_906.jpg', '', '', '', '', '2026-03-20 13:47:49'),
(8, '𝐂𝐚𝐛𝐮𝐧𝐚𝐠𝐚𝐧, Emmanuel Josef C.', 'Director', NULL, 2, 'assets/uploads/cand_1774016331_268.jpg', '', '', '', '', '2026-03-20 13:48:13'),
(9, '𝐂𝐚𝐭𝐚𝐜𝐮𝐭𝐚𝐧, Josh Dyian A.', 'Director', NULL, 1, 'assets/uploads/cand_1774016376_718.jpg', '', '', '', '', '2026-03-20 13:48:27'),
(10, '𝐄𝐧𝐫𝐢𝐪𝐮𝐞𝐳, Ian Carlo B.', 'Director', NULL, 1, 'assets/uploads/cand_1774016317_486.jpg', '', '', '', '', '2026-03-20 13:48:46'),
(11, '𝐌𝐚𝐧𝐬𝐨𝐧, Amirah Nicole N.', 'Director', NULL, 1, 'assets/uploads/cand_1774016282_590.jpg', '', '', '', '', '2026-03-20 13:49:03'),
(12, '𝐍𝐢𝐞𝐭𝐞𝐬, Julius Christian D.', 'Director', NULL, 1, 'assets/uploads/cand_1774016295_266.jpg', '', '', '', '', '2026-03-20 13:49:16'),
(13, '𝐏𝐚𝐥𝐦𝐚, Jose Alfonso F.', 'Director', NULL, 1, 'assets/uploads/cand_1774016270_292.jpg', '', '', '', '', '2026-03-20 13:49:30'),
(14, '𝐒𝐚𝐰𝐚𝐥𝐥𝐢𝐜𝐡, Lara Tabitha Maureen', 'Director', NULL, 2, 'assets/uploads/cand_1774016392_335.jpg', '', '', '', '', '2026-03-20 13:49:46'),
(15, '𝐓𝐮𝐛𝐢𝐠, Sabrina Halley Zem P.', 'Director', NULL, 1, 'assets/uploads/cand_1774016276_120.jpg', '', '', '', '', '2026-03-20 13:49:59'),
(16, '𝗗𝗮𝘁𝘂𝗺𝗮𝗻𝗼𝗻𝗴, Amira U.', 'University Wide Senator', NULL, 1, 'assets/uploads/cand_1774016430_123.jpg', '', '', '', '', '2026-03-20 13:50:26'),
(17, '𝗡𝗶𝗰𝗼𝗹𝗮𝘀, Vince Andrew L.', 'University Wide Senator', NULL, NULL, 'assets/uploads/cand_1774016411_172.jpg', '', '', '', '', '2026-03-20 13:50:40'),
(18, '𝗣𝗮𝗻𝗹𝗶𝗹𝗶𝗼, Justin Cyden P.', 'University Wide Senator', NULL, 1, 'assets/uploads/cand_1774016417_644.jpg', '', '', '', '', '2026-03-20 13:50:51'),
(19, '𝗧𝗮𝗷𝗼𝗻𝗲𝗿𝗮, Wilfred Julian D.J.', 'University Wide Senator', NULL, 2, 'assets/uploads/cand_1774016424_186.jpg', '', '', '', '', '2026-03-20 13:51:05'),
(20, '𝗩𝗲𝗿𝗮𝗱𝗼𝗿, Jeanne Dennise M.', 'University Wide Senator', NULL, 2, 'assets/uploads/cand_1774016405_673.jpg', '', '', '', '', '2026-03-20 13:51:20'),
(21, '𝗘𝘀𝗾𝘂𝗶𝘃𝗲𝗹, Francheska Lourde D.', 'Senator', 'School of Arts and Sciences', NULL, 'assets/uploads/cand_1774017265_930.jpg', '', '', '', '', '2026-03-20 13:51:44'),
(22, '𝗠𝗮𝗻𝗮𝗹𝗮𝗱, Alicia Mae L.', 'Senator', 'School of Business and Accountancy', 3, 'assets/uploads/cand_1774017273_474.jpg', '', '', '', '', '2026-03-20 13:52:03'),
(23, '𝗢𝗹𝗽𝗶𝗻𝗱𝗼 𝗜𝗩, Francisco V.', 'Senator', 'School of Computing', 2, 'assets/uploads/cand_1774017280_986.jpg', '', '', '', '', '2026-03-20 13:52:23'),
(24, '𝗦𝗶𝗹𝘃𝗮, Cuyler S.', 'Senator', 'School of Engineering and Architecture', 1, 'assets/uploads/cand_1774017287_955.jpg', '', '', '', '', '2026-03-20 13:52:42'),
(25, '𝗖𝗼𝗹𝗶𝘀, Jenaica C.', 'Senator', 'School of Nursing and Allied Medical Sciences', 2, 'assets/uploads/cand_1774017295_609.jpg', '', '', '', '', '2026-03-20 13:53:03'),
(26, '𝗥𝗮𝗺𝗼𝘀, Ria Kathleen F.', 'Governor', 'College of Criminal Justice Education and Forensics', 2, 'assets/uploads/cand_1774016519_280.jpg', '', '', '', '', '2026-03-20 13:53:31'),
(27, '𝗥𝗼𝗱𝗶𝗹, Ikeisha Beatriz S.', 'Vice-Governor', 'College of Criminal Justice Education and Forensics', 2, 'assets/uploads/cand_1774016699_589.jpg', '', '', '', '', '2026-03-20 13:53:50'),
(28, '𝐁𝐞𝐥𝐢𝐧𝐚𝐫𝐢𝐨, Angel Kate P.', 'Councilor', 'College of Criminal Justice Education and Forensics', 2, 'assets/uploads/cand_1774016849_500.jpg', '', '', '', '', '2026-03-20 13:54:07'),
(29, '𝐋𝐮𝐦𝐚𝐧𝐨𝐠, Elmiera C.', 'Councilor', 'College of Criminal Justice Education and Forensics', 2, 'assets/uploads/cand_1774016835_528.jpg', '', '', '', '', '2026-03-20 13:54:21'),
(30, '𝐑𝐢𝐝𝐮𝐜𝐚, Mary Joy J.', 'Councilor', 'College of Criminal Justice Education and Forensics', 2, 'assets/uploads/cand_1774016829_697.jpg', '', '', '', '', '2026-03-20 13:54:34'),
(31, '𝐓𝐚𝐛𝐨𝐚𝐝𝐚, Ley Lorie J.', 'Councilor', 'College of Criminal Justice Education and Forensics', 2, 'assets/uploads/cand_1774016843_108.jpg', '', '', '', '', '2026-03-20 13:54:47'),
(32, '𝐓𝐢𝐦𝐚𝐢𝐨, Julia Rusziel D.', 'Councilor', 'College of Criminal Justice Education and Forensics', 2, 'assets/uploads/cand_1774016817_571.jpg', '', '', '', '', '2026-03-20 13:55:02'),
(33, '𝐕𝐢𝐥𝐥𝐚𝐧𝐮𝐞𝐯𝐚, Jason H.', 'Councilor', 'College of Criminal Justice Education and Forensics', 2, 'assets/uploads/cand_1774016855_283.jpg', '', '', '', '', '2026-03-20 13:55:12'),
(34, '𝗦𝘂𝗮𝘃𝗲𝗿𝗱𝗲𝘇, Jan Angelo L.', 'Governor', 'School of Arts and Sciences', 1, 'assets/uploads/cand_1774016529_376.jpg', '', '', '', '', '2026-03-20 13:55:35'),
(35, '𝗢𝗰𝗮𝗺𝗽𝗼, Loislane A.', 'Vice-Governor', 'School of Arts and Sciences', 1, 'assets/uploads/cand_1774016711_165.jpg', '', '', '', '', '2026-03-20 13:55:50'),
(36, '𝗗𝗮𝘃𝗶𝗱, Micah I.', 'Councilor', 'School of Arts and Sciences', 1, 'assets/uploads/cand_1774016894_449.jpg', '', '', '', '', '2026-03-20 13:56:09'),
(37, '𝗗𝗶𝘇𝗼𝗻, Carmela Dhane P.', 'Councilor', 'School of Arts and Sciences', 1, 'assets/uploads/cand_1774016877_801.jpg', '', '', '', '', '2026-03-20 13:56:24'),
(38, '𝗗𝗶𝘇𝗼𝗻, Chryssleene Niele T.', 'Councilor', 'School of Arts and Sciences', 1, 'assets/uploads/cand_1774016886_565.jpg', '', '', '', '', '2026-03-20 13:56:35'),
(39, '𝗙𝗹𝗼𝗿𝗲𝘀, Alec Graciella K.', 'Councilor', 'School of Arts and Sciences', 1, 'assets/uploads/cand_1774016899_871.jpg', '', '', '', '', '2026-03-20 13:56:55'),
(40, '𝗩𝗶𝗼𝗷𝗮𝗻, Rheycel Joy Q.', 'Councilor', 'School of Arts and Sciences', 1, 'assets/uploads/cand_1774016907_241.jpg', '', '', '', '', '2026-03-20 13:57:11'),
(41, '𝗬𝘂, Sydney Dhanae S.', 'Councilor', 'School of Arts and Sciences', 1, 'assets/uploads/cand_1774016871_948.jpg', '', '', '', '', '2026-03-20 13:57:25'),
(42, '𝐀𝐧𝐠𝐞𝐥𝐞𝐬, Lance Miguel L.', 'Governor', 'School of Business and Accountancy', 3, 'assets/uploads/cand_1774016553_141.jpg', '', '', '', '', '2026-03-20 13:58:04'),
(43, '𝐎𝐜𝐚𝐦𝐩𝐨, Kryschia Hann A.', 'Governor', 'School of Business and Accountancy', 1, 'assets/uploads/cand_1774016547_513.jpg', '', '', '', '', '2026-03-20 13:58:18'),
(44, '𝐒𝐢𝐬𝐨𝐧, Jumala S.', 'Vice-Governor', 'School of Business and Accountancy', 3, 'assets/uploads/cand_1774016734_916.jpg', '', '', '', '', '2026-03-20 13:58:33'),
(45, '𝐓𝐮𝐫𝐥𝐚, Aaliyah Jillian M.', 'Vice-Governor', 'School of Business and Accountancy', 1, 'assets/uploads/cand_1774016642_867.jpg', '', '', '', '', '2026-03-20 13:58:44'),
(46, '𝐀𝐠𝐮𝐢𝐥𝐨, Renz Rage A.', 'Councilor', 'School of Business and Accountancy', 3, 'assets/uploads/cand_1774016925_306.jpg', '', '', '', '', '2026-03-20 13:59:01'),
(47, '𝐃𝐚𝐭𝐮, Niña Genesis V.', 'Councilor', 'School of Business and Accountancy', 3, 'assets/uploads/cand_1774016918_283.jpg', '', '', '', '', '2026-03-20 13:59:17'),
(48, '𝐌𝐚𝐧𝐚𝐥𝐨, Ysabella L.', 'Councilor', 'School of Business and Accountancy', 3, 'assets/uploads/cand_1774016930_353.jpg', '', '', '', '', '2026-03-20 13:59:32'),
(49, '𝐌𝐞𝐫𝐜𝐚𝐝𝐨, Trisheane Erica L.', 'Councilor', 'School of Business and Accountancy', 3, 'assets/uploads/cand_1774016949_116.jpg', '', '', '', '', '2026-03-20 13:59:47'),
(50, '𝐍𝐚𝐜𝐢𝐨𝐧𝐚𝐥, Keana Milleret G.', 'Councilor', 'School of Business and Accountancy', 3, 'assets/uploads/cand_1774016954_852.jpg', '', '', '', '', '2026-03-20 13:59:57'),
(51, '𝐏𝐚𝐧𝐠𝐢𝐥𝐢𝐧𝐚𝐧, Chelsey Althea S.', 'Councilor', 'School of Business and Accountancy', 3, 'assets/uploads/cand_1774016960_439.jpg', '', '', '', '', '2026-03-20 14:00:09'),
(52, '𝐒𝐮𝐫𝐚𝐥𝐭𝐚, Mark Dyniel Hilton C.', 'Councilor', 'School of Business and Accountancy', 3, 'assets/uploads/cand_1774016937_831.jpg', '', '', '', '', '2026-03-20 14:00:23'),
(53, '𝐓𝐢𝐧𝐠𝐬𝐨𝐧, Narelyn A.', 'Councilor', 'School of Business and Accountancy', 3, 'assets/uploads/cand_1774016943_615.jpg', '', '', '', '', '2026-03-20 14:00:46'),
(54, '𝗢𝗿𝗮𝘆𝗲, Louise Justine J.', 'Governor', 'School of Computing', 2, 'assets/uploads/cand_1774016566_364.jpg', '', '', '', '', '2026-03-20 14:01:04'),
(55, '𝗦𝗮𝗻𝗰𝗵𝗲𝘇, Dannah Mikayla M.', 'Vice-Governor', 'School of Computing', 2, 'assets/uploads/cand_1774016742_587.jpg', '', '', '', '', '2026-03-20 14:01:19'),
(56, '𝗕𝗮𝘆𝗮𝗻𝗶, Mary Rose I.', 'Councilor', 'School of Computing', 2, 'assets/uploads/cand_1774017000_425.jpg', '', '', '', '', '2026-03-20 14:01:35'),
(57, '𝗕𝗲𝗷𝗲𝗰, Jethro Mark D.', 'Councilor', 'School of Computing', 2, 'assets/uploads/cand_1774016985_305.jpg', '', '', '', '', '2026-03-20 14:01:47'),
(58, '𝗗𝘂𝗺𝗮𝘀, Kitt Angelu P.', 'Councilor', 'School of Computing', 2, 'assets/uploads/cand_1774016990_318.jpg', '', '', '', '', '2026-03-20 14:01:57'),
(59, '𝗢𝘀𝗵𝗶𝗺𝗮, Yukinichi C.', 'Councilor', 'School of Computing', 1, 'assets/uploads/cand_1774017005_729.jpg', '', '', '', '', '2026-03-20 14:02:08'),
(60, '𝗣𝗿𝗶𝗻𝗶𝗲𝗹, Shannon Kyle A.', 'Councilor', 'School of Computing', 2, 'assets/uploads/cand_1774017016_867.jpg', '', '', '', '', '2026-03-20 14:02:23'),
(61, '𝗦𝗮𝗴𝘂𝗻, Camiyah Lei U.', 'Councilor', 'School of Computing', 2, 'assets/uploads/cand_1774016978_632.jpg', '', '', '', '', '2026-03-20 14:02:34'),
(62, '𝗦𝗮𝗿𝗺𝗶𝗲𝗻𝘁𝗼, Maria Anne Joy T.', 'Councilor', 'School of Computing', 2, 'assets/uploads/cand_1774017028_998.jpg', '', '', '', '', '2026-03-20 14:02:50'),
(63, '𝗧𝗮𝗯𝗶𝗻𝗮𝘀, Dominique Noreen Y.', 'Councilor', 'School of Computing', 2, 'assets/uploads/cand_1774017011_721.jpg', '', '', '', '', '2026-03-20 14:03:02'),
(64, '𝗩𝗶𝗰𝘁𝗼𝗿𝗶𝗮, Loven Ponce P.', 'Councilor', 'School of Computing', 2, 'assets/uploads/cand_1774017022_911.jpg', '', '', '', '', '2026-03-20 14:03:26'),
(65, '𝗡𝘂𝗰𝘂𝗺, Kyran Churchille S.', 'Governor', 'School of Education', 4, 'assets/uploads/cand_1774016577_338.jpg', '', '', '', '', '2026-03-20 14:03:48'),
(66, '𝗤𝘂𝗶𝗰𝗵𝗼, Leina Maryam R.', 'Vice-Governor', 'School of Education', 4, 'assets/uploads/cand_1774016752_106.jpg', '', '', '', '', '2026-03-20 14:04:03'),
(67, '𝗗𝗶𝘇𝗼𝗻, James Raphael P.', 'Councilor', 'School of Education', 4, 'assets/uploads/cand_1774017067_184.jpg', '', '', '', '', '2026-03-20 14:04:21'),
(68, '𝗟𝗮𝘅𝗮, Ashlee Princess Q.', 'Councilor', 'School of Education', 4, 'assets/uploads/cand_1774017060_470.jpg', '', '', '', '', '2026-03-20 14:04:34'),
(69, '𝗠𝗮𝗹𝗼𝗻𝘇𝗼, Marc Francoise C.', 'Councilor', 'School of Education', 4, 'assets/uploads/cand_1774017073_922.jpg', '', '', '', '', '2026-03-20 14:04:46'),
(70, '𝗕𝗮𝗿𝘁𝗼𝗹𝗼𝗺𝗲, Kamla Shaeena V.', 'Governor', 'School of Engineering and Architecture', 2, 'assets/uploads/cand_1774016595_897.jpg', '', '', '', '', '2026-03-20 14:05:08'),
(71, '𝗬𝗮𝗯𝘂𝘁, Princey Athan Deiondre R.', 'Governor', 'School of Engineering and Architecture', 1, 'assets/uploads/cand_1774016588_189.jpg', '', '', '', '', '2026-03-20 14:05:20'),
(72, '𝗖𝗮𝗻𝗹𝗮𝘀, China M.', 'Vice-Governor', 'School of Engineering and Architecture', 2, 'assets/uploads/cand_1774016773_226.jpg', '', '', '', '', '2026-03-20 14:05:40'),
(73, '𝗣𝗮𝗻𝗴𝗶𝗹𝗶𝗻𝗮𝗻, Johnessa Nicole S.', 'Vice-Governor', 'School of Engineering and Architecture', 1, 'assets/uploads/cand_1774016779_709.jpg', '', '', '', '', '2026-03-20 14:05:52'),
(74, '𝗔𝘀𝗶𝗿𝗼𝘁, Jessica P.', 'Councilor', 'School of Engineering and Architecture', 2, 'assets/uploads/cand_1774017111_240.jpg', '', '', '', '', '2026-03-20 14:06:09'),
(75, '𝗔𝘆𝘀𝗼𝗻, John Nhielsen C.', 'Councilor', 'School of Engineering and Architecture', 2, 'assets/uploads/cand_1774017104_473.jpg', '', '', '', '', '2026-03-20 14:06:21'),
(76, '𝗖𝗮𝗱𝗼𝗻𝗱𝗼𝗻, Reianna Dehrin L.', 'Councilor', 'School of Engineering and Architecture', 2, 'assets/uploads/cand_1774017145_731.jpg', '', '', '', '', '2026-03-20 14:06:33'),
(77, '𝗗𝗲𝗹𝗮 𝗖𝗿𝘂𝘇, Jannah Rose V.', 'Councilor', 'School of Engineering and Architecture', 1, 'assets/uploads/cand_1774017094_348.jpg', '', '', '', '', '2026-03-20 14:06:46'),
(78, '𝗘𝘀𝗽𝗶𝗻𝗼𝘀𝗮, Enzo G.', 'Councilor', 'School of Engineering and Architecture', 1, 'assets/uploads/cand_1774017139_148.jpg', '', '', '', '', '2026-03-20 14:06:58'),
(79, '𝗟𝗶𝗺, Nash Roswell S.', 'Councilor', 'School of Engineering and Architecture', 1, 'assets/uploads/cand_1774017087_556.jpg', '', '', '', '', '2026-03-20 14:07:10'),
(80, '𝗠𝗲𝗻𝗱𝗼𝘇𝗮, Aeriel Morel L.', 'Councilor', 'School of Engineering and Architecture', 2, 'assets/uploads/cand_1774017123_526.jpg', '', '', '', '', '2026-03-20 14:07:23'),
(81, '𝗠𝗲𝗻𝗱𝗼𝘇𝗮, Marl Joseph B.', 'Councilor', 'School of Engineering and Architecture', 2, 'assets/uploads/cand_1774017133_790.jpg', '', '', '', '', '2026-03-20 14:07:34'),
(82, '𝗢𝗰𝗮𝗺𝗽𝗼, Kristanlee C.', 'Councilor', 'School of Engineering and Architecture', 2, 'assets/uploads/cand_1774017118_973.jpg', '', '', '', '', '2026-03-20 14:07:47'),
(83, '𝗣𝗼𝗹𝗶𝗰𝗮𝗿𝗽𝗶𝗼, Jian Carl M.', 'Councilor', 'School of Engineering and Architecture', 2, 'assets/uploads/cand_1774017153_740.jpg', '', '', '', '', '2026-03-20 14:08:00'),
(84, '𝗥𝗼𝗱𝗶𝗹, Argel Rayniel L.', 'Councilor', 'School of Engineering and Architecture', 1, 'assets/uploads/cand_1774017099_347.jpg', '', '', '', '', '2026-03-20 14:08:15'),
(85, '𝗠𝗼𝗹𝗶𝗻𝗮, Vhince Patrick C.', 'Governor', 'School of Hospitality and Tourism Management', 2, 'assets/uploads/cand_1774016658_775.jpg', '', '', '', '', '2026-03-20 14:08:34'),
(86, '𝗣𝗮𝘆𝗮𝘄𝗮𝗹, Michael Angelo D.', 'Governor', 'School of Hospitality and Tourism Management', 1, 'assets/uploads/cand_1774016664_190.jpg', '', '', '', '', '2026-03-20 14:08:45'),
(87, '𝗗𝗶𝘇𝗼𝗻, Klein A.', 'Vice-Governor', 'School of Hospitality and Tourism Management', 1, 'assets/uploads/cand_1774016789_211.jpg', '', '', '', '', '2026-03-20 14:08:58'),
(88, '𝗖𝗮𝗻𝗹𝗮𝗽𝗮𝗻, Sabriah Nicole B.', 'Councilor', 'School of Hospitality and Tourism Management', 1, 'assets/uploads/cand_1774017208_376.jpg', '', '', '', '', '2026-03-20 14:09:16'),
(89, '𝗖𝗮𝘆𝗮𝗻𝗮𝗻, Mitch Kylie Cheryl M.', 'Councilor', 'School of Hospitality and Tourism Management', 1, 'assets/uploads/cand_1774017192_379.jpg', '', '', '', '', '2026-03-20 14:09:27'),
(90, '𝗗𝗲 𝗠𝗮𝘁𝗮, Andrea Nicole D.', 'Councilor', 'School of Hospitality and Tourism Management', 1, 'assets/uploads/cand_1774017173_140.jpg', '', '', '', '', '2026-03-20 14:09:41'),
(91, '𝗗𝗶𝘇𝗼𝗻, Mia Jean U.', 'Councilor', 'School of Hospitality and Tourism Management', 1, 'assets/uploads/cand_1774017181_798.jpg', '', '', '', '', '2026-03-20 14:09:52'),
(92, '𝗚𝗲𝗻𝗲𝗿𝗮𝗹𝗼, James Vincent L.', 'Councilor', 'School of Hospitality and Tourism Management', 1, 'assets/uploads/cand_1774017198_542.jpg', '', '', '', '', '2026-03-20 14:10:03'),
(93, '𝗧𝗮𝘆𝗮𝗴, Mikaela Maxinne B.', 'Councilor', 'School of Hospitality and Tourism Management', 1, 'assets/uploads/cand_1774017187_752.jpg', '', '', '', '', '2026-03-20 14:10:16'),
(94, '𝗥𝗮𝗺𝗶𝗿𝗲𝘇, Sofia Aeshley M.', 'Governor', 'School of Nursing and Allied Medical Sciences', 2, 'assets/uploads/cand_1774016673_149.jpg', '', '', '', '', '2026-03-20 14:10:36'),
(95, '𝗠𝗮𝗿𝗾𝘂𝗲𝘇, Steffanie Nicole Hann L.', 'Vice-Governor', 'School of Nursing and Allied Medical Sciences', 2, 'assets/uploads/cand_1774016799_980.jpg', '', '', '', '', '2026-03-20 14:10:51'),
(96, '𝗔𝗾𝘂𝗶𝗻𝗼, Harvey Rose S.', 'Councilor', 'School of Nursing and Allied Medical Sciences', 2, 'assets/uploads/cand_1774017233_873.jpg', '', '', '', '', '2026-03-20 14:11:05'),
(97, '𝗖𝗮𝗹𝗺𝗮, Rameses S.', 'Councilor', 'School of Nursing and Allied Medical Sciences', 2, 'assets/uploads/cand_1774017223_932.jpg', '', '', '', '', '2026-03-20 14:11:16'),
(98, '𝗚𝗮𝗹𝗮𝗻𝗴, Elisha Jaira S.', 'Councilor', 'School of Nursing and Allied Medical Sciences', 2, 'assets/uploads/cand_1774017228_160.jpg', '', '', '', '', '2026-03-20 14:11:28'),
(99, '𝗟𝗶𝗺𝗶𝗮𝗰, John Rafael T.', 'Councilor', 'School of Nursing and Allied Medical Sciences', 2, 'assets/uploads/cand_1774017238_994.jpg', '', '', '', '', '2026-03-20 14:11:39'),
(100, '𝗥𝗲𝗴𝗮𝗹𝗮, Jonilou Jaymee F.', 'Councilor', 'School of Nursing and Allied Medical Sciences', 2, 'assets/uploads/cand_1774017243_679.jpg', '', '', '', '', '2026-03-20 14:11:50'),
(101, '𝗩𝗶𝗹𝗹𝗮𝗺𝘂𝗰𝗵𝗼, Natalie Nicole D.', 'Councilor', 'School of Nursing and Allied Medical Sciences', 2, 'assets/uploads/cand_1774017249_305.jpg', '', '', '', '', '2026-03-20 14:12:03');

-- ── ELECTION SETTINGS ──────────────────────────────────────
CREATE TABLE `election_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `election_name` varchar(200) DEFAULT 'HAULALAN 2026',
  `is_open` tinyint(1) DEFAULT 0,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `election_settings` (`id`, `election_name`, `is_open`, `start_date`, `end_date`, `updated_at`) VALUES
(1, 'HAULALAN 2026', 0, NULL, NULL, '2026-03-20 03:05:24');

-- ── EVENTS ─────────────────────────────────────────────────
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `event_date` date NOT NULL,
  `event_time` time DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── PARTYLISTS ─────────────────────────────────────────────
CREATE TABLE `partylists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `description` text DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `partylists` (`id`, `name`, `description`, `logo`, `created_at`) VALUES
(1, 'Tindig', 'Limang taon ng paninindigan.\r\nLimang taon ng pakikibaka.\r\nLimang taon ng paglilingkod.\r\n\r\nNagbago man ang ihip ng panahon, nag-iba man ang direksyon, at saan man tayo dalhin ng bukas, sa inyo pa rin ang aming puso, sa inyo pa rin ang aming paninindigan, sa inyo pa rin kami tataya, Angelites.\r\n\r\n#TindigHAU2026\r\n#PatuloyAngPagTINDIG\r\n#SaInyoPaRinTatayaAngelites', 'assets/uploads/pl_1774016361.jpg', '2026-03-20 13:42:47'),
(2, 'Sulung', '𝗣𝗮𝗿𝗮 𝘀𝗮 𝗽𝗿𝗼𝗴𝗿𝗲𝘀𝗶𝗯𝗼, 𝗮𝗸𝘁𝗶𝗯𝗼, 𝗮𝘁 𝗺𝗮𝗸𝗮𝗺𝗮𝘀𝗮𝗻𝗴 𝘀𝗲𝗿𝗯𝗶𝘀𝘆𝗼!\r\n\r\nNarito na ang sagisag ng ating paninindigan!\r\n\r\nAng anghel ay simbolo ng gabay at pamumunong may direksyon. Ang bata ay kumakatawan sa bawat estudyante—ang tinig at pag-asa ng komunidad. Nakatingin ang bata sa anghel bilang tanda ng tiwala. Nakaturo ang anghel pasulong bilang paalala na ang liderato ay dapat may malinaw na landas.\r\n\r\nAng ating kulay na ginto ay sagisag ng dangal, kahusayan, at mataas na pamantayan ng serbisyo.\r\n\r\nIto ang aming pagkatao, at ito ang aming pangako.\r\n\r\n𝗔𝗻𝗴𝗲𝗹𝗶𝘁𝗲𝘀, 𝘀𝘂𝗺𝘂𝗹𝗼𝗻𝗴 𝘁𝗮𝘆𝗼!', 'assets/uploads/pl_1774016356.jpg', '2026-03-20 13:43:05'),
(3, 'Lualu', 'Kahit gaano pa kalakas ang alon, may lideratong hinding-hindi kayo iiwan. Ang 𝙇𝙐𝘼𝙇𝙐 ay hindi mawawala, dahil ang paglalayag na ito, sainyo naka-sentro, Dolphins. 🐬⚓\r\n\r\n𝙎𝙚𝙧𝙗𝙞𝙨𝙮𝙤𝙣𝙜 𝙝𝙞𝙣𝙙𝙞 𝙨𝙚𝙖𝙨𝙤𝙣𝙖𝙡, 𝙝𝙞𝙣𝙙𝙞 𝙥𝙖𝙨𝙨𝙚𝙧𝙗𝙮. 𝙎𝙚𝙧𝙗𝙞𝙨𝙮𝙤𝙣𝙜 𝙩𝙪𝙢𝙖𝙩𝙖𝙜𝙖𝙠𝙩𝙖𝙠, 𝙩𝙪𝙢𝙖𝙩𝙖𝙩𝙖𝙠.\r\n\r\n#HAUlalan2026\r\n#Lualu', 'assets/uploads/pl_1774016347.jpg', '2026-03-20 13:44:43'),
(4, 'Sulagpo', '𝐒𝐚𝐥𝐚𝐧𝐠𝐢 𝐤𝐚, 𝐒𝐮𝐥𝐚𝐠𝐩𝐨 𝐤𝐚! 💙🪽\r\nWith hearts aligned and minds nurtured, 𝗦𝗨𝗟𝗔𝗚𝗣𝗢 transforms into a renewed icon of transcendence, in the wondrous journey of the 𝙎𝙘𝙝𝙤𝙤𝙡 𝙤𝙛 𝙀𝙙𝙪𝙘𝙖𝙩𝙞𝙤𝙣.\r\n\r\nThough rebranded, SULAGPO maintains its culture as it strengthens its purpose in the service of student-teacher-leadership.\r\nSulagpo tamu king banua, dugpa tamu king alapaap—lulugud ampong magsilbi king sangkaestudyantihan!\r\n(𝘓𝘦𝘵 𝘶𝘴 𝘧𝘭𝘺 𝘵𝘰 𝘵𝘩𝘦 𝘮𝘰𝘰𝘯, 𝘭𝘦𝘵 𝘶𝘴 𝘭𝘢𝘯𝘥 𝘰𝘯 𝘵𝘩𝘦 𝘤𝘭𝘰𝘶𝘥𝘴—𝘯𝘶𝘳𝘵𝘶𝘳𝘪𝘯𝘨 𝘢𝘯𝘥 𝘴𝘦𝘳𝘷𝘪𝘯𝘨 𝘵𝘩𝘦 𝘴𝘵𝘶𝘥𝘦𝘯𝘵 𝘣𝘰𝘥𝘺!)\r\n\r\n𝐒𝐨𝐚𝐫𝐢𝐧𝐠 𝐡𝐢𝐠𝐡𝐞𝐫 𝐟𝐨𝐫 𝐚 𝐬𝐲𝐧𝐞𝐫𝐠𝐢𝐳𝐞𝐝 𝐒𝐄𝐝!\r\n\r\n#TaasNooSulagpo\r\n#Sulagpo2026', 'assets/uploads/pl_1774016352.jpg', '2026-03-20 13:45:48');

-- ── USERS (college column added) ───────────────────────────
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_number` varchar(20) NOT NULL,
  `first_name` varchar(80) NOT NULL,
  `last_name` varchar(80) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','admin') DEFAULT 'student',
  `college` varchar(10) DEFAULT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_number` (`student_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `student_number`, `first_name`, `last_name`, `password`, `role`, `college`, `profile_pic`, `created_at`) VALUES
(1, '00000000', 'HAU', 'COMELEC', '$2y$10$ic/Ne36RSBTtMnu18Jl9CO.XK9E/sdWM0vqbsoYCEvSiDb.zoBKdG', 'admin', NULL, NULL, '2026-03-20 03:05:24'), -- Admin Initial Credentials
(2, '20626727', 'Clarence', 'Mendoza', '$2y$10$kKx1bSj/3FyG38yqQLodBOHFELpglEleEgI2FnPyMssW3Qd3nTAum', 'student', 'SOC', NULL, '2026-03-20 14:12:27'); -- Initial User Credentials

-- ── LINEUPS (updated unique key for multi-pick) ────────────
CREATE TABLE `lineups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `position` varchar(100) NOT NULL,
  `college` varchar(150) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `one_pick_per_candidate` (`user_id`,`candidate_id`),
  KEY `candidate_id` (`candidate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── VOTES (updated unique key for multi-pick) ──────────────
CREATE TABLE `votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voter_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL,
  `position` varchar(100) NOT NULL,
  `college` varchar(150) DEFAULT NULL,
  `voted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `one_vote_per_candidate` (`voter_id`,`candidate_id`),
  KEY `candidate_id` (`candidate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ── AUTO_INCREMENT ─────────────────────────────────────────
ALTER TABLE `candidates`      MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;
ALTER TABLE `election_settings` MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `events`          MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `lineups`         MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `partylists`      MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
ALTER TABLE `users`           MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
ALTER TABLE `votes`           MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- ── FOREIGN KEY CONSTRAINTS ────────────────────────────────
ALTER TABLE `candidates`
  ADD CONSTRAINT `candidates_ibfk_1` FOREIGN KEY (`partylist_id`) REFERENCES `partylists` (`id`) ON DELETE SET NULL;

ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

ALTER TABLE `lineups`
  ADD CONSTRAINT `lineups_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lineups_ibfk_2` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`) ON DELETE CASCADE;

ALTER TABLE `votes`
  ADD CONSTRAINT `votes_ibfk_1` FOREIGN KEY (`voter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `votes_ibfk_2` FOREIGN KEY (`candidate_id`) REFERENCES `candidates` (`id`) ON DELETE CASCADE;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;