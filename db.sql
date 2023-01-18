-- Host: db
-- Server version: 5.7.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `football`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL,
  `username` varchar(24) NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `challenges`
--

CREATE TABLE `challenges` (
  `id` int(11) NOT NULL,
  `challenge_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `challenges`
--

INSERT INTO `challenges` (`id`, `challenge_name`) VALUES
(1, 'challenge 1'),
(2, 'challenge 2');

-- --------------------------------------------------------

--
-- Table structure for table `challenge_grp`
--

CREATE TABLE `challenge_grp` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `challenge_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `max` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `challenge_grp`
--

INSERT INTO `challenge_grp` (`id`, `name`, `date`, `challenge_id`, `match_id`, `max`) VALUES
(2, 'test grp', '2023-01-18 19:15:42', 1, 221, 4);

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `uuid` varchar(32) NOT NULL,
  `session` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `matches`
--

CREATE TABLE `matches` (
  `id` int(11) NOT NULL,
  `team_1` int(11) NOT NULL,
  `team_2` int(11) NOT NULL,
  `score_1` int(11) NOT NULL DEFAULT '-1',
  `score_2` int(11) NOT NULL DEFAULT '-1',
  `due` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `matches`
--

INSERT INTO `matches` (`id`, `team_1`, `team_2`, `score_1`, `score_2`, `due`) VALUES
(173, 56, 46, -1, -1, '2022-11-21 05:00:00'),
(174, 45, 33, -1, -1, '2022-11-21 08:00:00'),
(175, 32, 53, -1, -1, '2022-11-21 11:00:00'),
(176, 61, 50, -1, -1, '2022-11-21 14:00:00'),
(177, 52, 35, -1, -1, '2022-11-22 05:00:00'),
(178, 39, 57, -1, -1, '2022-11-22 08:00:00'),
(179, 62, 49, -1, -1, '2022-11-22 11:00:00'),
(180, 40, 64, -1, -1, '2022-11-22 14:00:00'),
(181, 58, 42, -1, -1, '2022-11-23 05:00:00'),
(182, 38, 36, -1, -1, '2022-11-23 08:00:00'),
(183, 43, 64, -1, -1, '2022-11-23 11:00:00'),
(184, 41, 60, -1, -1, '2022-11-23 14:00:00'),
(185, 47, 59, -1, -1, '2022-11-24 05:00:00'),
(186, 54, 34, -1, -1, '2022-11-24 08:00:00'),
(187, 48, 55, -1, -1, '2022-11-24 11:00:00'),
(188, 51, 44, -1, -1, '2022-11-24 14:00:00'),
(189, 50, 33, -1, -1, '2022-11-25 05:00:00'),
(190, 32, 56, -1, -1, '2022-11-25 08:00:00'),
(191, 46, 53, -1, -1, '2022-11-25 11:00:00'),
(192, 45, 61, -1, -1, '2022-11-25 14:00:00'),
(193, 57, 64, -1, -1, '2022-11-26 05:00:00'),
(194, 49, 35, -1, -1, '2022-11-26 08:00:00'),
(195, 40, 39, -1, -1, '2022-11-26 11:00:00'),
(196, 52, 62, -1, -1, '2022-11-26 14:00:00'),
(197, 36, 64, -1, -1, '2022-11-27 05:00:00'),
(198, 41, 58, -1, -1, '2022-11-27 08:00:00'),
(199, 42, 60, -1, -1, '2022-11-27 11:00:00'),
(200, 43, 38, -1, -1, '2022-11-27 14:00:00'),
(201, 59, 44, -1, -1, '2022-11-28 05:00:00'),
(202, 34, 55, -1, -1, '2022-11-28 08:00:00'),
(203, 51, 47, -1, -1, '2022-11-28 11:00:00'),
(204, 48, 54, -1, -1, '2022-11-28 14:00:00'),
(205, 46, 32, -1, -1, '2022-11-29 10:00:00'),
(206, 53, 56, -1, -1, '2022-11-29 10:00:00'),
(207, 50, 45, -1, -1, '2022-11-29 14:00:00'),
(208, 33, 61, -1, -1, '2022-11-29 14:00:00'),
(209, 57, 40, -1, -1, '2022-11-30 10:00:00'),
(210, 64, 39, -1, -1, '2022-11-30 10:00:00'),
(211, 49, 52, -1, -1, '2022-11-30 14:00:00'),
(212, 35, 62, -1, -1, '2022-11-30 14:00:00'),
(213, 42, 41, -1, -1, '2022-12-01 10:00:00'),
(214, 60, 58, -1, -1, '2022-12-01 10:00:00'),
(215, 36, 43, -1, -1, '2022-12-01 14:00:00'),
(216, 64, 38, -1, -1, '2022-12-01 14:00:00'),
(217, 34, 48, -1, -1, '2022-12-02 10:00:00'),
(218, 55, 54, -1, -1, '2022-12-02 10:00:00'),
(219, 59, 51, -1, -1, '2022-12-02 14:00:00'),
(220, 44, 47, -1, -1, '2022-12-02 14:00:00'),
(221, 36, 47, 3, 2, '2022-11-27 05:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `prizes`
--

CREATE TABLE `prizes` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `points_to_win` int(11) NOT NULL,
  `prize_img` varchar(255) NOT NULL,
  `sponsor_img` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `prizes`
--

INSERT INTO `prizes` (`id`, `name`, `points_to_win`, `prize_img`, `sponsor_img`) VALUES
(4, 'Prize 1', 100, '/uploads/priz.png', '/uploads/sponsor.png'),
(5, 'Prize 2', 500, '/uploads/prize.png', '/uploads/sponsor.png'),
(6, 'Prize 3', 50, '/uploads/prize.png', '/uploads/sponsor.png'),
(7, 'Prize 4', 69, '/uploads/prize.png', '/uploads/sponsor.png');

-- --------------------------------------------------------

--
-- Table structure for table `scorers`
--

CREATE TABLE `scorers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `points` int(11) NOT NULL,
  `pp` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `scorers`
--

INSERT INTO `scorers` (`id`, `name`, `points`, `pp`) VALUES
(6, 'ronaldo', 30, '/uploads/image14.png'),
(7, 'messi', 30, '/uploads/messi.png');

-- --------------------------------------------------------

--
-- Table structure for table `stickers`
--

CREATE TABLE `stickers` (
  `id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stickers`
--

INSERT INTO `stickers` (`id`, `url`) VALUES
(1, '/uploads/sticker1.webp'),
(2, '/uploads/sticker2.webp'),
(3, '/uploads/sticker3.webp'),
(4, '/uploads/sticker4.webp');

-- --------------------------------------------------------

--
-- Table structure for table `stickers_log`
--

CREATE TABLE `stickers_log` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `sticker` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stickers_log`
--

INSERT INTO `stickers_log` (`id`, `user`, `sticker`, `group_id`, `time`) VALUES
(4, 9, 2, 2, '2023-01-18 19:18:45'),
(5, 9, 4, 2, '2023-01-18 19:18:51'),
(6, 9, 3, 2, '2023-01-18 19:18:55'),
(7, 9, 1, 2, '2023-01-18 19:19:05');

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE `teams` (
  `id` int(11) NOT NULL,
  `name` varchar(24) NOT NULL,
  `cc` varchar(6) NOT NULL DEFAULT 'unkn',
  `points` int(11) NOT NULL DEFAULT '0',
  `region` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `name`, `cc`, `points`, `region`) VALUES
(32, 'Qatar', 'qa', 0, 'Asia'),
(33, 'Iran', 'ir', 0, 'Asia'),
(34, 'South Korea', 'kr', 0, 'Asia'),
(35, 'Saudi Arabia', 'sa', 0, 'Asia'),
(36, 'Japan', 'jp', 0, 'Asia'),
(37, 'Australia', 'au', 0, 'Asia'),
(38, 'Germany', 'de', 0, 'Europe'),
(39, 'Denmark', 'dk', 0, 'Europe'),
(40, 'France', 'fr', 0, 'Europe'),
(41, 'Belgium', 'be', 0, 'Europe'),
(42, 'Croatia', 'hr', 0, 'Europe'),
(43, 'Spain', 'es', 0, 'Europe'),
(44, 'Serbia', 'rs', 0, 'Europe'),
(45, 'United Kingdom', 'gb', 0, 'Europe'),
(46, 'Netherlands', 'nl', 0, 'Europe'),
(47, 'Switzerland', 'ch', 0, 'Europe'),
(48, 'Portugal', 'pt', 0, 'Europe'),
(49, 'Poland', 'pl', 0, 'Europe'),
(50, 'Wales', 'gb-wls', 0, 'Europe'),
(51, 'Brazil', 'br', 0, 'South America'),
(52, 'Argentina', 'ar', 0, 'South America'),
(53, 'Ecuador', 'ec', 0, 'South America'),
(54, 'Uruguay', 'uy', 0, 'South America'),
(55, 'Ghana', 'gh', 0, 'Africa'),
(56, 'Senegal', 'sn', 0, 'Africa'),
(57, 'Tunisia', 'tn', 0, 'Africa'),
(58, 'Morocco', 'ma', 0, 'Africa'),
(59, 'Cameroon', 'cm', 0, 'Africa'),
(60, 'Canada', 'ca', 0, 'North America'),
(61, 'USA', 'us', 0, 'North America'),
(62, 'Mexico', 'mx', 0, 'North America'),
(63, 'Costa Rica', 'cr', 0, 'North America'),
(64, 'TBD', 'tbd', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `team_groups`
--

CREATE TABLE `team_groups` (
  `group_letter` enum('A','B','C','D','E','F','G','H') NOT NULL,
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `team_groups`
--

INSERT INTO `team_groups` (`group_letter`, `team_id`) VALUES
('A', 32),
('A', 53),
('A', 56),
('A', 46),
('B', 45),
('B', 33),
('B', 61),
('B', 50),
('C', 52),
('C', 35),
('C', 62),
('C', 49),
('D', 40),
('D', 37),
('D', 39),
('D', 57),
('E', 43),
('E', 63),
('E', 38),
('E', 36),
('F', 41),
('F', 60),
('F', 58),
('F', 42),
('G', 51),
('G', 44),
('G', 47),
('G', 59),
('H', 48),
('H', 55),
('H', 54),
('H', 34);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` text NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `sex` enum('male','female') NOT NULL,
  `points` int(11) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `pp` varchar(255) DEFAULT NULL,
  `verification_code` int(11) DEFAULT NULL,
  `token` text,
  `verified` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `full_name`, `sex`, `points`, `age`, `pp`, `verification_code`, `token`, `verified`) VALUES
(9, 'test@leopstuff.com', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', 'user', 'male', 200, 19, NULL, 82963, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiaWF0IjoxNjc0MDcyNTQwfQ.-IaFWoJk1FtT4yarwUzEvJ8ISl-0aA0xyp2-YobucOE', 'true');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challenges`
--
ALTER TABLE `challenges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challenge_grp`
--
ALTER TABLE `challenge_grp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `match_id` (`match_id`),
  ADD KEY `challenge_id` (`challenge_id`);

--
-- Indexes for table `matches`
--
ALTER TABLE `matches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `team_1` (`team_1`),
  ADD KEY `team_2` (`team_2`);

--
-- Indexes for table `prizes`
--
ALTER TABLE `prizes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `scorers`
--
ALTER TABLE `scorers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stickers`
--
ALTER TABLE `stickers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stickers_log`
--
ALTER TABLE `stickers_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `sticker_id` (`sticker`);

--
-- Indexes for table `teams`
--
ALTER TABLE `teams`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `team_groups`
--
ALTER TABLE `team_groups`
  ADD KEY `team_id` (`team_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `challenges`
--
ALTER TABLE `challenges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `challenge_grp`
--
ALTER TABLE `challenge_grp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `matches`
--
ALTER TABLE `matches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=222;

--
-- AUTO_INCREMENT for table `prizes`
--
ALTER TABLE `prizes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `scorers`
--
ALTER TABLE `scorers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `stickers`
--
ALTER TABLE `stickers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `stickers_log`
--
ALTER TABLE `stickers_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `teams`
--
ALTER TABLE `teams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `challenge_grp`
--
ALTER TABLE `challenge_grp`
  ADD CONSTRAINT `challenge_id` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`),
  ADD CONSTRAINT `match_id` FOREIGN KEY (`match_id`) REFERENCES `matches` (`id`);

--
-- Constraints for table `matches`
--
ALTER TABLE `matches`
  ADD CONSTRAINT `matches_ibfk_2` FOREIGN KEY (`team_1`) REFERENCES `teams` (`id`),
  ADD CONSTRAINT `matches_ibfk_3` FOREIGN KEY (`team_2`) REFERENCES `teams` (`id`);

--
-- Constraints for table `stickers_log`
--
ALTER TABLE `stickers_log`
  ADD CONSTRAINT `group_id` FOREIGN KEY (`group_id`) REFERENCES `challenge_grp` (`id`),
  ADD CONSTRAINT `sticker_id` FOREIGN KEY (`sticker`) REFERENCES `stickers` (`id`),
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user`) REFERENCES `users` (`id`);

--
-- Constraints for table `team_groups`
--
ALTER TABLE `team_groups`
  ADD CONSTRAINT `team_groups_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
