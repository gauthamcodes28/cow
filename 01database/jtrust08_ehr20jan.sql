-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 16, 2019 at 10:31 AM
-- Server version: 5.6.41-84.1
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jtrust08_ehr20jan`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`jtrust08`@`localhost` PROCEDURE `patient_medicine_data` (IN `id` VARCHAR(50), IN `visit` INT, IN `typename` INT, IN `name` VARCHAR(50), IN `billable` VARCHAR(50), IN `given` INT, IN `quantity` VARCHAR(100), IN `whenval` VARCHAR(100), IN `how` VARCHAR(100))  NO SQL
BEGIN

INSERT INTO patient_medicine (Patient_ID,Visit_Number,Medicine_Type_ID,Medicine_Name,Billable,Given,Quantity,Whenval,How) VALUES (id,visit,typename,name,billable,given,quantity,whenval,how);
END$$

CREATE DEFINER=`jtrust08`@`localhost` PROCEDURE `stock_update` (IN `typename` VARCHAR(50), IN `name` VARCHAR(50), IN `typeval` VARCHAR(50), IN `amount` INT, IN `username` VARCHAR(50))  NO SQL
BEGIN
insert into stock_transaction (Type_Name,Medicine_Name,Typeval,Amount,Updated_By,Timeval) values (typename,name,typeval,amount,username,now());
	if typeval like 'credit' 
	then
		update stock_master set Available=Available+amount where Medicine_Name=name;
		update medicine set Available=Available+amount where Medicine_Name=name;
	end if;
	
	if typeval like 'debit'
	then
		update stock_master set Available = Available-amount where Medicine_Name=name;
		update medicine set Available=Available+amount where Medicine_Name=name;
	END if;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ayurvedic`
--

CREATE TABLE `ayurvedic` (
  `id` int(11) NOT NULL,
  `ACategory_ID` varchar(50) NOT NULL,
  `ACategory_Name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `ayurvedic`
--

INSERT INTO `ayurvedic` (`id`, `ACategory_ID`, `ACategory_Name`) VALUES
(1, 'ashwa', 'ashwagandha'),
(2, 'harit', 'haritaki');

-- --------------------------------------------------------

--
-- Table structure for table `branch_master`
--

CREATE TABLE `branch_master` (
  `id` int(50) NOT NULL,
  `Branch_ID` varchar(50) NOT NULL,
  `Branch_Name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `branch_master`
--

INSERT INTO `branch_master` (`id`, `Branch_ID`, `Branch_Name`) VALUES
(1, 'BLR', 'Bangalore'),
(2, 'HYD', 'Hyderabad'),
(3, 'MUM', 'Mumbai'),
(4, 'PAR', 'Parbhani'),
(5, 'PHN', 'Phone Consultation'),
(6, 'PUN', 'Pune'),
(7, 'test', 'Test2'),
(8, 'test2', 'Test22');

-- --------------------------------------------------------

--
-- Table structure for table `contact_form`
--

CREATE TABLE `contact_form` (
  `id` int(50) NOT NULL,
  `Email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Subject` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `Message` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `Timeval` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `contact_form`
--

INSERT INTO `contact_form` (`id`, `Email`, `Name`, `Subject`, `Message`, `Timeval`) VALUES
(1, 'gauthamrajsunny@gmail.com', 'Gautham Raj', 'Hello Final Test 29Jan', 'Actually Its 30Jan But  Logically ite 29Jan.\n\nSigning off,\nGautham and Pavan', '2019-01-29 14:50:55'),
(2, 'gauthamrajsunny@gmail.com', 'Gautham Raj', 'dsad', 'dsadsad', '2019-01-29 14:56:53'),
(3, 'gauthamrajsunny@gmail.com', 'Gautham Raj', 'Hello Buddy', 'eeweweqw', '2019-02-01 05:45:56'),
(4, 'gauthamrajsunny@gmail.com', 'Gautham Raj', 'dsad', 'ewewew', '2019-02-06 02:39:20'),
(5, 'gauthamrajsunny@gmail.com', 'Gautham Raj', 'dsadsa', 'dsadsadsa', '2019-02-12 03:58:48'),
(6, 'gauthamrajsunny@gmail.com', 'gautham', 'Test11march', 'Hello World', '2019-03-11 06:02:15'),
(7, 'gauthamrajsunny@gmail.com', 'gautham', 'Test11march', 'asdasdas', '2019-03-11 06:07:52'),
(8, 'rewr', 'rerew', 'ewrew', 'rewrwe', '2019-03-12 10:14:02'),
(9, 'gauthamrajsunny@gmail.com', 'Hello WOrld', 'Final test for ehr uat15', 'Hello Guatham and Pavan', '2019-03-12 10:15:26'),
(10, 'fdsfsdfsdf', 'jhjfh', 'fdfsd', 'fdsfsdf', '2019-03-12 10:19:13'),
(11, 'ewq', 'ewq', 'ewq', 'ewqq', '2019-03-12 10:20:10'),
(12, 'rockstarpavan439@gmail.com', 'pavan', 'ha', 'hai', '2019-03-25 08:33:19'),
(13, 'rockstarpavan439@gmail.com', 'pavan', 'ha', 'there', '2019-03-25 08:34:18');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `id` int(11) NOT NULL,
  `Country_ID` varchar(50) NOT NULL,
  `Country_Name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `Country_ID`, `Country_Name`) VALUES
(1, 'ind', 'India'),
(2, 'out', 'Outside India');

-- --------------------------------------------------------

--
-- Table structure for table `medicine`
--

CREATE TABLE `medicine` (
  `Medicine_ID` int(11) NOT NULL,
  `Medicine_Type_ID` int(11) NOT NULL,
  `Medicine_Name` varchar(200) NOT NULL,
  `MRP` int(11) DEFAULT NULL,
  `Basic` int(11) DEFAULT NULL,
  `Unit` varchar(50) DEFAULT NULL,
  `Available` int(11) DEFAULT NULL,
  `Package_Weight` int(11) DEFAULT NULL,
  `Brand_Name` varchar(50) DEFAULT NULL,
  `Short_Form` varchar(50) DEFAULT NULL,
  `Net_Content` int(11) DEFAULT NULL,
  `Unit_Price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `medicine`
--

INSERT INTO `medicine` (`Medicine_ID`, `Medicine_Type_ID`, `Medicine_Name`, `MRP`, `Basic`, `Unit`, `Available`, `Package_Weight`, `Brand_Name`, `Short_Form`, `Net_Content`, `Unit_Price`) VALUES
(1, 1, 'Alovera Ark', 300, 500, 'ml', 45501, 500, 'Goseva', 'AL', 500, 300),
(2, 1, 'Alovera Juice', 110, 500, 'ml', 17501, 500, 'Goseva', 'ALJ', 500, 110),
(3, 2, 'Arjun', 180, 100, 'ml', 1500, 500, 'Goseva', 'ARJ', 500, 36),
(4, 2, 'Balpal', 100, 100, 'ml', 600, 240, 'Goseva', 'BLPL', 200, 50),
(5, 2, 'Chobchini', 230, 100, 'ml', 15000, 500, 'Goseva', 'CH', 500, 46),
(6, 2, 'Giloy(Ark)', 180, 100, 'ml', NULL, 500, 'Goseva', 'GI', 500, 36),
(7, 2, 'Gudmar', 320, 100, 'ml', 1300, 500, 'Goseva', 'GUD', 500, 64),
(8, 2, 'Kanchnar', 180, 100, 'ml', 11802, 500, 'Goseva', 'KCH', 500, 36),
(9, 2, 'Manjishtha(Ark)', 180, 100, 'ml', NULL, 500, 'Goseva', 'MJ', 500, 36),
(10, 2, 'Nandi', 180, 100, 'ml', 4000, 500, 'Goseva', 'ND', 500, 36),
(11, 2, 'Nari Sanjivani', 180, 100, 'ml', 40000, 500, 'Goseva', 'NS', 500, 36),
(12, 2, 'Pashanbhed', 180, 100, 'ml', 0, 500, 'Goseva', 'PSH', 500, 36),
(13, 2, 'Plain ', 100, 100, 'ml', 0, 500, 'Goseva', 'PLAIN', 500, 20),
(14, 2, 'Punarnava ', 180, 100, 'ml', 4003, 500, 'Goseva', 'PU', 500, 36),
(15, 2, 'Raktashuddhi', 230, 100, 'ml', 14100, 500, 'Goseva', 'RKT', 500, 46),
(16, 2, 'Saptarangi', 180, 100, 'ml', 500, 500, 'Goseva', 'SPT', 500, 36),
(17, 2, 'Sarpgandha(Ark)', 180, 100, 'ml', NULL, 500, 'Goseva', 'SRP', 500, 36),
(18, 2, 'Tulasi', 180, 100, 'ml', 1000, 500, 'Goseva', 'TU', 500, 36),
(19, 3, 'Abhayarishta', 138, 50, 'ml', 5400, 530, 'Dhootpapeswr', 'ABH', 450, 16),
(20, 3, 'Amrutarishta', 173, 50, 'ml', 1350, 540, 'Dhootpapeswr', 'AMR', 450, 20),
(21, 3, 'Arjunarishta', 135, 50, 'ml', 7650, 535, 'Unjha', 'ARJ', 450, 15),
(22, 3, 'Ashokarishta', 126, 50, 'ml', 904, 550, 'Unjha', 'ASH', 450, 14),
(23, 3, 'Ashwagandharishta', 182, 50, 'ml', 3600, 520, 'Dhootpapeswr', 'ASHW', 450, 21),
(24, 3, 'Chandanasava', 75, 50, 'ml', 600, 525, 'Dhootpapeswr', 'CHN', 200, 19),
(25, 3, 'Dashamularishta', 150, 50, 'ml', 0, 0, 'Unjha', 'DSH', 450, 17),
(26, 3, 'Drakshasava ', 150, 50, 'ml', 0, 0, 'Unjha', 'DRKSH', 450, 17),
(27, 3, 'Drakshora', 102, 50, 'ml', 5625, 325, 'Unjha', 'DRKSH', 225, 23),
(28, 3, 'Gomutra asava', 270, 50, 'ml', 15000, 500, 'Goseva', 'GASAV', 500, 27),
(29, 3, 'Jirakararishta', 162, 50, 'ml', 8100, 535, 'Unjha', 'JRK', 450, 18),
(30, 3, 'Kanakasava', 140, 50, 'ml', 1800, 515, 'Dhootpapeswr', 'KNK', 450, 16),
(31, 3, 'Khadirarishta', 150, 50, 'ml', 4, 0, 'Unjha', 'KHR', 450, 17),
(32, 3, 'Kumari Asava', 192, 50, 'ml', 6300, 520, 'Dhootpapeswr', 'KUSAVA', 450, 22),
(33, 3, 'Kutajarishta', 118, 50, 'ml', 550, 550, 'Unjha', 'KTJ', 450, 14),
(34, 3, 'Lodhrasava', 147, 50, 'ml', 4650, 505, 'Dhootpapeswr', 'LODH', 450, 17),
(35, 3, 'Mahamanjishthadi Qath', 150, 50, 'ml', 1900, 520, 'Dhootpapeswr', 'MAHM', 450, 17),
(36, 3, 'Maharasnadi Qath', 150, 50, 'ml', 0, 0, 'Dhootpapeswr', 'MAHR', 450, 17),
(37, 3, 'Punarnavasava(Dhoot)', 75, 50, 'ml', 602, 235, 'Dhootpapeswr', 'PUSAVA', 200, 19),
(38, 3, 'Punarnavasava(Unjha)', 130, 50, 'ml', 6300, 540, 'unjha', 'PUSAVA', 450, 15),
(39, 3, 'Saraswatarishta', 150, 50, 'ml', 0, 0, 'Unjha', 'SRSW', 450, 17),
(40, 3, 'Takrarishta', 150, 50, 'ml', 5000, 500, 'Goseva', 'TKRS', 500, 15),
(41, 3, 'Takrasava', 150, 50, 'ml', 5000, 500, 'Goseva', 'TKR', 500, 15),
(42, 3, 'Vasakasava', 100, 10, 'ml', 5000, 500, 'Goseva', 'VS', 500, 0),
(43, 3, 'Ushirasava', 144, 50, 'ml', 4950, 501, 'Dhootpapeswr', 'USH', 450, 16),
(44, 4, 'Avipattikar choorna', 80, 50, 'grams', 100, 50, 'Udupi', 'APC', 50, 80),
(45, 4, 'Charma ', 80, 50, 'grams', 0, 50, 'Udupi', 'CC', 50, 80),
(46, 4, 'Haridra Khand', 80, 50, 'grams', 0, 0, 'Udupi', 'HKC', 50, 80),
(47, 4, 'Hinguvachadi', 80, 50, 'grams', 1, 0, 'Udupi', 'HVC', 50, 80),
(48, 4, 'Kottam Chukkli', 80, 50, 'grams', 0, 50, 'Udupi', 'KCC', 50, 80),
(49, 4, 'Madhuveri', 90, 100, 'grams', 3500, 130, 'Goseva', 'MDHV', 100, 90),
(50, 4, 'Pachanamrita', 60, 60, 'grams', 3360, 80, 'Goseva', 'PCH', 60, 60),
(51, 4, 'Satavari Kalpa', 10, 10, 'grams', 100, 10, 'Goseva', 'SK', 10, 10),
(52, 4, 'Sitopaladi', 80, 50, 'grams', 450, 50, 'Udupi', 'SIC', 50, 80),
(53, 4, 'Talisadi', 80, 50, 'grams', 150, 50, 'Udupi', 'TLC', 50, 80),
(54, 4, 'Triphala Choorna', 80, 50, 'grams', NULL, 50, 'Udupi', 'TC', 50, 80),
(55, 4, 'Veeryashodhan Choorna', 90, 100, 'grams', 200, 125, 'Unjha', 'VRYC', 100, 90),
(56, 5, 'Amritdhara', 150, 10, 'ml', 41, 15, 'Home', 'ADROPS', 10, 150),
(57, 5, 'Bramhi- Ayur Ghee', 70, 10, 'ml', 30, 52, 'Goseva', 'AYUR', 10, 70),
(58, 5, 'Netraseva', 10, 10, 'ml', 10, 10, 'Goseva', 'NS', 10, 10),
(59, 5, 'Netranjan', 40, 15, 'ml', 765, 22, 'Goseva', 'NETRA', 15, 40),
(60, 5, 'PG Drops', 150, 10, 'ml', 81, 50, 'Goseva', 'PG', 10, 150),
(61, 6, 'Arjun(Ghanavati)', 100, 120, 'number', NULL, 70, 'Goseva', 'ARJ', 120, 100),
(62, 6, 'Bhasma Vati', 100, 120, 'number', 2160, 80, 'Goseva', 'BH', 120, 100),
(63, 6, 'Giloy', 100, 120, 'number', 1080, 70, 'Goseva', 'GI', 120, 100),
(64, 6, 'Haritaki', 100, 120, 'number', 961, 70, 'Goseva', 'HRT', 120, 100),
(65, 6, 'Madhuvati', 100, 120, 'number', 3600, 70, 'Goseva', 'MDH', 120, 100),
(66, 6, 'Manjishtha', 100, 120, 'number', 1200, 82, 'Goseva', 'MJ', 120, 100),
(67, 6, 'Panchgavya', 150, 120, 'number', 1320, 65, 'Goseva', 'PCH', 120, 150),
(68, 6, 'Punarnava Vati', 100, 120, 'number', 840, 80, 'Goseva', 'PU', 120, 100),
(69, 6, 'Sarpgandha', 100, 120, 'number', 600, 70, 'Goseva', 'SRP', 120, 100),
(70, 6, 'Triphala(Goseva)', 80, 120, 'number', NULL, 75, 'Goseva', 'TRI', 120, 80),
(71, 6, 'Tulasi Vati', 100, 120, 'number', 3480, 75, 'Goseva', 'TU', 120, 100),
(72, 7, 'PG Ghrita 250 gm', 750, 250, 'ml', 4250, 251, 'Goseva', 'PG', 250, 750),
(73, 7, 'Phala Ghrita 125gms', 210, 100, 'grams', 1100, 125, 'Nagarjuna', 'PHG', 100, 210),
(74, 7, 'Phala Ghrita 250gms', 410, 200, 'grams', 0, 250, 'Nagarjuna', 'PHG', 200, 410),
(75, 7, 'Real Ghee 250 ml', 499, 250, 'ml', 7250, 475, 'Goseva', 'RG', 250, 499),
(76, 7, 'Real Ghee 500 ml', 999, 500, 'ml', 4500, 922, 'Goseva', 'RG', 500, 999),
(77, 7, 'Triphala Ghritam 125 gms', 210, 100, 'grams', 2400, 125, 'Nagarjuna', 'TRG', 100, 210),
(78, 7, 'Triphala Ghritam 250 gms', 410, 200, 'grams', 0, 250, 'Nagarjuna', 'TRG', 200, 410),
(79, 8, 'Abha(Nagarjuna)', 70, 60, 'tab', 240, 47, 'Nagarjuna', 'ABHA', 60, 70),
(80, 8, 'Abha(Unjha)', 75, 60, 'tab', 560, 30, 'Unjha', 'ABHA', 80, 57),
(81, 8, 'Abha 40 tab', 300, 60, 'tab', 0, 0, 'Unjha', 'ABHA', 60, 300),
(82, 8, 'Abha 80 tab', 80, 60, 'tab', 400, 30, 'Unjha', 'ABHA', 80, 60),
(83, 8, 'Amrutadi', 300, 60, 'tab', 1200, 0, 'Udupi', 'AMR', 60, 300),
(84, 8, 'Gokshuradi(Udupi)', 300, 60, 'tab', 1080, 40, 'Udupi', 'GOK', 60, 300),
(85, 8, 'Gokshuradi(Dhoot)', 106, 60, 'tab', 60, 32, 'Dhoopapeswar', 'GOK', 60, 106),
(86, 8, 'Gokshuradi(Unjha)80 tabs', 115, 60, 'tab', 2000, 31, 'Unjha', 'GOK', 80, 87),
(87, 8, 'Kaishora(Udupi)', 300, 60, 'tab', 180, 35, 'Udupi', 'KAI', 60, 300),
(88, 8, 'Kaishora(Unjha)', 96, 60, 'tab', 420, 26, 'Unjha', 'KAI', 60, 96),
(89, 8, 'Kaishora(Dhoot)', 110, 60, 'tab', 540, 30, 'Dhoopapeswar', 'KAI', 60, 110),
(90, 8, 'Kaishora 80 tab(Unjha)', 90, 60, 'tab', 560, 30, 'Unjha', 'KAI', 80, 68),
(91, 8, 'Kanchnar(Udupi)', 300, 60, 'tab', 360, 30, 'Udupi', 'KCH', 60, 300),
(92, 8, 'Kanchnar(Dhoot)', 118, 60, 'tab', 360, 30, 'Dhoopapeswar', 'KCH', 60, 118),
(93, 8, 'Kanchnar(Unjha)', 96, 60, 'tab', 240, 28, 'Unjha', 'KCH', 60, 96),
(94, 8, 'Kanchnar 200 tab(Unjha)', 210, 60, 'tab', 200, 68, 'Unjha', 'KCH', 200, 63),
(95, 8, 'Lakshadi(Udupi)', 300, 60, 'tab', 720, 30, 'Udupi', 'LHK', 60, 300),
(96, 8, 'Lakshadi(Dhoot)', 130, 60, 'tab', 300, 30, 'Dhoopapeswar', 'LHK', 60, 130),
(97, 8, 'Mahayogiraj(209)', 209, 60, 'tab', NULL, 15, 'Unjha', 'MAHY', 60, 209),
(98, 8, 'Mahayogiraj(212)', 212, 60, 'tab', NULL, 15, 'Unjha', 'MAHY', 60, 212),
(99, 8, 'Medohar(Nagarjuna)', 80, 60, 'tab', 180, 45, 'Nagarjuna', 'MED', 60, 80),
(100, 8, 'Medohar 80 tabs(Unjha)', 110, 60, 'tab', 960, 45, 'Unjha', 'MED', 80, 83),
(101, 8, 'Navaka Guggulu', 300, 60, 'tab', 0, 0, 'Udupi', 'NAV', 60, 300),
(102, 8, 'simhanada(Udupi)', 300, 60, 'tab', 1320, 50, 'Udupi', 'SIM', 60, 300),
(103, 8, 'simhanada(Dhoop)', 102, 60, 'tab', 60, 35, 'Dhoopapeswar', 'SIM', 60, 102),
(104, 8, 'Trayodashang(Udupi)', 300, 60, 'tab', 120, 0, 'Udupi', 'TRAYO', 60, 300),
(105, 8, 'Trayodashang(Dhoop)', 120, 60, 'tab', 540, 55, 'Dhoopapeswar', 'TRAYO', 60, 120),
(106, 8, 'Trayodashang 40 tab(Unjha)', 300, 60, 'tab', 0, 0, 'Unjha', 'TRAYO', 60, 300),
(107, 8, 'Triphala(Udupi)', 300, 60, 'tab', 240, 20, 'Udupi', 'TRP', 60, 300),
(108, 8, 'Triphala(Unjha)', 90, 60, 'tab', 480, 30, 'Unjha', 'TRP', 80, 68),
(109, 8, 'Triphala Guggulu 60 tab(Unjha)', 96, 60, 'tab', 480, 28, 'Unjha', 'TRP', 60, 96),
(110, 8, 'vyoshashi ', 300, 60, 'tab', 1080, 30, 'Udupi', 'VYO', 60, 300),
(111, 8, 'Yogiraj(Udupi)', 300, 60, 'tab', 840, 35, 'Udupi', 'YOG', 60, 300),
(112, 8, 'Yogiraj(Unjha)', 96, 60, 'tab', 600, 27, 'Unjha', 'YOG', 60, 96),
(113, 8, 'Yogiraj 200 tabs(Unjha)', 200, 60, 'tab', 600, 68, 'Unjha', 'YOG', 200, 60),
(114, 9, 'Arjun Twak', 85, 60, 'tab', 1260, 32, 'Nagarjuna', 'ARJT', 60, 85),
(115, 9, 'Arogyavardhini(Udupi)', 270, 60, 'tab', 240, 4, 'Udupi', 'ARG', 60, 270),
(116, 9, 'Arogyavardhini(Dhoot)', 289, 60, 'tab', 100, 45, 'Dhootpapeswr', 'ARG', 100, 174),
(117, 9, 'Bilwadi Gutika', 300, 60, 'tab', 180, 178, 'Udupi', 'BIL', 60, 300),
(118, 9, 'Brahmi Vati', 231, 60, 'tab', 480, 31, 'Dhootpapeswr', 'BRMH', 60, 231),
(119, 9, 'Bramhi', 300, 60, 'tab', 0, 0, 'Unjha', 'BRMH', 60, 300),
(120, 9, 'Chandraprabha(Udupi)', 300, 60, 'tab', 2, 0, 'Udupi', 'CHR', 60, 300),
(121, 9, 'Chandraprabha(Dhhot)', 300, 60, 'tab', 0, 0, 'Dhootpapeswr', 'CHR', 60, 300),
(122, 9, 'Chandraprabha 40 tab(Unjha)', 300, 60, 'tab', 0, 0, 'Unjha', 'CHR', 60, 300),
(123, 9, 'Chandraprabha 80 tab(Unjha)', 300, 60, 'tab', 0, 0, 'Unjha', 'CHR', 60, 300),
(124, 9, 'ConVit', 180, 60, 'tab', 1440, 41, 'Home', 'CON', 30, 360),
(125, 9, 'Cow collestrum', 1365, 60, 'tab', 0, 0, 'Goseva', 'COW', 60, 1365),
(126, 9, 'Dhanvantaram ', 300, 60, 'tab', 660, 25, 'Udupi', 'DHN', 60, 300),
(127, 9, 'Garbhpaal Ras', 95, 60, 'tab', 660, 15, 'Unjha', 'GRBH', 60, 95),
(128, 9, 'Garbhpaal Ras 80 tab', 90, 60, 'tab', 880, 16, 'Unjha', 'GRBH', 80, 68),
(129, 9, 'Kanyalohadi 66', 66, 60, 'tab', 360, 15, 'Unjha', 'KNY', 60, 66),
(130, 9, 'Kanyalohadi 75', 75, 60, 'tab', 300, 16, 'Unjha', 'KNY', 60, 75),
(131, 9, 'Kanyalohadi 100', 100, 60, 'tab', 80, 18, 'Unjha', 'KNY', 80, 75),
(132, 9, 'Kanyalohadi 80 tab(Unjha)', 90, 60, 'tab', 400, 20, 'Unjha', 'KNY', 80, 68),
(133, 9, 'Mahasudarshan vati', 115, 60, 'tab', 1140, 31, 'Unjha', 'MAHS', 60, 115),
(134, 9, 'Mahasudarshan vati 80 tab', 130, 60, 'tab', 880, 45, 'Unjha', 'MAHS', 80, 98),
(135, 9, 'Punarnava mandoor', 100, 60, 'tab', 480, 17, 'Unjha', 'PUM', 80, 75),
(136, 9, 'Punarnava mandoor 40 tab', 55, 60, 'tab', 480, 12, 'Unjha', 'PUM', 40, 83),
(137, 9, 'Punarvava Mandur', 100, 60, 'tab', 60, 16, 'Unjha', 'PUM', 60, 100),
(138, 9, 'Saptamrit', 75, 60, 'tab', 600, 15, 'Unjha', 'SPT', 60, 75),
(139, 9, 'Saptamrit 80 tabs', 100, 60, 'tab', 880, 17, 'Unjha', 'SPT', 80, 75),
(140, 9, 'Smritisagar Ras', 130, 60, 'tab', 720, 18, 'Unjha', 'SMR', 80, 98),
(141, 9, 'Smritisagar Ras 40 tab', 300, 60, 'tab', 0, 0, 'Unjha', 'SMR', 60, 300),
(142, 9, 'Sootashekhar Ras(Udupi)', 300, 60, 'tab', 0, 0, 'Udupi', 'SUT', 60, 300),
(143, 9, 'Sootashekhar Ras(Dhoot)', 83, 60, 'tab', 220, 15, 'Dhootpapeswr', 'SUT', 20, 249),
(144, 9, 'Yashtimadhu', 135, 60, 'tab', 1200, 30, 'Nagarjuna', 'YSHT', 60, 135),
(145, 10, 'Alovera Shampoo', 0, 100, 'ml', 0, 0, 'Goseva', 'ALSHAMPOO', 100, 0),
(146, 10, 'Angarakshak', 35, 50, 'grams', 700, 70, 'Goseva', 'ANGR', 50, 35),
(147, 10, 'Dantmanjan', 35, 50, 'grams', 700, 70, 'Goseva', 'DNT', 50, 35),
(148, 10, 'Dhatri Rasayan', 0, 0, 'grams', 0, 0, 'Unjha', 'DHATRI', 0, 0),
(149, 10, 'Dhoop(Akola)', 35, 30, 'number', NULL, 75, 'Akola', 'DHOOP', 30, 35),
(150, 10, 'Dhoop(Goseva)', 0, 0, 'number', NULL, 0, 'Goseva', 'DHOOP', 0, 0),
(151, 10, 'Dhoop(Venumadhuri)', 50, 20, 'number', NULL, 59, 'Venumadhuri', 'DHOOP', 20, 50),
(152, 10, 'Dishwash gel', 70, 250, 'ml', 750, 279, 'Goseva', 'DISH', 250, 70),
(153, 10, 'Facepack', 65, 100, 'grams', 500, 125, 'Goseva', 'FCP', 100, 65),
(154, 10, 'Floor Cleaner', 0, 0, 'ml', 0, 0, 'Goseva', 'FLOOR', 0, 0),
(155, 10, 'Gopika Carbon', 45, 75, 'grams', 75, 95, 'Goseva', 'GCS', 75, 45),
(156, 10, 'Gopika Panchgavya Soap', 0, 0, 'grams', 0, 0, 'Goseva', 'GPS', 0, 0),
(157, 10, 'Handwash', 65, 200, 'ml', 2600, 212, 'Goseva', 'HAND', 200, 65),
(158, 10, 'Honey', 150, 250, 'ml', 1750, 375, 'Venumadhuri', 'HONEY', 250, 150),
(159, 10, 'Kesari Gulkand', 170, 400, 'grams', 1600, 460, 'lion', 'GUL', 400, 170),
(160, 10, 'Maraham', 30, 15, 'grams', 90, 50, 'Goseva', 'MARH', 15, 30),
(161, 10, 'Oxygel', 0, 0, 'grams', 0, 0, 'Goseva', 'OXY', 0, 0),
(162, 10, 'Panchagavya Moisturizing lotion', 70, 100, 'ml', 1000, 122, 'Goseva', 'LOTION', 100, 70),
(163, 10, 'Shampoo', 110, 125, 'ml', 375, 145, 'Venumadhuri', 'SHAMPOO', 125, 110),
(164, 10, 'Shatavari Kalp', 122, 125, 'grams', 750, 160, 'Dhootpapeswr', 'SHTVARI', 125, 122),
(165, 10, 'Toilet cleaner', 70, 500, 'ml', 1000, 502, 'Goseva', 'TOI', 500, 70),
(166, 10, 'Ubtan', 0, 0, 'grams', 0, 0, 'Goseva', 'UBT', 0, 0),
(167, 11, 'Angamardan', 70, 60, 'ml', 720, 71, 'Goseva', 'ANGM', 60, 70),
(168, 11, 'Bramhi Amla', 90, 100, 'ml', 300, 115, 'Goseva', 'BRMHLA', 100, 90),
(169, 11, 'Castor Oil', 10, 100, 'ml', 1000, 100, 'Goseva', 'CO', 100, 10),
(170, 11, 'Liv Oil', 10, 100, 'ml', 1000, 100, 'Goseva', 'LO', 100, 10);

-- --------------------------------------------------------

--
-- Table structure for table `medicine_type`
--

CREATE TABLE `medicine_type` (
  `Type_ID` int(11) NOT NULL,
  `Type_Name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `medicine_type`
--

INSERT INTO `medicine_type` (`Type_ID`, `Type_Name`) VALUES
(1, 'Alovera'),
(2, 'Ark'),
(3, 'Asava-Arishta'),
(4, 'Choorna'),
(5, 'Drops'),
(6, 'Ghanavati'),
(7, 'Ghrita'),
(8, 'Guggulu'),
(9, 'Gutika-Vati'),
(10, 'Other'),
(11, 'Tailam');

-- --------------------------------------------------------

--
-- Table structure for table `modern`
--

CREATE TABLE `modern` (
  `id` int(11) NOT NULL,
  `Mod_ID` varchar(50) NOT NULL,
  `Mod_Name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `modern`
--

INSERT INTO `modern` (`id`, `Mod_ID`, `Mod_Name`) VALUES
(1, 'dolo', 'dolo'),
(2, 'nimdisp', 'nimdispi');

-- --------------------------------------------------------

--
-- Table structure for table `patient_instruction`
--

CREATE TABLE `patient_instruction` (
  `id` int(11) NOT NULL,
  `Patient_ID` varchar(50) NOT NULL,
  `Visit_Number` int(11) DEFAULT NULL,
  `Branch_ID` varchar(10) DEFAULT NULL,
  `Visit_Date` varchar(10) DEFAULT NULL,
  `Dantmanjan` varchar(500) DEFAULT NULL,
  `Panchakarma` varchar(20) DEFAULT NULL,
  `Yoga` varchar(20) DEFAULT NULL,
  `Instructions` varchar(100) DEFAULT NULL,
  `Stop` varchar(100) DEFAULT NULL,
  `Start` varchar(100) DEFAULT NULL,
  `Other1` varchar(100) DEFAULT NULL,
  `Other2` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient_instruction`
--

INSERT INTO `patient_instruction` (`id`, `Patient_ID`, `Visit_Number`, `Branch_ID`, `Visit_Date`, `Dantmanjan`, `Panchakarma`, `Yoga`, `Instructions`, `Stop`, `Start`, `Other1`, `Other2`) VALUES
(80, 'EHR1', 1, 'HYD', '2019/03/16', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'merudandasana', 'Apply Ark on back 2-3 times a day', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', '', ''),
(81, 'EHR2', 1, '', '43125', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Suryanamaskar', 'Use Amrithdhara in 4 ways as explained- 1.with hot water internally 2.Inhale through handkerchief 3.', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(82, 'EHR3', 1, '', '43123', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Meudandasana', 'Use facepack once a week', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(83, 'EHR4', 1, '', '43128', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Merudandasana', 'Apply Gomutra Ark on lower Abdomen', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(84, 'EHR5', 1, '', '43125', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(85, 'EHR6', 1, '', '43124', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Kapalbhati,Anulom Vi', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(86, 'EHR7', 1, '', '43123', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', 'Apply Ark Mixt all over body 2 time a day', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(87, 'EHR8', 1, '', '43128', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', 'Apply Ark Mmixt on hands and legs', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(88, 'EHR9', 1, '', '43124', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(89, 'EHR10', 1, '', '43124', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', 'Sugar Cane juice', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(90, 'EHR11', 1, 'HYD', '2019/03/17', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', 'Apply Ark Mixture all over body 2 times a day', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', '', ''),
(91, 'EHR12', 1, '', '43123', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', ' ', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(92, 'EHR13', 1, '', '43124', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(93, 'EHR14', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Kapalbhati', 'Follow diet chart for 8 days. Again after gap of 2 weeks. ', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(94, 'EHR15', 1, '', '23-1-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', '', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(95, 'EHR16', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', '', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(96, 'EHR17', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(97, 'EHR18', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Merudandasana', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(98, 'EHR19', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Uttanapadasana + Mer', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(99, 'EHR20', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(100, 'EHR21', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Merudandasana', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(101, 'EHR22', 2, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', 'Vamana- Drink 6 to 8 glasses of salty warm water in morning – drink & vomit. Eat Khichari.Salt water', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(102, 'EHR23', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(103, 'EHR24', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'ANulom Vilom  ', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(104, 'EHR25', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Walk daily for 2 kms', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(105, 'EHR26', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Merudandasana', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(106, 'EHR27', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Merudandasana', 'Vamana—drink 6 to 8 glasses of salty warm water & vomit. Eat khichari. Do this for 3 consecutive day', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(107, 'EHR28', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom + Kapal', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(108, 'EHR29', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(109, 'EHR30', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', 'Read Bhagavad Gita Daily', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(110, 'EHR31', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom + Kapal', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(111, 'EHR32', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', 'Vamana- drink 6 to 8 glasses of salty warm water & vomit . Eat only Khichari that day. ', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(112, 'EHR33', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'ANulom Vilom  ', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(113, 'EHR34', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Pavanmuktasana Sreni', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(114, 'EHR35', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Kapalbhati Pranayam ', 'Salt water bath.Bottle Groud juice-add lemon+pudina+Ginger', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(115, 'EHR36', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Merudandasana', 'Chew Alum Pieces for Mouth Ulcers.', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(116, 'EHR37', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Uttanapadasana as in', 'Apply Ark Mixt on abdomen- light massage. ', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(117, 'EHR38', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', 'Blow Conch.', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', 'Puut Gomutra in bathing water.'),
(118, 'EHR39', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(119, 'EHR40', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(120, 'EHR41', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Merudandasana', 'Press Points', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(121, 'EHR42', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Bhramari Pranayama+A', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(122, 'EHR43', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Suryanamaskar', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(123, 'EHR44', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(124, 'EHR45', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(125, 'EHR46', 1, '', '25-001-201', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(126, 'EHR47', 1, '', '25-001-201', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(127, 'EHR48', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(128, 'EHR49', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(129, 'EHR50', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Merudandasana', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(130, 'EHR51', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', 'Apply ark on legs.Salt water bath.Hot water+Lemon after food', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(131, 'EHR52', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Uttanapadasana + Mer', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(132, 'EHR53', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Kapalbhati+Anulom vi', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(133, 'EHR54', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(134, 'EHR55', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Merudandasana + Anul', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(135, 'EHR56', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(136, 'EHR57', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(137, 'EHR58', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Kapalbhati+Anulom vi', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(138, 'EHR59', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(139, 'EHR60', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(140, 'EHR61', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Kapalbhati+Anulom vi', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(141, 'EHR62', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Merudandasana', 'Apply Ark mixt on legs & Back', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(142, 'EHR63', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Merudandasana', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(143, 'EHR64', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(144, 'EHR65', 1, '', '25-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(145, 'EHR66', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', 'Drink water while seating, pinch of Sunnam in the afternoon', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(146, 'EHR67', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', 'Vamana- drink 6 to 8 glasses of salty warm water in morning & vomit. Eat only Khichari that day. DO ', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(147, 'EHR68', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(148, 'EHR69', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', ' Apply Ark Mixt all over hands & legs 2 times a day.', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(149, 'EHR70', 1, '', '24-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Kapalbhati+Anulom vi', 'Follow 8 day Detox Program', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(150, 'EHR71', 1, '', '23-01-2018', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:Avoid foam based soap.', '', 'Anulom Vilom Pranaya', '50 ml Neem juice morn empty stomach- start with 20 ml. Use neem leaves in bathing water. ', 'Refined Oil, Wheat, Refined Salt, Market Ghee, Packet Milk, Non-Veg,Wine, Tea, Coffee, Tobacco.', 'Cold Pressed Ghani Oil,Jowar/ bajra/ragi etc., Saindhav Salt, hand churned Desi gaus Ghee, Desi Gau ', 'Daily wake up before 6 and drink warm water (1-2 glass) without brushing teeth.,Daily night soak 2-3', ''),
(151, 'EHR72', 1, 'PAR', '2019/03/18', 'Use Dantmanjan only dont use Toothpaste.Use Brush only if equired. \nUse Angarakshak Soap:-Avoid foam based soap.', '', '', '', '', '', '', ''),
(152, 'EHR73', 1, 'HYD', '2019/03/22', 'Dont use Toothpaste.Use Brush only if equired.Angarakshak Soap:-Avoid foam based soap.', 'dasdas', 'dasdas', '', '', '', '', ''),
(153, '', 1, 'PAR', '2019/03/26', 'Use Dantmanjan only Don\'t use Toothpaste.Use Brush only if equired..\nUse Angarakshak Soap:- Avoid foam based soap.', '', 'Merudandasana', '', '', '', '', ''),
(154, 'EHR72', 2, 'PAR', '2019/04/08', 'Use Dantmanjan only Don\'t use Toothpaste.Use Brush only if equired..\nUse Angarakshak Soap:- Avoid foam based soap.', '', 'Merudandasana', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `patient_master`
--

CREATE TABLE `patient_master` (
  `Patient_ID` varchar(50) NOT NULL,
  `Branch_ID` varchar(10) DEFAULT NULL,
  `Country_ID` varchar(10) DEFAULT NULL,
  `State_ID` varchar(10) DEFAULT NULL,
  `Email` varchar(250) NOT NULL,
  `DOB` varchar(10) DEFAULT NULL,
  `Age` int(11) DEFAULT NULL,
  `Visit_Number` int(11) DEFAULT NULL,
  `PName` varchar(50) DEFAULT NULL,
  `Phone` bigint(20) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `Vikruthi` varchar(10) DEFAULT NULL,
  `Veda_Pulse` varchar(20) DEFAULT NULL,
  `Profile_Photo` varchar(100) DEFAULT 'sample.jpg',
  `Address` text,
  `Mode` varchar(50) DEFAULT 'offline',
  `isdelete` int(11) DEFAULT '1',
  `Verified` int(11) NOT NULL,
  `Time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient_master`
--

INSERT INTO `patient_master` (`Patient_ID`, `Branch_ID`, `Country_ID`, `State_ID`, `Email`, `DOB`, `Age`, `Visit_Number`, `PName`, `Phone`, `Gender`, `Vikruthi`, `Veda_Pulse`, `Profile_Photo`, `Address`, `Mode`, `isdelete`, `Verified`, `Time`) VALUES
('EHR1', 'HYD', 'ind', 'AP', '', '', 56, 1, 'Anjinikumar B', 0, 'Male', 'vk', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR10', 'HYD', 'ind', 'AP', '', '', 50, 1, 'G Raghunath', 0, 'Male', 'V', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR11', 'HYD', 'ind', 'AP', '', '', 51, 1, 'G S Muralidhar Goud', 0, 'Male', 'Vk', 'no', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR12', 'HYD', 'ind', 'AP', '', '', 47, 1, 'G Saroja', 0, 'Female', 'P', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR13', 'HYD', 'ind', 'AP', '', '', 70, 1, 'G Vijay Kumar', 0, 'Male', 'V', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR14', 'HYD', 'ind', 'AP', '', '', 64, 1, 'Gopalakrishna G', 0, 'Male', 'PK', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR15', 'HYD', 'ind', 'AP', '', '', 65, 1, 'Govindamma', 0, 'Female', 'P', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR16', 'HYD', 'ind', 'AP', '', '', 60, 1, 'H Manjunath', 0, 'Male', 'VP', 'no', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR17', 'HYD', 'ind', 'AP', '', '', 63, 1, 'H Nageswar Rao', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR18', 'HYD', 'ind', 'AP', '', '', 67, 1, 'HR Satyanarayana', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR19', 'HYD', 'ind', 'AP', '', '', 61, 1, 'HS Sasikala', 0, 'Female', 'VP', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR2', 'HYD', 'ind', 'AP', '', '', 5, 1, 'Ashita', 0, 'Female', 'Pk', 'NO', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR20', 'HYD', 'ind', 'AP', '', '', 62, 1, 'H Shantha', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR21', 'HYD', 'ind', 'AP', '', '', 47, 1, 'Hari Krishna', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR22', 'HYD', 'ind', 'AP', '', '', 50, 2, 'Harish SS', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR23', 'HYD', 'ind', 'AP', '', '', 49, 1, 'JS Ramachandra Moorthy', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR24', 'HYD', 'ind', 'AP', '', '', 62, 1, 'J Sanath Babu', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR25', 'HYD', 'ind', 'AP', '', '', 43, 1, 'Jyothi CR', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR26', 'HYD', 'ind', 'AP', '', '', 41, 1, 'K Pampapati', 0, 'Male', 'VP', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR27', 'HYD', 'ind', 'AP', '', '', 31, 1, 'K Pratibha', 0, 'Female', 'PV', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR28', 'HYD', 'ind', 'AP', '', '', 63, 1, 'KR Lakshmi', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR29', 'HYD', 'ind', 'AP', '', '', 58, 1, 'Kalavathi K', 0, 'Female', 'VK', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR3', 'HYD', 'ind', 'AP', '', '', 17, 1, 'Avanish B', 0, 'Male', 'Pv', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR30', 'HYD', 'ind', 'AP', '', '', 58, 1, 'Krishnaprasad S', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR31', 'HYD', 'ind', 'AP', '', '', 51, 1, 'Lalitha K', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR32', 'HYD', 'ind', 'AP', '', '', 70, 1, 'Lilavathi KH', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR33', 'HYD', 'ind', 'AP', '', '', 49, 1, 'M Parvathi', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR34', 'HYD', 'ind', 'AP', '', '', 53, 1, 'Madhavi Krishnaprasad', 0, 'Female', 'VP', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR35', 'HYD', 'ind', 'AP', '', '', 58, 1, 'Mangaratnama', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR36', 'HYD', 'ind', 'AP', '', '', 30, 1, 'Manojkumar Gupta K', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR37', 'HYD', 'ind', 'AP', '', '', 28, 1, 'Mehaboob Basha', 0, 'Male', 'P', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR38', 'HYD', 'ind', 'AP', '', '', 15, 1, 'N Nikitha', 0, 'Female', 'Vp', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR39', 'HYD', 'ind', 'AP', '', '', 59, 1, 'N Sathyanarayana', 0, 'Male', 'P', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR4', 'HYD', 'ind', 'AP', '', '', 47, 1, 'B Geeta vijaykumar', 0, 'Female', 'V', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR40', 'HYD', 'ind', 'AP', '', '', 52, 1, 'N Sudha', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR41', 'HYD', 'ind', 'AP', '', '', 50, 1, 'Nirmala Giraddi', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR42', 'HYD', 'ind', 'AP', '', '', 67, 1, 'Nirmala Guduthur', 0, 'Female', 'VP', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR43', 'HYD', 'ind', 'AP', '', '', 9, 1, 'Nirupama', 0, 'Female', 'P', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR44', 'HYD', 'ind', 'AP', '', '', 46, 1, 'P Basavaraju', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR45', 'HYD', 'ind', 'AP', '', '', 55, 1, 'P Rajeshwari', 0, 'Female', 'Vk', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR46', 'HYD', 'ind', 'AP', '', '', 62, 1, 'P Viresh Shetty', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR47', 'HYD', 'ind', 'AP', '', '', 37, 1, 'Padmavathi S', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR48', 'HYD', 'ind', 'AP', '', '', 66, 1, 'Parvatamma D', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR49', 'HYD', 'ind', 'AP', '', '', 36, 1, 'Pavitra K', 0, 'Female', 'P', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR5', 'HYD', 'ind', 'AP', '', '', 74, 1, 'B Narayan Setty', 0, 'Male', 'v', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR50', 'HYD', 'ind', 'AP', '', '', 42, 1, 'Pooja Chilukur', 0, 'Female', 'VP', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR51', 'HYD', 'ind', 'AP', '', '', 46, 1, 'Raghunandan D', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR52', 'HYD', 'ind', 'AP', '', '', 16, 1, 'Rishitha D', 0, 'Female', 'PK', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR53', 'HYD', 'ind', 'AP', '', '', 59, 1, 'S Narasimhappa', 0, 'Male', 'VK', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR54', 'HYD', 'ind', 'AP', '', '', 48, 1, 'Santosh kumar G', 0, 'Male', 'VK', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR55', 'HYD', 'ind', 'AP', '', '', 43, 1, 'Sapna Soryppu', 0, 'Female', 'VP', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR56', 'HYD', 'ind', 'AP', '', '', 58, 1, 'Shailaja K', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR57', 'HYD', 'ind', 'AP', '', '', 53, 1, 'Shanthamma KS', 0, 'Female', 'VK', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR58', 'HYD', 'ind', 'AP', '', '', 29, 1, 'Sharvani V', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR59', 'HYD', 'ind', 'AP', '', '', 56, 1, 'Shashikala H', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR6', 'HYD', 'ind', 'AP', '', '', 49, 1, 'B Vijay Kumar', 0, 'Male', 'Vp', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR60', 'HYD', 'ind', 'AP', '', '', 52, 1, 'Sivaram Moka', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR61', 'HYD', 'ind', 'AP', '', '', 52, 1, 'Sreedevi V', 0, 'Female', 'VK', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR62', 'HYD', 'ind', 'AP', '', '', 65, 1, 'Subamma K', 0, 'Female', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR63', 'HYD', 'ind', 'AP', '', '', 53, 1, 'Sudhakar J', 0, 'Male', 'VP', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR64', 'HYD', 'ind', 'AP', '', '', 38, 1, 'Sumalatha D', 0, 'Female', 'VP', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR65', 'HYD', 'ind', 'AP', '', '', 54, 1, 'Suresh C', 0, 'Male', 'VP', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR66', 'HYD', 'ind', 'AP', '', '', 43, 1, 'Suresh S', 0, 'Male', 'v', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR67', 'HYD', 'ind', 'AP', '', '', 46, 1, 'T Sunil Kumar', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR68', 'HYD', 'ind', 'AP', '', '', 47, 1, 'Usha JM', 0, 'Female', 'VP', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR69', 'HYD', 'ind', 'AP', '', '', 74, 1, 'Venugopal Raju', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR7', 'HYD', 'ind', 'AP', '', '', 76, 1, 'BPM Devi', 0, 'Female', 'VP', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR70', 'HYD', 'ind', 'AP', '', '', 51, 1, 'Virupaksha Gouda', 0, 'Male', 'V', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR71', 'HYD', 'ind', 'AP', '', '', 58, 1, 'Y Ranganatharao', 0, 'Male', 'P ', 'YES', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR72', 'PAR', 'ind', 'MH', '', '', 31, 2, 'Nikhil', 9004656749, 'Male', 'v', 'yes', '', '', 'offline', 1, 0, '2019-03-18 07:36:08'),
('EHR73', 'HYD', 'ind', 'HA', 'gauthamrajsunny@gmail.com', '1212-02-21', 807, 1, 'test22', 9063777870, 'Male', 'dsadas', 'yes', '', 'telangana', 'offline', 1, 0, '2019-03-22 13:45:21'),
('EHR8', 'HYD', 'ind', 'AP', '', '', 58, 1, 'C Ramesh Babu', 0, 'Male', 'VK', 'yes', '', '', 'offline', 1, 0, '0000-00-00 00:00:00'),
('EHR9', 'HYD', 'ind', 'AP', '', '', 48, 1, 'Dr.M Aparna', 0, 'Female', 'V', 'no', '', '', 'offline', 1, 0, '0000-00-00 00:00:00');

--
-- Triggers `patient_master`
--
DELIMITER $$
CREATE TRIGGER `patient_id_gen` BEFORE INSERT ON `patient_master` FOR EACH ROW BEGIN
  INSERT INTO table_seq VALUES (NULL);
  SET NEW.Patient_ID = CONCAT('EHR', LAST_INSERT_ID());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `patient_medicine`
--

CREATE TABLE `patient_medicine` (
  `id` int(11) NOT NULL,
  `Patient_ID` varchar(50) NOT NULL,
  `Visit_Number` int(11) NOT NULL,
  `Medicine_Type_ID` int(11) NOT NULL,
  `Medicine_Name` varchar(100) NOT NULL,
  `Billable` varchar(10) NOT NULL,
  `Given` int(10) NOT NULL DEFAULT '0',
  `Quantity` varchar(100) DEFAULT NULL,
  `Whenval` varchar(100) DEFAULT NULL,
  `How` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient_medicine`
--

INSERT INTO `patient_medicine` (`id`, `Patient_ID`, `Visit_Number`, `Medicine_Type_ID`, `Medicine_Name`, `Billable`, `Given`, `Quantity`, `Whenval`, `How`) VALUES
(841, 'EHR2', 1, 3, 'Vasakasava', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(842, 'EHR2', 1, 3, 'Drakshasava ', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(843, 'EHR2', 1, 3, 'Ushirasava', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(844, 'EHR2', 1, 6, 'Bhasma Vati', 'yes', 0, '1 Tabs', 'Immediately after meals Morn-Eve', 'with Hot water'),
(845, 'EHR2', 1, 4, 'Pachanamrita', 'yes', 0, '2 tsp', 'Immediately after meals Morn-Eve', 'with Hot water'),
(846, 'EHR2', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop,1 drop', 'Bedtime Morn-After-Eve', 'Both Nostrils with hot water'),
(847, 'EHR2', 1, 5, 'Amritdhara', 'yes', 0, '1-1 drop,1 drop', 'Bedtime Morn-After-Eve', 'Both Nostrils with hot water'),
(848, 'EHR3', 1, 2, 'Punarnava ', 'yes', 0, '3ml,10ml', '30Min Before Meals Morn-Eve', 'With 100ml Hot water'),
(849, 'EHR3', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,10ml', '30Min Before Meals Morn-Eve', 'With 100ml Hot water'),
(850, 'EHR3', 1, 3, 'Ushirasava', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(851, 'EHR3', 1, 3, 'Arjunarishta', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(852, 'EHR3', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(853, 'EHR3', 1, 8, 'Triphala(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(854, 'EHR3', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(855, 'EHR3', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'with Hot water'),
(856, 'EHR3', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'with desi cow milk or hot water'),
(857, 'EHR3', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop', 'Bedtime', 'Both Nostrils 1 drop in Naval'),
(858, 'EHR4', 1, 2, 'Kanchnar', 'yes', 0, ' Kanchnara,Raktashuddhi -3ml, Alovera Ark -10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot water'),
(859, 'EHR4', 1, 2, 'Raktashuddhi', 'yes', 0, ' Kanchnara,Raktashuddhi -3ml, Alovera Ark -10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot water'),
(860, 'EHR4', 1, 2, 'Chobchini', 'yes', 0, ' Kanchnara,Raktashuddhi -3ml, Alovera Ark -10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot water'),
(861, 'EHR4', 1, 3, 'Chandanasava', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with 50ml Hot water'),
(862, 'EHR4', 1, 3, 'Ashokarishta', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with 50ml Hot water'),
(863, 'EHR4', 1, 3, 'Ushirasava', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with 50ml Hot water'),
(864, 'EHR4', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with 50ml Hot water'),
(865, 'EHR4', 1, 3, 'Vasakasava', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with 50ml Hot water'),
(866, 'EHR4', 1, 8, 'Kanchnar(Udupi)', 'yes', 0, '2Tabs 1st week,4tabs 2nd week onwards', 'bs', 'with Ark'),
(867, 'EHR4', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(868, 'EHR4', 1, 4, 'Pachanamrita', 'yes', 0, '2tbs', 'Immediately after meals Morn-Eve', 'with Hot water'),
(869, 'EHR4', 1, 7, 'Phala Ghrita 125gms', 'yes', 0, '1Tbs', 'Bedtime', 'with desi cow milk or hot water'),
(870, 'EHR4', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop', 'Bedtime', 'Both Nostrils on naval'),
(871, 'EHR5', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar,Raktashuddhi,punarnava -3ml, Alovera Ark -10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(872, 'EHR5', 1, 2, 'Punarnava ', 'yes', 0, ' Gudmar,Raktashuddhi,punarnava -3ml, Alovera Ark -10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(873, 'EHR5', 1, 2, 'Raktashuddhi', 'yes', 0, ' Gudmar,Raktashuddhi,punarnava -3ml, Alovera Ark -10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(874, 'EHR5', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar,Raktashuddhi,punarnava -3ml, Alovera Ark -10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(875, 'EHR5', 1, 3, 'Arjunarishta', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(876, 'EHR5', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(877, 'EHR5', 1, 3, 'Drakshasava ', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(878, 'EHR5', 1, 6, 'Bhasma Vati', 'yes', 0, '1 Tabs', 'Immediately after meals Morn-Eve', 'with Hot water'),
(879, 'EHR5', 1, 8, 'Medohar(Nagarjuna)', 'yes', 0, '2 tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(880, 'EHR5', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2 tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(881, 'EHR5', 1, 4, 'Pachanamrita', 'yes', 0, '2TBS', '', ''),
(882, 'EHR5', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1 TBS', 'Bedtime', 'with desi cow milk or hot water'),
(883, 'EHR5', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop', 'Bedtime', 'Both Nostrils'),
(884, 'EHR6', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar,Kanchnara --3ml, Alovera Ark 10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(885, 'EHR6', 1, 2, 'Kanchnar', 'yes', 0, ' Gudmar,Kanchnara --3ml, Alovera Ark 10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(886, 'EHR6', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar,Kanchnara --3ml, Alovera Ark 10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(887, 'EHR6', 1, 3, 'Drakshasava ', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(888, 'EHR6', 1, 3, 'Chandanasava', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(889, 'EHR6', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(890, 'EHR6', 1, 4, 'Madhuveri', 'yes', 0, '2tsp, 1TBS before food with Ark 2Tbs after food', 'Immediately after meals Morn-Eve', 'with Hot water'),
(891, 'EHR6', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp, 1TBS before food with Ark 2Tbs after food', 'Immediately after meals Morn-Eve', 'with Hot water'),
(892, 'EHR6', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'with desi cow milk or hot water'),
(893, 'EHR6', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop,1 drop', 'Bedtime,Whenever throat issues', 'Both Nostrils with hot water'),
(894, 'EHR6', 1, 5, 'Amritdhara', 'yes', 0, '1-1 drop,1 drop', 'Bedtime,Whenever throat issues', 'Both Nostrils with hot water'),
(895, 'EHR7', 1, 2, 'Punarnava ', 'yes', 0, ' Punarnava,Gudmar --3ml mixed with Alovera Ark Ark-10ml, Alovera Ark Ark  10ml Morn empty stomach', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(896, 'EHR7', 1, 2, 'Gudmar', 'yes', 0, ' Punarnava,Gudmar --3ml mixed with Alovera Ark Ark-10ml, Alovera Ark Ark  10ml Morn empty stomach', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(897, 'EHR7', 1, 1, 'Alovera Ark', 'yes', 0, ' Punarnava,Gudmar --3ml mixed with Alovera Ark Ark-10ml, Alovera Ark Ark  10ml Morn empty stomach', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(898, 'EHR7', 1, 3, 'Amrutarishta', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(899, 'EHR7', 1, 3, 'Drakshasava ', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(900, 'EHR7', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(901, 'EHR7', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(902, 'EHR7', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(903, 'EHR7', 1, 9, 'Punarnava mandoor', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(904, 'EHR7', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'with Hot water'),
(905, 'EHR7', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'with desi cow milk or hot water'),
(906, 'EHR7', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop', 'Bedtime', 'Bith Nostrils'),
(907, 'EHR8', 1, 2, 'Kanchnar', 'yes', 0, ' Kanchnara,Punarnava -3ml, Alovera Ark -10ml', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(908, 'EHR8', 1, 2, 'Punarnava ', 'yes', 0, ' Kanchnara,Punarnava -3ml, Alovera Ark -10ml', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(909, 'EHR8', 1, 1, 'Alovera Ark', 'yes', 0, ' Kanchnara,Punarnava -3ml, Alovera Ark -10ml', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(910, 'EHR8', 1, 3, 'Arjunarishta', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(911, 'EHR8', 1, 3, 'Ushirasava', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(912, 'EHR8', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(913, 'EHR8', 1, 6, 'Bhasma Vati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(914, 'EHR8', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(915, 'EHR8', 1, 4, 'Pachanamrita', 'yes', 0, ' Pachanamrita 2tabs, Madhuveri  1tbs before food ,2tbs after food', 'Immediately after meals Morn-Eve', 'with Hot water'),
(916, 'EHR8', 1, 4, 'Madhuveri', 'yes', 0, ' Pachanamrita 2tabs, Madhuveri  1tbs before food ,2tbs after food', 'Immediately after meals Morn-Eve', 'with Hot water'),
(917, 'EHR8', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'bedtime', 'with desi cow milk or hot water'),
(918, 'EHR8', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop', 'Bedtime', 'Both Nostrils'),
(919, 'EHR9', 1, 2, 'Giloy', 'yes', 0, ' Giloy,Gudamr --3ml, Alovera Ark --20ml', '30min before meals Morn-Eve', 'with 100ml Hot Water'),
(920, 'EHR9', 1, 2, 'Gudmar', 'yes', 0, ' Giloy,Gudamr --3ml, Alovera Ark --20ml', '30min before meals Morn-Eve', 'with 100ml Hot Water'),
(921, 'EHR9', 1, 1, 'Alovera Ark', 'yes', 0, ' Giloy,Gudamr --3ml, Alovera Ark --20ml', '30min before meals Morn-Eve', 'with 100ml Hot Water'),
(922, 'EHR9', 1, 3, 'Saraswatarishta', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(923, 'EHR9', 1, 3, 'Amrutarishta', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(924, 'EHR9', 1, 2, 'Punarnava ', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(925, 'EHR9', 1, 8, 'Kaishora(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(926, 'EHR9', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, 'Chandraprabha--2tab,Smritisagar--1tab lick with Ayur Ghee & consume milk after that with Bramhi tab', 'Immediately after meals Morn-Eve', 'Chandraprabha--with Hot water,Smritisagar--with milk'),
(927, 'EHR9', 1, 9, 'Smritisagar Ras', 'yes', 0, 'Chandraprabha--2tab,Smritisagar--1tab lick with Ayur Ghee & consume milk after that with Bramhi tab', 'Immediately after meals Morn-Eve', 'Chandraprabha--with Hot water,Smritisagar--with milk'),
(928, 'EHR9', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'with Hot water'),
(929, 'EHR9', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'with desi cow milk or hot water'),
(930, 'EHR9', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '2-2 drop ', '3 timesa a day', 'Both Nostrils'),
(931, 'EHR10', 1, 2, 'Punarnava ', 'yes', 0, ' Punarnava,Gudmar -3ml, Alovera Ark -10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(932, 'EHR10', 1, 2, 'Gudmar', 'yes', 0, ' Punarnava,Gudmar -3ml, Alovera Ark -10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(933, 'EHR10', 1, 1, 'Alovera Ark', 'yes', 0, ' Punarnava,Gudmar -3ml, Alovera Ark -10ml', '30 Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(934, 'EHR10', 1, 3, 'Amrutarishta', 'yes', 0, '10ml each ', 'Immediately after meals Morn-Eve', 'with Hot water'),
(935, 'EHR10', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10ml each ', 'Immediately after meals Morn-Eve', 'with Hot water'),
(936, 'EHR10', 1, 3, 'Ushirasava', 'yes', 0, '10ml each ', 'Immediately after meals Morn-Eve', 'with Hot water'),
(937, 'EHR10', 1, 2, 'Punarnava ', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(938, 'EHR10', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(939, 'EHR10', 1, 8, 'Mahayogiraj', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(940, 'EHR10', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(941, 'EHR10', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'with Hot water'),
(942, 'EHR10', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'bedtime', 'with desi cow milk or hot water'),
(943, 'EHR10', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop', 'Bedtime', 'Both Nostrils'),
(944, 'EHR10', 1, 11, 'Castor Oil', 'yes', 0, '1 spoon', ' Bedtime', 'with Hot water'),
(960, 'EHR12', 1, 2, 'Plain ', 'yes', 0, '', '30 Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(961, 'EHR12', 1, 3, 'Dashamularishta', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(962, 'EHR12', 1, 3, 'Vasakasava', 'yes', 0, '10ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(963, 'EHR12', 1, 6, 'Bhasma Vati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(964, 'EHR12', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(965, 'EHR12', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(966, 'EHR12', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'with Hot water'),
(967, 'EHR12', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop', 'Bedtime', 'Both Nostrils'),
(968, 'EHR13', 1, 2, 'Kanchnar', 'yes', 0, ' Kanchnara,Gudmar,Raktashuddhi --3ml, Alovera Ark --10ml', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(969, 'EHR13', 1, 2, 'Gudmar', 'yes', 0, ' Kanchnara,Gudmar,Raktashuddhi --3ml, Alovera Ark --10ml', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(970, 'EHR13', 1, 2, 'Raktashuddhi', 'yes', 0, ' Kanchnara,Gudmar,Raktashuddhi --3ml, Alovera Ark --10ml', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(971, 'EHR13', 1, 1, 'Alovera Ark', 'yes', 0, ' Kanchnara,Gudmar,Raktashuddhi --3ml, Alovera Ark --10ml', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(972, 'EHR13', 1, 3, 'Arjunarishta', 'yes', 0, '10 ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(973, 'EHR13', 1, 3, 'Drakshasava ', 'yes', 0, '10 ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(974, 'EHR13', 1, 6, 'Madhuvati', 'yes', 0, '1 Tabs', 'Immediately after meals Morn-Eve', 'with Hot water'),
(975, 'EHR13', 1, 8, 'Kanchnar(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(976, 'EHR13', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'with Hot water'),
(977, 'EHR13', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', ''),
(978, 'EHR13', 1, 7, 'Phala Ghrita 125gms', 'yes', 0, '1tbs', 'Bedtime', 'with desi cow milk or hot water'),
(979, 'EHR13', 1, 5, 'PG Drops', 'yes', 0, '2-2 drops', 'Afternoon- Night', 'Both Nostrils'),
(980, 'EHR13', 1, 11, 'Castor Oil', 'yes', 0, '5ml', 'Bedtime', ''),
(981, 'EHR14', 1, 2, 'Kanchnar', 'yes', 0, ' Kanchanar,Punarnava -3ml, Alovera Ark --10ml', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(982, 'EHR14', 1, 2, 'Punarnava ', 'yes', 0, ' Kanchanar,Punarnava -3ml, Alovera Ark --10ml', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(983, 'EHR14', 1, 1, 'Alovera Ark', 'yes', 0, ' Kanchanar,Punarnava -3ml, Alovera Ark --10ml', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(984, 'EHR14', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10ml', 'Immediately after meals Morn-Eve', 'With Hot water'),
(985, 'EHR14', 1, 6, 'Bhasma Vati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(986, 'EHR14', 1, 8, 'Kanchnar(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(987, 'EHR14', 1, 8, 'Medohar(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(988, 'EHR14', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(989, 'EHR14', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'with desi cow milk or hot water'),
(990, 'EHR14', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop', ' Bedtime', 'Both Nostrils'),
(991, 'EHR15', 1, 2, 'Plain ', 'yes', 0, '2ml', '30 Min Before Meals Morn-Eve', 'with 100 ml hot water'),
(992, 'EHR15', 1, 3, 'Vasakasava', 'yes', 0, '10ml each', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(993, 'EHR15', 1, 3, 'Drakshasava ', 'yes', 0, '10ml each', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(994, 'EHR15', 1, 2, 'Punarnava ', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(995, 'EHR15', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(996, 'EHR15', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop', 'Immediately after meals Morn-Eve', 'With Hot water'),
(999, 'EHR17', 1, 2, 'Kanchnar', 'yes', 0, ' Kanchnara , Punarnava , Gudmar -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1000, 'EHR17', 1, 2, 'Punarnava ', 'yes', 0, ' Kanchnara , Punarnava , Gudmar -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1001, 'EHR17', 1, 2, 'Gudmar', 'yes', 0, ' Kanchnara , Punarnava , Gudmar -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1002, 'EHR17', 1, 1, 'Alovera Ark', 'yes', 0, ' Kanchnara , Punarnava , Gudmar -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1003, 'EHR17', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1004, 'EHR17', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1005, 'EHR17', 1, 6, 'Madhuvati', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1006, 'EHR17', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1007, 'EHR17', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp,-2tbs before food with Ark 2tsp after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1008, 'EHR17', 1, 4, 'Madhuveri', 'yes', 0, '2tsp,-2tbs before food with Ark 2tsp after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1009, 'EHR17', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1010, 'EHR17', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both Nostrils,Both eyes'),
(1011, 'EHR17', 1, 5, 'Netranjan', 'yes', 0, '1-1drop', 'Bedtime', 'Both Nostrils,Both eyes'),
(1012, 'EHR18', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar , Raktashuddhi -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1013, 'EHR18', 1, 2, 'Raktashuddhi', 'yes', 0, ' Gudmar , Raktashuddhi -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1014, 'EHR18', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar , Raktashuddhi -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1015, 'EHR18', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1016, 'EHR18', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1017, 'EHR18', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1018, 'EHR18', 1, 2, 'Punarnava ', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1019, 'EHR18', 1, 8, 'Kanchnar(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1020, 'EHR18', 1, 8, 'Mahayogiraj', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1021, 'EHR18', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1022, 'EHR18', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1023, 'EHR18', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1024, 'EHR18', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1025, 'EHR19', 1, 2, 'Raktashuddhi', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1026, 'EHR19', 1, 2, 'Chobchini', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1027, 'EHR19', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1028, 'EHR19', 1, 3, 'Abhayarishta', 'yes', 0, '10 ml each', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1029, 'EHR19', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1030, 'EHR19', 1, 8, 'Kanchnar(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1031, 'EHR19', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1032, 'EHR19', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1033, 'EHR19', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1034, 'EHR19', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1035, 'EHR19', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1036, 'EHR20', 1, 2, 'Kanchnar', 'yes', 0, '3ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1037, 'EHR20', 1, 2, 'Gudmar', 'yes', 0, '3ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1038, 'EHR20', 1, 3, 'Drakshasava ', 'yes', 0, '10 ml each', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1039, 'EHR20', 1, 3, 'Dashamularishta', 'yes', 0, '10 ml each', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1040, 'EHR20', 1, 2, 'Punarnava ', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1041, 'EHR20', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1042, 'EHR20', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp,1spoon', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1043, 'EHR20', 1, 4, 'Satavari Kalpa', 'yes', 0, '2tsp,1spoon', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1044, 'EHR20', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1045, 'EHR20', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1046, 'EHR20', 1, 10, 'Dhatri Rasayan', 'yes', 0, '1tsp', 'Morn-Eve', ''),
(1047, 'EHR21', 1, 2, 'Gudmar', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1048, 'EHR21', 1, 2, 'Kanchnar', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1049, 'EHR21', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1050, 'EHR21', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1051, 'EHR21', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1052, 'EHR21', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1053, 'EHR21', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1054, 'EHR21', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1055, 'EHR21', 1, 11, 'Angamardan', 'yes', 0, '', '', 'Application on back'),
(1056, 'EHR22', 2, 2, 'Gudmar', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1057, 'EHR22', 2, 2, 'Kanchnar', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1058, 'EHR22', 2, 2, 'Punarnava ', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1059, 'EHR22', 2, 1, 'Alovera Ark', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1060, 'EHR22', 2, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1061, 'EHR22', 2, 3, 'Vasakasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1062, 'EHR22', 2, 3, 'Dashamularishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1063, 'EHR22', 2, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1064, 'EHR22', 2, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1065, 'EHR22', 2, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1066, 'EHR22', 2, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1067, 'EHR22', 2, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1068, 'EHR23', 1, 2, 'Punarnava ', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1069, 'EHR23', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1070, 'EHR23', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1071, 'EHR23', 1, 8, 'Medohar(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1072, 'EHR23', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1073, 'EHR23', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1074, 'EHR23', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1075, 'EHR23', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1076, 'EHR24', 1, 2, 'Kanchnar', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1077, 'EHR24', 1, 2, 'Chobchini', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1078, 'EHR24', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1079, 'EHR24', 1, 3, 'Ashwagandharishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1080, 'EHR24', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1081, 'EHR24', 1, 3, 'Chandanasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1082, 'EHR24', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1083, 'EHR24', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp-1tbs before food-1tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1084, 'EHR24', 1, 4, 'Madhuveri', 'yes', 0, '2tsp-1tbs before food-1tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1085, 'EHR24', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1086, 'EHR25', 1, 2, 'Gudmar', 'yes', 0, '3ml,15ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1087, 'EHR25', 1, 2, 'Chobchini', 'yes', 0, '3ml,15ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1088, 'EHR25', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,15ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1089, 'EHR25', 1, 3, 'Saraswatarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1090, 'EHR25', 1, 3, 'Chandanasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1091, 'EHR25', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1092, 'EHR25', 1, 6, 'Bhasma Vati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1093, 'EHR25', 1, 8, 'Medohar(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1094, 'EHR25', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1095, 'EHR25', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1096, 'EHR25', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1097, 'EHR25', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1098, 'EHR26', 1, 2, 'Chobchini', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1099, 'EHR26', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1100, 'EHR26', 1, 3, 'Abhayarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1101, 'EHR26', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1102, 'EHR26', 1, 3, 'Vasakasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1103, 'EHR26', 1, 8, 'Triphala(Udupi)', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1104, 'EHR26', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1105, 'EHR26', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1106, 'EHR26', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1107, 'EHR26', 1, 11, 'Angamardan', 'yes', 0, '', '', 'Apply on Knee'),
(1108, 'EHR27', 1, 2, 'Nari Sanjivani', 'yes', 0, '3ml,3ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1109, 'EHR27', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,3ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1110, 'EHR27', 1, 3, 'Ushirasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1111, 'EHR27', 1, 3, 'Dashamularishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1112, 'EHR27', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1113, 'EHR27', 1, 8, 'Kaishora(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1114, 'EHR27', 1, 8, 'Medohar(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1115, 'EHR27', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1116, 'EHR27', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1117, 'EHR28', 1, 2, 'Raktashuddhi', 'yes', 0, ' Raktashuddhi , Chobchini -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1118, 'EHR28', 1, 2, 'Chobchini', 'yes', 0, ' Raktashuddhi , Chobchini -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1119, 'EHR28', 1, 1, 'Alovera Ark', 'yes', 0, ' Raktashuddhi , Chobchini -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1120, 'EHR28', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1121, 'EHR28', 1, 3, 'Dashamularishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1122, 'EHR28', 1, 3, 'Ushirasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1123, 'EHR28', 1, 8, 'Mahayogiraj', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1124, 'EHR28', 1, 8, 'Kaishora(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1125, 'EHR28', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1126, 'EHR28', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1127, 'EHR28', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1128, 'EHR28', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1129, 'EHR28', 1, 11, 'Angamardan', 'yes', 0, '', '', ''),
(1130, 'EHR29', 1, 2, 'Raktashuddhi', 'yes', 0, ' Raktashuddhi , Punarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1131, 'EHR29', 1, 2, 'Punarnava ', 'yes', 0, ' Raktashuddhi , Punarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1132, 'EHR29', 1, 1, 'Alovera Ark', 'yes', 0, ' Raktashuddhi , Punarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1133, 'EHR29', 1, 3, 'Dashamularishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1134, 'EHR29', 1, 3, 'Ashwagandharishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1135, 'EHR29', 1, 6, 'Bhasma Vati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1136, 'EHR29', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1137, 'EHR29', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1138, 'EHR29', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1139, 'EHR29', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1140, 'EHR29', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1141, 'EHR29', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1142, 'EHR30', 1, 2, 'Punarnava ', 'yes', 0, ' Punarnava , Chobchini -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1143, 'EHR30', 1, 2, 'Chobchini', 'yes', 0, ' Punarnava , Chobchini -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1144, 'EHR30', 1, 1, 'Alovera Ark', 'yes', 0, ' Punarnava , Chobchini -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1145, 'EHR30', 1, 3, 'Saraswatarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1146, 'EHR30', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1147, 'EHR30', 1, 6, 'Bhasma Vati', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1148, 'EHR30', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1149, 'EHR30', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1150, 'EHR30', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1151, 'EHR31', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar, Punarnava , Raktashuddhi -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1152, 'EHR31', 1, 2, 'Punarnava ', 'yes', 0, ' Gudmar, Punarnava , Raktashuddhi -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1153, 'EHR31', 1, 2, 'Raktashuddhi', 'yes', 0, ' Gudmar, Punarnava , Raktashuddhi -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1154, 'EHR31', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar, Punarnava , Raktashuddhi -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1155, 'EHR31', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1156, 'EHR31', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1157, 'EHR31', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1158, 'EHR31', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp-2tbs before food with ark-2tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1159, 'EHR31', 1, 4, 'Madhuveri', 'yes', 0, '2tsp-2tbs before food with ark-2tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1160, 'EHR31', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1161, 'EHR32', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar , Kanchnara  -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1162, 'EHR32', 1, 2, 'Kanchnar', 'yes', 0, ' Gudmar , Kanchnara  -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1163, 'EHR32', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar , Kanchnara  -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1164, 'EHR32', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1165, 'EHR32', 1, 3, 'Vasakasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1166, 'EHR32', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1167, 'EHR32', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1168, 'EHR32', 1, 2, 'Punarnava ', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1169, 'EHR32', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1170, 'EHR32', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1171, 'EHR32', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1172, 'EHR32', 1, 4, 'Pachanamrita', 'yes', 0, '-1tbs before food 2tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1173, 'EHR32', 1, 4, 'Madhuveri', 'yes', 0, '-1tbs before food 2tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1174, 'EHR32', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop,1drop', 'Bedtime', 'Both nostrils'),
(1175, 'EHR32', 1, 5, 'Amritdhara', 'yes', 0, '1-1drop,1drop', 'Bedtime', 'Both nostrils'),
(1176, 'EHR32', 1, 11, 'Angamardan', 'yes', 0, '', '', ''),
(1177, 'EHR33', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar , Chobchini  -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1178, 'EHR33', 1, 2, 'Chobchini', 'yes', 0, ' Gudmar , Chobchini  -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1179, 'EHR33', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar , Chobchini  -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1180, 'EHR33', 1, 3, 'Ashwagandharishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1181, 'EHR33', 1, 3, 'Abhayarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1182, 'EHR33', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1183, 'EHR33', 1, 8, 'Trayodashang(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1184, 'EHR33', 1, 8, 'Kanchnar(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1185, 'EHR33', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1186, 'EHR33', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop,1drop', 'Bedtime', 'Both nostrils'),
(1187, 'EHR33', 1, 5, 'Amritdhara', 'yes', 0, '1-1drop,1drop', 'Bedtime', 'Both nostrils'),
(1188, 'EHR33', 1, 11, 'Angamardan', 'yes', 0, '', '', 'Applications'),
(1189, 'EHR34', 1, 2, 'Plain ', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1190, 'EHR34', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1191, 'EHR34', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1192, 'EHR34', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1193, 'EHR34', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1194, 'EHR34', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1195, 'EHR34', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop,1drop', 'Bedtime', 'Both nostrils'),
(1196, 'EHR34', 1, 5, 'Amritdhara', 'yes', 0, '1-1drop,1drop', 'Bedtime', 'Both nostrils'),
(1197, 'EHR34', 1, 11, 'Angamardan', 'yes', 0, '', '', ''),
(1198, 'EHR35', 1, 2, 'Raktashuddhi', 'yes', 0, ' Raktashuddhi , Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1199, 'EHR35', 1, 2, 'Kanchnar', 'yes', 0, ' Raktashuddhi , Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1200, 'EHR35', 1, 1, 'Alovera Ark', 'yes', 0, ' Raktashuddhi , Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1201, 'EHR35', 1, 3, 'Dashamularishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1202, 'EHR35', 1, 3, 'Ashwagandharishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1203, 'EHR35', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1204, 'EHR35', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1205, 'EHR35', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1206, 'EHR35', 1, 8, 'Kanchnar(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1207, 'EHR35', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1208, 'EHR35', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop,1drop', 'Bedtime', 'Both nostrils'),
(1209, 'EHR35', 1, 5, 'Amritdhara', 'yes', 0, '1-1drop,1drop', 'Bedtime', 'Both nostrils'),
(1210, 'EHR35', 1, 11, 'Angamardan', 'yes', 0, '', '', 'Applications'),
(1211, 'EHR36', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1212, 'EHR36', 1, 2, 'Kanchnar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1213, 'EHR36', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1214, 'EHR36', 1, 3, 'Ashwagandharishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1215, 'EHR36', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1216, 'EHR36', 1, 3, 'Saraswatarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1217, 'EHR36', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1218, 'EHR36', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1219, 'EHR36', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1220, 'EHR36', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Immediately after meals Morn-Eve', 'With Desi cow milk or Hot water'),
(1221, 'EHR36', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1 drop', 'Bedtime', 'Both Nostrils '),
(1222, 'EHR36', 1, 11, 'Castor Oil', 'yes', 0, '5ml', 'Bedtime', 'With Hot water'),
(1223, 'EHR37', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-15ml mor-eve empty stomach', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1224, 'EHR37', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-15ml mor-eve empty stomach', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1225, 'EHR37', 1, 2, 'Kanchnar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-15ml mor-eve empty stomach', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1226, 'EHR37', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1227, 'EHR37', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1228, 'EHR37', 1, 8, 'Gokshuradi(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1229, 'EHR37', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1230, 'EHR37', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1231, 'EHR37', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both Nostrils 1 drop in navel'),
(1232, 'EHR38', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'with 100 ml Hot water'),
(1233, 'EHR38', 1, 2, 'Kanchnar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'with 100 ml Hot water'),
(1234, 'EHR38', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'with 100 ml Hot water'),
(1235, 'EHR38', 1, 3, 'Saraswatarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1236, 'EHR38', 1, 3, 'Ashwagandharishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1237, 'EHR38', 1, 9, 'Smritisagar Ras', 'yes', 0, '1tab,2tabs', '', 'Crush & lick with Ayu Ghee followed by milk mixed with panchgavya ghrita.'),
(1238, 'EHR38', 1, 9, 'Bramhi', 'yes', 0, '1tab,2tabs', '', 'Crush & lick with Ayu Ghee followed by milk mixed with panchgavya ghrita.'),
(1239, 'EHR38', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1240, 'EHR38', 1, 5, 'PG Drops', 'yes', 0, '1TBS', 'Morn-Bedtime', 'With Desi cow milk or Hot water'),
(1241, 'EHR38', 1, 7, 'Phala Ghrita 125gms', 'yes', 0, '1-1drop', '3 times a day', 'Both Nostils'),
(1242, 'EHR39', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1243, 'EHR39', 1, 2, 'Kanchnar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1244, 'EHR39', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1245, 'EHR39', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1246, 'EHR39', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1247, 'EHR39', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1248, 'EHR39', 1, 3, 'Drakshasava ', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1249, 'EHR39', 1, 8, 'Kaishora(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1250, 'EHR39', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1251, 'EHR39', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1252, 'EHR39', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1253, 'EHR39', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both Nostrils'),
(1254, 'EHR40', 1, 2, 'Raktashuddhi', 'yes', 0, ' Raktashuddhi,Purnarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1255, 'EHR40', 1, 2, 'Punarnava ', 'yes', 0, ' Raktashuddhi,Purnarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1256, 'EHR40', 1, 1, 'Alovera Ark', 'yes', 0, ' Raktashuddhi,Purnarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1257, 'EHR40', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1258, 'EHR40', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1259, 'EHR40', 1, 3, 'Ushirasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1260, 'EHR40', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1261, 'EHR40', 1, 8, 'Kanchnar(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1262, 'EHR40', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1263, 'EHR40', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1264, 'EHR40', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1265, 'EHR40', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1266, 'EHR40', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both Nostrils'),
(1267, 'EHR40', 1, 11, 'Angamardan', 'yes', 0, '', '', ''),
(1268, 'EHR41', 1, 2, 'Raktashuddhi', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1269, 'EHR41', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1270, 'EHR41', 1, 3, 'Dashamularishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1271, 'EHR41', 1, 3, 'Ushirasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1272, 'EHR41', 1, 3, 'Ashwagandharishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1273, 'EHR41', 1, 8, 'Trayodashang(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1274, 'EHR41', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1275, 'EHR41', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1276, 'EHR41', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1277, 'EHR41', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop,1drop', 'Bedtime', 'Both Nostrils,Both eyes'),
(1278, 'EHR41', 1, 5, 'Netraseva', 'yes', 0, '1-1drop,1drop', 'Bedtime', 'Both Nostrils,Both eyes'),
(1279, 'EHR42', 1, 2, 'Punarnava ', 'yes', 0, ' Punarnava,Gudmar -3ml,Alovera Ark-10ml', '30 mIn Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1280, 'EHR42', 1, 2, 'Gudmar', 'yes', 0, ' Punarnava,Gudmar -3ml,Alovera Ark-10ml', '30 mIn Before Meals Morn-Eve', 'With 100 ml Hot water');
INSERT INTO `patient_medicine` (`id`, `Patient_ID`, `Visit_Number`, `Medicine_Type_ID`, `Medicine_Name`, `Billable`, `Given`, `Quantity`, `Whenval`, `How`) VALUES
(1281, 'EHR42', 1, 1, 'Alovera Ark', 'yes', 0, ' Punarnava,Gudmar -3ml,Alovera Ark-10ml', '30 mIn Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1282, 'EHR42', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1283, 'EHR42', 1, 3, 'Chandanasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1284, 'EHR42', 1, 3, 'Ushirasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1285, 'EHR42', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1286, 'EHR42', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tsb', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1287, 'EHR42', 1, 9, 'Saptamrit', 'yes', 0, '2tsb', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1288, 'EHR42', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp,2tsp after food-1tbs before food with Ark ', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1289, 'EHR42', 1, 4, 'Madhuveri', 'yes', 0, '2tsp,2tsp after food-1tbs before food with Ark ', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1290, 'EHR42', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1291, 'EHR42', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both Nostrils,Both eyes'),
(1292, 'EHR42', 1, 5, 'Netraseva', 'yes', 0, '1-1drop', 'Bedtime', 'Both Nostrils,Both eyes'),
(1293, 'EHR43', 1, 3, 'Saraswatarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1294, 'EHR43', 1, 3, 'Ashwagandharishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1295, 'EHR43', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1296, 'EHR43', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1297, 'EHR43', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both Nostrils'),
(1298, 'EHR44', 1, 2, 'Chobchini', 'yes', 0, '4ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1299, 'EHR44', 1, 1, 'Alovera Ark', 'yes', 0, '4ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1300, 'EHR44', 1, 3, 'Saraswatarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1301, 'EHR44', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1302, 'EHR44', 1, 6, 'Bhasma Vati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1303, 'EHR44', 1, 8, 'Kanchnar(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1304, 'EHR44', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1305, 'EHR44', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1306, 'EHR44', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1307, 'EHR45', 1, 2, 'Punarnava ', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1308, 'EHR45', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1309, 'EHR45', 1, 3, 'Vasakasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1310, 'EHR45', 1, 6, 'Madhuvati', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1311, 'EHR45', 1, 8, 'Kanchnar(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1312, 'EHR45', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1313, 'EHR45', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp,1tbs before fod-2tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1314, 'EHR45', 1, 4, 'Madhuveri', 'yes', 0, '2tsp,1tbs before fod-2tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1315, 'EHR45', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1316, 'EHR46', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1317, 'EHR46', 1, 2, 'Kanchnar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1318, 'EHR46', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1319, 'EHR46', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1320, 'EHR46', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1321, 'EHR46', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1322, 'EHR46', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1323, 'EHR46', 1, 4, 'Madhuveri', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1324, 'EHR46', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1325, 'EHR47', 1, 2, 'Raktashuddhi', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1326, 'EHR47', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1327, 'EHR47', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1328, 'EHR47', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1329, 'EHR47', 1, 8, 'Mahayogiraj', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1330, 'EHR47', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1331, 'EHR47', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1332, 'EHR47', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1333, 'EHR47', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1TBS', 'Bedtime', 'With Desi cow milk or Hot water'),
(1334, 'EHR47', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1335, 'EHR48', 1, 2, 'Chobchini', 'yes', 0, ' Chobcini,Punarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1336, 'EHR48', 1, 2, 'Punarnava ', 'yes', 0, ' Chobcini,Punarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1337, 'EHR48', 1, 1, 'Alovera Ark', 'yes', 0, ' Chobcini,Punarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1338, 'EHR48', 1, 3, 'Gomutra asava', 'yes', 0, '5ml.10ml each', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1339, 'EHR48', 1, 3, 'Vasakasava', 'yes', 0, '5ml.10ml each', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1340, 'EHR48', 1, 3, 'Dashamularishta', 'yes', 0, '5ml.10ml each', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1341, 'EHR48', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '5ml.10ml each', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1342, 'EHR48', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1343, 'EHR48', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1344, 'EHR48', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop,1 drop', 'Bedtime , Anytime', 'Both nostrils with hot water'),
(1345, 'EHR48', 1, 5, 'Amritdhara', 'yes', 0, '1-1drop,1 drop', 'Bedtime , Anytime', 'Both nostrils with hot water'),
(1346, 'EHR48', 1, 11, 'Angamardan', 'yes', 0, '', '', 'Application'),
(1347, 'EHR49', 1, 2, 'Nari Sanjivani', 'yes', 0, '3ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1348, 'EHR49', 1, 3, 'Vasakasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1349, 'EHR49', 1, 3, 'Abhayarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1350, 'EHR49', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1351, 'EHR49', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1352, 'EHR49', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1353, 'EHR49', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1354, 'EHR49', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1355, 'EHR49', 1, 11, 'Angamardan', 'yes', 0, '', '', 'Apply'),
(1356, 'EHR50', 1, 2, 'Nari Sanjivani', 'yes', 0, '3ml, 10 ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1357, 'EHR50', 1, 1, 'Alovera Ark', 'yes', 0, '3ml, 10 ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1358, 'EHR50', 1, 3, 'Abhayarishta', 'yes', 0, '10 ml each', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1359, 'EHR50', 1, 3, 'Ushirasava', 'yes', 0, '10 ml each', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1360, 'EHR50', 1, 3, 'Drakshasava ', 'yes', 0, '10 ml each', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1361, 'EHR50', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1362, 'EHR50', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1363, 'EHR50', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1364, 'EHR50', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils put 1 drop in navel'),
(1365, 'EHR51', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1366, 'EHR51', 1, 2, 'Kanchnar', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1367, 'EHR51', 1, 1, 'Alovera Ark', 'yes', 0, ' Gudmar,Kanchnara -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1368, 'EHR51', 1, 2, 'Punarnava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1369, 'EHR51', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1370, 'EHR51', 1, 3, 'Saraswatarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1371, 'EHR51', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1372, 'EHR51', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1373, 'EHR51', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1374, 'EHR51', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1375, 'EHR51', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1376, 'EHR52', 1, 1, 'Alovera Ark', 'yes', 0, '10mleach', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1377, 'EHR52', 1, 3, 'Abhayarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1378, 'EHR52', 1, 3, 'Ushirasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1379, 'EHR52', 1, 3, 'Chandanasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1380, 'EHR52', 1, 8, 'Gokshuradi(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1381, 'EHR52', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1382, 'EHR52', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1383, 'EHR52', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1384, 'EHR52', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1385, 'EHR52', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1386, 'EHR52', 1, 4, 'Satavari Kalpa', 'yes', 0, '1spoon', 'Morn', 'with milk'),
(1387, 'EHR53', 1, 2, 'Punarnava ', 'yes', 0, ' punarnava , gudmar -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1388, 'EHR53', 1, 2, 'Gudmar', 'yes', 0, ' punarnava , gudmar -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1389, 'EHR53', 1, 1, 'Alovera Ark', 'yes', 0, ' punarnava , gudmar -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1390, 'EHR53', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1391, 'EHR53', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1392, 'EHR53', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1393, 'EHR53', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1394, 'EHR53', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp,2tsp after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1395, 'EHR53', 1, 4, 'Madhuveri', 'yes', 0, '2tsp,2tsp after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1396, 'EHR53', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1397, 'EHR54', 1, 2, 'Plain ', 'yes', 0, '3ml', 'Morn', 'With 100 ml Hot water'),
(1398, 'EHR54', 1, 3, 'Chandanasava', 'yes', 0, '2tabs', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1399, 'EHR54', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '2tabs', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1400, 'EHR54', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tsp', 'After food Morn-Eve', ''),
(1401, 'EHR54', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1402, 'EHR54', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1403, 'EHR54', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1404, 'EHR55', 1, 1, 'Alovera Ark', 'yes', 0, '10ml', 'Morn-Eve empty stomach', 'With Hot water'),
(1405, 'EHR55', 1, 3, 'Ushirasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1406, 'EHR55', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1407, 'EHR55', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1408, 'EHR55', 1, 8, 'Kanchnar(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1409, 'EHR55', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1410, 'EHR55', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1411, 'EHR55', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Hot water'),
(1412, 'EHR55', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1413, 'EHR55', 1, 11, 'Castor Oil', 'yes', 0, '1spoon', 'Bedtime', 'With hot water or milk'),
(1414, 'EHR56', 1, 2, 'Punarnava ', 'yes', 0, ' Punarnava,Gudmar -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1415, 'EHR56', 1, 2, 'Gudmar', 'yes', 0, ' Punarnava,Gudmar -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1416, 'EHR56', 1, 1, 'Alovera Ark', 'yes', 0, ' Punarnava,Gudmar -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1417, 'EHR56', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1418, 'EHR56', 1, 3, 'Amrutarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1419, 'EHR56', 1, 3, 'Chandanasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1420, 'EHR56', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1421, 'EHR56', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1422, 'EHR56', 1, 9, 'Punarnava mandoor', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1423, 'EHR56', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1424, 'EHR56', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp-1tbs before food 1 tbs afte food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1425, 'EHR56', 1, 4, 'Madhuveri', 'yes', 0, '2tsp-1tbs before food 1 tbs afte food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1426, 'EHR56', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbss', 'Bedtime', 'With Desi cow milk or Hot water'),
(1427, 'EHR56', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1428, 'EHR57', 1, 2, 'Plain ', 'yes', 0, '3ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1429, 'EHR57', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1430, 'EHR57', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1431, 'EHR57', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1432, 'EHR57', 1, 8, 'Triphala(Udupi)', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1433, 'EHR57', 1, 8, 'Mahayogiraj', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1434, 'EHR57', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1435, 'EHR57', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1436, 'EHR57', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1437, 'EHR57', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1438, 'EHR58', 1, 2, 'Kanchnar', 'yes', 0, ' Kanchnara , Gudmar , Punarnava -4ml,Alovera Ark-15ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1439, 'EHR58', 1, 2, 'Gudmar', 'yes', 0, ' Kanchnara , Gudmar , Punarnava -4ml,Alovera Ark-15ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1440, 'EHR58', 1, 2, 'Punarnava ', 'yes', 0, ' Kanchnara , Gudmar , Punarnava -4ml,Alovera Ark-15ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1441, 'EHR58', 1, 1, 'Alovera Ark', 'yes', 0, ' Kanchnara , Gudmar , Punarnava -4ml,Alovera Ark-15ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1442, 'EHR58', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1443, 'EHR58', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1444, 'EHR58', 1, 6, 'Madhuvati', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1445, 'EHR58', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1446, 'EHR58', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp,2tbs before food-3 tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1447, 'EHR58', 1, 4, 'Madhuveri', 'yes', 0, '2tsp,2tbs before food-3 tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1448, 'EHR58', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1449, 'EHR58', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1450, 'EHR59', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1451, 'EHR59', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1452, 'EHR59', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1453, 'EHR59', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1454, 'EHR60', 1, 2, 'Gudmar', 'yes', 0, ' gudmar , Punarnava -4ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1455, 'EHR60', 1, 2, 'Punarnava ', 'yes', 0, ' gudmar , Punarnava -4ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1456, 'EHR60', 1, 1, 'Alovera Ark', 'yes', 0, ' gudmar , Punarnava -4ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1457, 'EHR60', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1458, 'EHR60', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1459, 'EHR60', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1460, 'EHR60', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1461, 'EHR60', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1462, 'EHR60', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1463, 'EHR61', 1, 2, 'Gudmar', 'yes', 0, ' gudmar , Punarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1464, 'EHR61', 1, 2, 'Punarnava ', 'yes', 0, ' gudmar , Punarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1465, 'EHR61', 1, 1, 'Alovera Ark', 'yes', 0, ' gudmar , Punarnava -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1466, 'EHR61', 1, 3, 'Dashamularishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1467, 'EHR61', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1468, 'EHR61', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1469, 'EHR61', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1470, 'EHR61', 1, 8, 'Mahayogiraj', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1471, 'EHR61', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1472, 'EHR61', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1473, 'EHR61', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1474, 'EHR61', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1475, 'EHR62', 1, 2, 'Raktashuddhi', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1476, 'EHR62', 1, 1, 'Alovera Ark', 'yes', 0, '3ml,10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1477, 'EHR62', 1, 3, 'Abhayarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1478, 'EHR62', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1479, 'EHR62', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1480, 'EHR62', 1, 8, 'Triphala(Udupi)', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1481, 'EHR62', 1, 8, 'Mahayogiraj', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1482, 'EHR62', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1483, 'EHR62', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1484, 'EHR62', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1485, 'EHR62', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1486, 'EHR62', 1, 11, 'Angamardan', 'yes', 0, '', '', ''),
(1487, 'EHR63', 1, 2, 'Punarnava ', 'yes', 0, ' Punarnava , Raktashuddhi -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1488, 'EHR63', 1, 2, 'Raktashuddhi', 'yes', 0, ' Punarnava , Raktashuddhi -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1489, 'EHR63', 1, 1, 'Alovera Ark', 'yes', 0, ' Punarnava , Raktashuddhi -3ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1490, 'EHR63', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1491, 'EHR63', 1, 3, 'Ushirasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1492, 'EHR63', 1, 3, 'Abhayarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1493, 'EHR63', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1494, 'EHR63', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1495, 'EHR63', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1496, 'EHR63', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1497, 'EHR63', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1498, 'EHR64', 1, 2, 'Punarnava ', 'yes', 0, ' punarnava, Gudmar -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1499, 'EHR64', 1, 2, 'Gudmar', 'yes', 0, ' punarnava, Gudmar -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1500, 'EHR64', 1, 1, 'Alovera Ark', 'yes', 0, ' punarnava, Gudmar -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1501, 'EHR64', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1502, 'EHR64', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1503, 'EHR64', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1504, 'EHR64', 1, 9, 'Punarnava mandoor', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1505, 'EHR64', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1506, 'EHR64', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1507, 'EHR64', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1508, 'EHR65', 1, 2, 'Kanchnar', 'yes', 0, ' Kanchnara , Gudmar , Punarnava -4ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1509, 'EHR65', 1, 2, 'Gudmar', 'yes', 0, ' Kanchnara , Gudmar , Punarnava -4ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1510, 'EHR65', 1, 2, 'Punarnava ', 'yes', 0, ' Kanchnara , Gudmar , Punarnava -4ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1511, 'EHR65', 1, 1, 'Alovera Ark', 'yes', 0, ' Kanchnara , Gudmar , Punarnava -4ml,Alovera Ark-10ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1512, 'EHR65', 1, 3, 'Drakshasava ', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1513, 'EHR65', 1, 3, 'Ushirasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1514, 'EHR65', 1, 6, 'Madhuvati', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1515, 'EHR65', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1516, 'EHR65', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1517, 'EHR65', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp,2tbs before food-3 tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1518, 'EHR65', 1, 4, 'Madhuveri', 'yes', 0, '2tsp,2tbs before food-3 tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1519, 'EHR65', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1520, 'EHR66', 1, 2, 'Punarnava ', 'yes', 0, ' punarnava, chobchini -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1521, 'EHR66', 1, 2, 'Chobchini', 'yes', 0, ' punarnava, chobchini -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1522, 'EHR66', 1, 1, 'Alovera Ark', 'yes', 0, ' punarnava, chobchini -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1523, 'EHR66', 1, 3, 'Takrasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1524, 'EHR66', 1, 2, 'Punarnava ', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1525, 'EHR66', 1, 8, 'Abha(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1526, 'EHR66', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1527, 'EHR66', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1528, 'EHR66', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1529, 'EHR66', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1530, 'EHR66', 1, 11, 'Angamardan', 'yes', 0, '', '', 'Apply on knese'),
(1531, 'EHR67', 1, 2, 'Gudmar', 'yes', 0, ' Kanchnara, Gudmar -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1532, 'EHR67', 1, 2, 'Kanchnar', 'yes', 0, ' Kanchnara, Gudmar -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1533, 'EHR67', 1, 1, 'Alovera Ark', 'yes', 0, ' Kanchnara, Gudmar -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1534, 'EHR67', 1, 3, 'Vasakasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1535, 'EHR67', 1, 3, 'Amrutarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1536, 'EHR67', 1, 3, 'Ashwagandharishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1537, 'EHR67', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1538, 'EHR67', 1, 8, 'Kaishora(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1539, 'EHR67', 1, 8, 'Trayodashang(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1540, 'EHR67', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1541, 'EHR67', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1542, 'EHR67', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1543, 'EHR67', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1544, 'EHR68', 1, 2, 'Plain ', 'yes', 0, '3ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1545, 'EHR68', 1, 3, 'Ushirasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1546, 'EHR68', 1, 3, 'Ushirasava', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1547, 'EHR68', 1, 6, 'Haritaki', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1548, 'EHR68', 1, 6, 'Bhasma Vati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1549, 'EHR68', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1550, 'EHR68', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1551, 'EHR68', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1552, 'EHR68', 1, 11, 'Angamardan', 'yes', 0, '', '', 'Apply on legs'),
(1553, 'EHR69', 1, 2, 'Kanchnar', 'yes', 0, ' Kanchnara, Gudmar -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1554, 'EHR69', 1, 2, 'Gudmar', 'yes', 0, ' Kanchnara, Gudmar -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1555, 'EHR69', 1, 1, 'Alovera Ark', 'yes', 0, ' Kanchnara, Gudmar -3ml,Alovera Ark-10ml morn-eve separately empty stomach without water', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1556, 'EHR69', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1557, 'EHR69', 1, 3, 'Dashamularishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1558, 'EHR69', 1, 3, 'Ashwagandharishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1559, 'EHR69', 1, 3, 'Saraswatarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1560, 'EHR69', 1, 8, 'Trayodashang(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1561, 'EHR69', 1, 9, 'Bramhi', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1562, 'EHR69', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1563, 'EHR69', 1, 7, 'Phala Ghrita 125gms', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1564, 'EHR69', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', '3times a day', 'Both nostrils'),
(1565, 'EHR69', 1, 11, 'Angamardan', 'yes', 0, '', '', 'Apply on legs'),
(1566, 'EHR70', 1, 2, 'Kanchnar', 'yes', 0, ' Kanchnara , Gudmar -5ml,Alovera Ark-15ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1567, 'EHR70', 1, 2, 'Gudmar', 'yes', 0, ' Kanchnara , Gudmar -5ml,Alovera Ark-15ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1568, 'EHR70', 1, 1, 'Alovera Ark', 'yes', 0, ' Kanchnara , Gudmar -5ml,Alovera Ark-15ml', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1569, 'EHR70', 1, 3, 'Arjunarishta', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1570, 'EHR70', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1571, 'EHR70', 1, 2, 'Punarnava ', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1572, 'EHR70', 1, 2, 'Kanchnar', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1573, 'EHR70', 1, 8, 'Medohar(Nagarjuna)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1574, 'EHR70', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1575, 'EHR70', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1576, 'EHR70', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1577, 'EHR70', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1578, 'EHR71', 1, 2, 'Punarnava ', 'yes', 0, '', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1579, 'EHR71', 1, 2, 'Gudmar', 'yes', 0, '', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1580, 'EHR71', 1, 1, 'Alovera Ark', 'yes', 0, '', '30 Min Before Meals Morn-Eve', 'With 100 ml Hot water'),
(1581, 'EHR71', 1, 3, 'Punarnavasava(Dhoot)', 'yes', 0, '10mleach', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1582, 'EHR71', 1, 6, 'Madhuvati', 'yes', 0, '1tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1583, 'EHR71', 1, 8, 'Kaishora(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1584, 'EHR71', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, '2tab', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1585, 'EHR71', 1, 4, 'Pachanamrita', 'yes', 0, '2tsp,2tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1586, 'EHR71', 1, 4, 'Madhuveri', 'yes', 0, '2tsp,2tbs after food', 'Immediately after meals Morn-Eve', 'With Hot water'),
(1587, 'EHR71', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1tbs', 'Bedtime', 'With Desi cow milk or Hot water'),
(1588, 'EHR71', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1589, 'EHR71', 1, 11, 'Liv Oil', 'yes', 0, '1spoon', 'bedtime', 'With milk or Hot water'),
(1646, 'EHR11', 1, 2, 'Gudmar', 'yes', 0, ' Gudmar', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(1647, 'EHR11', 1, 2, 'Punarnava', 'yes', 0, ' Gudmar', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(1648, 'EHR11', 1, 2, 'Kanchnar', 'yes', 0, ' Gudmar', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(1649, 'EHR11', 1, 1, 'Alovera Ark', 'yes', 0, ' Alovera Ark -- 20mlÃƒÂ‚Ã‚Â…. Combined together 1 cap', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(1650, 'EHR11', 1, 3, 'Drakshasava', 'yes', 0, 'Kanchnara', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1651, 'EHR11', 1, 3, 'Amrutarishta', 'yes', 0, 'Kanchnara', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1652, 'EHR11', 1, 3, 'Saraswatarishta', 'yes', 0, 'Kanchnara', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1653, 'EHR11', 1, 6, 'Madhuvati', 'yes', 0, ' Alovera Ark -- 20mlÃƒÂ‚Ã‚Â…. Combined together 1 cap', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1654, 'EHR11', 1, 9, 'Punarnava mandoor', 'yes', 0, ' Gudmar', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1655, 'EHR11', 1, 9, 'Chandraprabha(Udupi)', 'yes', 0, ' Gudmar', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1656, 'EHR11', 1, 4, 'Pachanamrita', 'yes', 0, 'Punarnava --3ml', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1657, 'EHR11', 1, 4, 'Madhuveri', 'yes', 0, 'Punarnava --3ml', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1658, 'EHR11', 1, 7, 'Real Ghee 250 ml', 'yes', 0, ' Gudmar', 'Bedtime', 'with desi cow milk or hot water'),
(1659, 'EHR11', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, 'Kanchnara', 'Bedtime & Afternoon Bedtime', 'Ayur Ghee-- Both Nostrils'),
(1660, 'EHR11', 1, 5, 'Netranjan', 'yes', 0, 'Kanchnara', 'Bedtime & Afternoon Bedtime', 'Ayur Ghee-- Both Nostrils'),
(1667, 'EHR72', 1, 1, 'Alovera Ark', 'yes', 1, '', '', ''),
(1668, 'EHR72', 1, 2, 'Nandi', 'yes', 300, '', '', ''),
(1669, 'EHR72', 1, 2, 'Gudmar', 'yes', 200, '', '', ''),
(1670, 'EHR72', 1, 3, 'Khadirarishta', 'yes', 50, '', '', ''),
(1671, 'EHR72', 1, 3, 'Kanakasava', 'yes', 50, '', '', ''),
(1672, 'EHR73', 1, 11, 'Angamardan', 'no', 120, 'ewewdas', 'ewdasd', 'ewewdsada'),
(1673, 'EHR73', 1, 11, 'Bramhi Amla', 'no', 200, 'ewewdas', 'ewdasd', 'ewewdsada'),
(1676, 'EHR16', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '1-1drop', 'Bedtime', 'Both nostrils'),
(1677, 'EHR16', 1, 2, 'Punarnava', 'yes', 0, '3ml', 'Morning empty stomach', ''),
(1678, 'EHR1', 1, 2, 'Gudmar', 'yes', 200, ' Gudmar', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(1679, 'EHR1', 1, 2, 'Raktashuddhi', 'yes', 200, ' Gudmar', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(1680, 'EHR1', 1, 1, 'Alovera Ark', 'yes', 1000, ' Alovera Ark -10ml', '30Min Before Meals Morn-Eve', 'with 100ml Hot Water'),
(1681, 'EHR1', 1, 3, 'Arjunarishta', 'yes', 0, ' Alovera Ark -10ml', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1682, 'EHR1', 1, 3, 'Saraswatarishta', 'yes', 0, ' Alovera Ark -10ml', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1683, 'EHR1', 1, 3, 'Dashamularishta', 'yes', 0, ' Alovera Ark -10ml', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1684, 'EHR1', 1, 6, 'Madhuvati', 'yes', 0, ' Gudmar', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1685, 'EHR1', 1, 8, 'Yogiraj(Udupi)', 'yes', 0, 'Raktashuddhi -3ml', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1686, 'EHR1', 1, 9, 'Bramhi', 'yes', 0, ' Alovera Ark -10ml', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1687, 'EHR1', 1, 4, 'Pachanamrita', 'yes', 0, '10 ml each', 'Immediately after meals Morn-Eve', 'with Hot water'),
(1688, 'EHR1', 1, 7, 'Real Ghee 250 ml', 'yes', 0, '10 ml each', 'bedtime', 'with desi cow milk or hot water'),
(1689, 'EHR1', 1, 5, 'Bramhi- Ayur Ghee', 'yes', 0, '10 ml each', 'Bedtime', 'Both Nostrils'),
(1690, 'EHR1', 1, 11, 'Angamardan', 'yes', 0, '1tab', '', 'For Application Take with Hot Water'),
(1691, '', 1, 1, 'Alovera Ark', 'yes', 500, '', '', ''),
(1692, '', 1, 2, 'Gudmar', 'yes', 200, '', '', ''),
(1693, '', 1, 2, 'Kanchnar', 'yes', 300, '', '', ''),
(1694, '', 1, 4, 'Avipattikar choorna', 'yes', 100, '', '', ''),
(1695, '', 1, 8, 'Trayodashang(Udupi)', 'yes', 120, '', '', ''),
(1696, '', 1, 9, 'Brahmi Vati', 'yes', 60, '', '', ''),
(1697, 'EHR72', 2, 1, 'Alovera Ark', 'yes', 500, 'before food ', '10ml', 'mixed with gomutra Ark & 100ml warm water'),
(1698, 'EHR72', 2, 2, 'Gudmar', 'yes', 300, 'before food', '2.5 ml', 'mixed with alovera & 100ml water'),
(1699, 'EHR72', 2, 2, 'Kanchnar', 'yes', 200, 'before food', '2.5 ml', 'mixed with alovera & 100ml water'),
(1700, 'EHR72', 2, 3, 'Abhayarishta', 'yes', 150, 'after food', '10ml', 'with hot water 10ml'),
(1701, 'EHR72', 2, 3, 'Kumari Asava', 'yes', 150, 'after food', '10ml', 'with hot water 10ml'),
(1702, 'EHR72', 2, 3, 'Arjunarishta', 'yes', 200, 'after food', '10ml', 'with hot water 10ml'),
(1703, 'EHR72', 2, 4, 'Pachanamrita', 'yes', 60, 'after food', '1 tsp', 'with hot water'),
(1704, 'EHR72', 2, 4, 'Hinguvachadi', 'yes', 50, 'after food', '1 tsp', 'with hot water'),
(1705, 'EHR72', 2, 5, 'Bramhi- Ayur Ghee', 'yes', 10, 'bedtime', '2 drops', 'both nostril'),
(1706, 'EHR72', 2, 7, 'Real Ghee 500 ml', 'yes', 500, 'bedtime', '10ml', 'with milk'),
(1707, 'EHR72', 2, 8, 'Trayodashang(Udupi)', 'yes', 60, 'after food', '1 tab', 'crush & take with hot water'),
(1708, 'EHR72', 2, 11, 'Liv Oil', 'yes', 300, 'bedtime', '10ml', 'daily increase 10ml & take with milk');

-- --------------------------------------------------------

--
-- Table structure for table `patient_problem`
--

CREATE TABLE `patient_problem` (
  `id` int(11) NOT NULL,
  `Patient_ID` varchar(50) DEFAULT NULL,
  `Visit_Number` int(11) DEFAULT NULL,
  `PDescription` varchar(1000) DEFAULT NULL,
  `Ayurvedic` varchar(20) DEFAULT NULL,
  `Modern` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient_problem`
--

INSERT INTO `patient_problem` (`id`, `Patient_ID`, `Visit_Number`, `PDescription`, `Ayurvedic`, `Modern`) VALUES
(94, 'EHR1', 1, 'BP tabs since 3 yrs, tension ,Disc protrusion L3-L4,L5ML5-S1,backpain', '', ''),
(95, 'EHR2', 1, 'Asthma since 3-4 yrs', '', ''),
(96, 'EHR3', 1, 'Pitta issues - digestion ,cencentration,vomiting sensations,pimples,heat-burning sensation during urination', '', ''),
(97, 'EHR4', 1, 'gynic issues-multicystic ovr. Drs have advised for hysterectomy, legs swollen, Pitta body,KafaPitta Prameha symptoms', '', ''),
(98, 'EHR5', 1, '2011 Angioplasty, pulse-kafapitta Prameha, Overweight,Circu, kid,liv. Gases, swelling on legs , Diabetes tabs after surgery, drowsiness,', '', ''),
(99, 'EHR6', 1, 'Diabetes tabs since 7yrs, stress ,Pitta--itching , throat irritation, R leg rod inserted- sometime pain after long walk. Eyes sight has increased', '', ''),
(100, 'EHR7', 1, 'Blood Transfusion every 3months past 8yrs-patient fainted--HB levels were around 4, currently it’s around 4.5 before transfusion & around transfusion issue ,Pulse==Majja ,Liv,Kid,Diabeties tablets since 16', '', ''),
(101, 'EHR8', 1, 'BP Tabs since 20yrs,Swelling on legs,Pulse-Pancreas,Liv,Kid', '', ''),
(102, 'EHR9', 1, '5-Nov-17 General ,vata is high,leg pain,sometimes stiffness in fingers ,tensions,history of liver issues.24-jan-18 as per email & phone conversation-much better than before,anxiety still present,all other problems have subsided', '', ''),
(103, 'EHR10', 1, '4 yrs chikan guiya ,since then joint pain started taking tabs, Pulse-Liv,Circu. Excess Sweating', '', ''),
(104, 'EHR11', 1, '5-Nov-17 Diabeties,BP,3 months before vomiting ,giddiness,hypertension,speech was affected 23-jan-18 overall better but BP levels 10 & creatinine is 1.9,, Na ,K levels are normal,bone density is also normal', '', ''),
(105, 'EHR12', 1, 'General sneezing in morning, varicose veins started ,leg pain,small wrats around neck,', '', ''),
(106, 'EHR13', 1, 'Pulse -Ca pulse--MM is high ,negative,Prost issue,Diabetes tabs since 3-4 yrs, Ecosprin past 2 months, Stress, insomnia,Constipation', '', ''),
(107, 'EHR14', 1, 'Over weight 103,Swelling on legs is observed, Pulse -Kid,Circulation', '', ''),
(108, 'EHR15', 1, 'Head ache,Vomiting sensations,gases,cough', '', ''),
(109, 'EHR16', 1, 'General, Pulse- Prostate ', '', ''),
(110, 'EHR17', 1, 'Diabetes tabs since 15 yrs, On insulin since 3 months 25 units in morn, swelling on legs, stress is too high, dry cough day time- specially during eating', '', ''),
(111, 'EHR18', 1, 'Hearing issue since child hood, Bypass 2007, diabetic since 25 yrs, hydrocele L since 8 yrs, prost operated 2000, freq urination, back pain , neck pain ', '', ''),
(112, 'EHR19', 1, 'Umbilicus hernia – developed after hysterectomy in 2000, no pain, homeopathy tabs for –Bone density, thyroid, gases, motions. Bp tabs', '', ''),
(113, 'EHR20', 1, 'Weakness, MM is high, Breathlessness, hysterectomy 20 yrs before, back pain ', '', ''),
(114, 'EHR21', 1, 'Stiffness in back, Pulse- Liv', '', ''),
(115, 'EHR22', 2, '2nd visit Pulse- Heart, circu, Liv, K, heavy breathing, fluctuation sugar levels, acidity, gout history,  ', '', ''),
(116, 'EHR23', 1, 'Obesity, Pulse- MM is high, Liv, Heart. HR is high, freq Urination', '', ''),
(117, 'EHR24', 1, 'Diabetes – 5 yrs Ayurveda, 1yr Allopathy, HR is high- takes tab, weakness, Pulse- Prost, Urine issues', '', ''),
(118, 'EHR25', 1, 'Obesity, Overweight, Kafa Prameha symptoms- freq urination, swelling on legs, BP tabs since 3 yrs, stress, HR is high, Gases.', '', ''),
(119, 'EHR26', 1, 'constipation, head ache, knee pain after accident, acidity, cough in night', '', ''),
(120, 'EHR27', 1, 'vomiting sensations, giddiness, overweight, numbness all over body, late menses, back pain ', '', ''),
(121, 'EHR28', 1, 'Overweight, Gastric- acidity, Leg pain- varicose, BP tabs  ', '', ''),
(122, 'EHR29', 1, 'Body Pains—Leg swollen, Knee pains, edema, Gases, ', '', ''),
(123, 'EHR30', 1, 'Pulse- Liv, Heart, Circul, Pancr. But patient doesn’t feel any symptoms, although VP report shows high stress levels. ', '', ''),
(124, 'EHR31', 1, 'Diabetes Tabs since 18 yrs, on insulin 20- 10 since 2 yrs, swelling on legs, weakness', '', ''),
(125, 'EHR32', 1, 'Diabetes tabs since 3 yrs after angioplasty -4 yrs before, weakness, coughing since 2 months', '', ''),
(126, 'EHR33', 1, 'Diabetes 3 yrs tabs, BP, Sciatica – L, weakness, obesity, overweight, gases, digestion issues', '', ''),
(127, 'EHR34', 1, 'takes Thyroid Homeopathy tabs, Pulse- Circu, Digestion, muscle catch in body, Knee pain', '', ''),
(128, 'EHR35', 1, 'Full body pains, obesity  ', '', ''),
(129, 'EHR36', 1, 'Stress, Constipation, PMEJ, Mouth Ulcers, Knee pain,', '', ''),
(130, 'EHR37', 1, ' 2 yrs before abdominal cramps- back pain- patient tried lot of things- like keeping heavy objects on back to relieve of pain, afterwards allopathic treatment- scan- fatty liv, mri –pancreas, Sugar levels high. Vaidya sees it as clear case of Nabhi dislocation- untreated –resulted in further complications.', '', ''),
(131, 'EHR38', 1, ' Emotional nature, fear factor, case of manoroga- ethereal elements affecting, cant remember whatever spoken few min back, vibrations in nose since 5-6 yrs, 3 yrs before abdominal pain- jaundice- medication, afterwards feats attack, moods uncontrolled – laughing, crying. Sometimes sleepless nights.', '', ''),
(132, 'EHR39', 1, 'MM is high, Prost, patient taking Urimax past 6  yrs, blackishness on face, small moles`on face, BP tabs past 8 yrs', '', ''),
(133, 'EHR40', 1, 'MM is high, Pulse is ca kind, Heart is under tension, hysterectomy was done in 2013,  tiredness, legs are found swollen, leg pain, back pain, circulation issues, thyroid tabs since 30 yrs. ', '', ''),
(134, 'EHR41', 1, ' hysterectomy done 20 yrs back, 8 yrs back hernia opn, back pain, leg pain, HR is high, giddiness, ', '', ''),
(135, 'EHR42', 1, 'Pulse- MM is High, Liv, GB, Circu, Legs swollen, Kafa Prameha Symptoms,  freq urination in night, 5 yrs before before both eyes operated cataract, since 4 months Right eye water secretions, hysterectomy 12 yrs before. Diabetes tabs since 2 yrs', '', ''),
(136, 'EHR43', 1, 'weak memory power, vomiting sensations', '', ''),
(137, 'EHR44', 1, 'Stress levels too high in VP report, patient doesn’t feel any problem, but for 16 yrs from 2000 allergy issues- could –cough- fever. Pulse is ca, MM is high', '', ''),
(138, 'EHR45', 1, 'Diabetes tabs since 4-5 yrs', '', ''),
(139, 'EHR46', 1, ' Diabetes Post meal high, tabs since 10 yrs, high stress, High HR, gastric, little chest pain ', '', ''),
(140, 'EHR47', 1, 'Chikan Guniya since 2 months, body pains', '', ''),
(141, 'EHR48', 1, 'Asthma- winter, BP, leg pain- full swollen, allergy, freq urination ', '', ''),
(142, 'EHR49', 1, 'Knee pain, freq cough cold,  ', '', ''),
(143, 'EHR50', 1, 'Digestion, Gases ', '', ''),
(144, 'EHR51', 1, 'Pulse- Liv, GB, Right side numbness & pain, giddiness, HIv+- followed medication – afterwards numbess started, ', '', ''),
(145, 'EHR52', 1, 'Abdominal pain, pain in lower back, sonography K stone, weakness, constipation, ', '', ''),
(146, 'EHR53', 1, 'Diabetes since 15 yrs- was on Siddha medicines for almost 12 yrs later shifted to allopathy,1 jan 93/206, BP tabs Pulse- Liv, Prost, Legs swelling. Kafa Pitta Prameha symptoms but no freq urination', '', ''),
(147, 'EHR54', 1, 'General. Body heat. 1 yr back arthroscopy ', '', ''),
(148, 'EHR55', 1, 'Vata is high, gases, swelling all over body, giddiness past one week, vomiting sensations after eating, fungal infections groin area.', '', ''),
(149, 'EHR56', 1, 'bilateral grade 2 renal paranchymal disease, Diabetes since 7 yrs, last yr- severe constipation –once in 10 days, vomiting sensation, swollen neck jaw, back pain, -- creatinine around 3--  3-5 times dialysis, insulin for 7 months now stopped. Lost weight.  Currently BP tabs & Diabetic tabs.', '', ''),
(150, 'EHR57', 1, 'Pulse- Liv, digestion issues, gastric, Body pains- chest pain, abdominal pains, Drowsiness, sleeplessness, Kafa Prameha symptoms   ', '', ''),
(151, 'EHR58', 1, 'Diabetes since 2008- on Insulin since then, las 6 months 20-26-14+20 units, obesity, overweight- sudden gain last 6 months, pimples on face last 6 months', '', ''),
(152, 'EHR59', 1, 'Pulse- Heart issues', '', ''),
(153, 'EHR60', 1, 'Diabetes tabs since a yr, Heart- cardivas tab since 7 months, stress', '', ''),
(154, 'EHR61', 1, 'Kafa Prameha symptoms- freq urination, heaviness, swelling is observed in legs, giddiness, Body pains, Obesity, acidity', '', ''),
(155, 'EHR62', 1, 'Back pain, nerve pain in lower portions, shivering, weakness, ', '', ''),
(156, 'EHR63', 1, ' 2 months before Jaundice, Hep B, Kafa prameha symptoms, legs swollen, back pain', '', ''),
(157, 'EHR64', 1, 'Obesity, dry cough in winter- stays for long, 5 yrs before Hiv +- under medication, Pulse- Liv, heel crack, heat body, poor digestion, gases. ', '', ''),
(158, 'EHR65', 1, 'Diabetes since 15 yrs, recent levels 210/280. BP tabs. Freq urination', '', ''),
(159, 'EHR66', 1, 'Gases, Knee pain, Bp Tabs 3 yrs, ', '', ''),
(160, 'EHR67', 1, 'Diabetes-since 15 yrs fluctuating- due to stress, Bp tabs,cough since many yrs- throat irritation, vision blurredness, alcoholic, Pulse- Stress, Kid, Liv, H. nerve pain after accident in 2008', '', ''),
(161, 'EHR68', 1, 'Leg pains, Body pains, MM is high, chest pain sometimes, ', '', ''),
(162, 'EHR69', 1, 'Paralysis attack 10 months back Right side, polio by birth right leg,  earlier strength in R leg but no strength after attack. BP tabs since 10+ yrs', '', ''),
(163, 'EHR70', 1, 'too much stress, Pulse- Heart, Liv, Kid, HR is around 110,  ', '', ''),
(164, 'EHR71', 1, 'Psoriasis since 20 yrs, Diabetes since 20 yrs, Pulse-Kid, Liv, Bowels', '', ''),
(165, 'EHR72', 1, 'scitica', 'ashwagandha', 'dolo'),
(166, 'EHR73', 1, 'dsadas', 'ashwagandha', 'dolo'),
(167, '', 1, 'Cervical spondelitis, scitica', 'ashwagandha', 'dolo'),
(168, 'EHR72', 2, 'scitica', 'ashwagandha', 'dolo');

-- --------------------------------------------------------

--
-- Table structure for table `patient_reports`
--

CREATE TABLE `patient_reports` (
  `id` int(11) NOT NULL,
  `Patient_ID` varchar(50) DEFAULT NULL,
  `File_Name` varchar(100) DEFAULT NULL,
  `Visit` int(11) DEFAULT NULL,
  `Date` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient_reports`
--

INSERT INTO `patient_reports` (`id`, `Patient_ID`, `File_Name`, `Visit`, `Date`) VALUES
(1, 'EHR72', 'one.jpg', 1, '2019-02-01'),
(2, 'EHR73', 'one.jpg', 1, '2019-02-01'),
(3, 'EHR74', 'two.jpg', 1, '2019-02-01'),
(4, 'EHR75', 'one.jpg', 1, '2019-02-01'),
(5, 'EHR76', 'two.jpg', 1, '2019-02-01'),
(6, 'EHR80', 'one.jpg', 1, '2019-02-01'),
(7, 'EHR81', 'one.jpg', 1, '2019-02-01'),
(8, 'EHR82', 'one.jpg', 1, '2019-02-01'),
(9, 'EHR83', 'two.jpg', 1, '2019-02-01'),
(10, 'EHR1', '3step password.doc', 1, '2019-02-12'),
(11, 'EHR84', 'anil_DT20174030306_HT.pdf', 1, '2019-02-12'),
(12, 'EHR85', 'Koala.jpg', 1, '2019-02-18'),
(13, 'EHR86', 'Koala.jpg', 1, '2019-02-18'),
(14, 'EHR86', 'Chrysanthemum.jpg', 2, '2019-02-18'),
(15, '/', 'notes.php', 1, '2019-02-23'),
(16, '/', 'chandanaresume.docx', 1, '2019-02-23'),
(17, 'EHR88', 'Koala.jpg', 1, '2019-03-07'),
(19, 'EHR73', 'Screenshot from 2019-03-11 23-12-18.png', 1, '2019-03-22');

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE `state` (
  `id` int(11) NOT NULL,
  `State_ID` varchar(10) NOT NULL,
  `State_Name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`id`, `State_ID`, `State_Name`) VALUES
(1, 'AN', 'Andaman and Nicobar '),
(2, 'AP', 'Andhra Pradesh'),
(3, 'AR', 'Arunachal Pradesh'),
(4, 'AS', 'Assam'),
(5, 'BI', 'Bihar'),
(6, 'CD', 'Chandigarh'),
(7, 'CH', 'Chhattisgarh'),
(8, 'DD', 'Daman and Diu'),
(9, 'DE', 'Delhi'),
(10, 'DN', 'Dadra and Nagar Have'),
(11, 'GJ', 'Gujarat'),
(12, 'GO', 'Goa'),
(13, 'HA', 'Haryana'),
(14, 'HP', 'Himachal Pradesh'),
(15, 'JH', 'Jharkhand'),
(16, 'JK', 'Jammu and Kashmir'),
(17, 'KE', 'Kerala'),
(18, 'KR', 'Karnataka'),
(19, 'LD', 'Lakshadweep'),
(20, 'ME', 'Meghalaya'),
(21, 'MH', 'Maharashtra'),
(22, 'MI', 'Mizoram'),
(23, 'MN', 'Manipur'),
(24, 'MP', 'Madhya Pradesh'),
(25, 'NA', 'Nagaland'),
(26, 'OD', 'Odisha'),
(27, 'PD', 'Puducherry'),
(28, 'PJ', 'Punjab'),
(29, 'RJ', 'Rajasthan'),
(30, 'SK', 'Sikkim'),
(31, 'TM', 'Tamil Nadu'),
(32, 'TR', 'Tripura'),
(33, 'UK', 'Uttarakhand'),
(34, 'UP', 'Uttar Pradesh'),
(35, 'WB', 'West Bengal');

-- --------------------------------------------------------

--
-- Table structure for table `stock_master`
--

CREATE TABLE `stock_master` (
  `id` int(11) NOT NULL,
  `Medicine_Name` varchar(200) NOT NULL,
  `Available` int(11) DEFAULT NULL,
  `Weight` int(11) DEFAULT NULL,
  `Brand_Name` varchar(100) DEFAULT NULL,
  `Short_Form` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `stock_master`
--

INSERT INTO `stock_master` (`id`, `Medicine_Name`, `Available`, `Weight`, `Brand_Name`, `Short_Form`) VALUES
(1, 'Alovera Ark', 32499, 500, 'Goseva', 'AL'),
(2, 'Alovera Juice', 14499, 500, 'Goseva', 'ALJ'),
(3, 'Arjun', 1500, 500, 'Goseva', 'ARJ'),
(4, 'Balpal', 600, 240, 'Goseva', 'BLPL'),
(5, 'Chobchini', 15000, 500, 'Goseva', 'CH'),
(6, 'Giloy', 1080, 500, 'Goseva', 'GI'),
(7, 'Gudmar', -300, 500, 'Goseva', 'GUD'),
(8, 'Kanchnar', 11198, 500, 'Goseva', 'KCH'),
(9, 'Manjishtha', 1200, 500, 'Goseva', 'MJ'),
(10, 'Nandi', 4000, 500, 'Goseva', 'ND'),
(11, 'Nari Sanjivani', 40000, 500, 'Goseva', 'NS'),
(12, 'Pashanbhed', 0, 500, 'Goseva', 'PSH'),
(13, 'Plain ', 0, 500, 'Goseva', 'PLAIN'),
(14, 'Punarnava ', 3997, 500, 'Goseva', 'PU'),
(15, 'Raktashuddhi', 12900, 500, 'Goseva', 'RKT'),
(16, 'Saptarangi', 500, 500, 'Goseva', 'SPT'),
(17, 'Sarpgandha', 600, 500, 'Goseva', 'SRP'),
(18, 'Tulasi', 1000, 500, 'Goseva', 'TU'),
(19, 'Abhayarishta', 5400, 530, 'Dhootpapeswr', 'ABH'),
(20, 'Amrutarishta', 1350, 540, 'Dhootpapeswr', 'AMR'),
(21, 'Arjunarishta', 7650, 535, 'Unjha', 'ARJ'),
(22, 'Ashokarishta', 896, 550, 'Unjha', 'ASH'),
(23, 'Ashwagandharishta', 3600, 520, 'Dhootpapeswr', 'ASHW'),
(24, 'Chandanasava', 600, 525, 'Dhootpapeswr', 'CHN'),
(25, 'Dashamularishta', 0, 0, 'Unjha', 'DSH'),
(26, 'Drakshasava ', 0, 0, 'Unjha', 'DRKSH'),
(27, 'Drakshora', 5625, 325, 'Unjha', 'DRKSH'),
(28, 'Gomutra asava', 15000, 500, 'Goseva', 'GASAV'),
(29, 'Jirakararishta', 8100, 535, 'Unjha', 'JRK'),
(30, 'Kanakasava', 1800, 515, 'Dhootpapeswr', 'KNK'),
(31, 'Khadirarishta', -4, 0, 'Unjha', 'KHR'),
(32, 'Kumari Asava', 6300, 520, 'Dhootpapeswr', 'KUSAVA'),
(33, 'Kutajarishta', 350, 550, 'Unjha', 'KTJ'),
(34, 'Lodhrasava', 4350, 505, 'Dhootpapeswr', 'LODH'),
(35, 'Mahamanjishthadi Qath', 1700, 520, 'Dhootpapeswr', 'MAHM'),
(36, 'Maharasnadi Qath', 0, 0, 'Dhootpapeswr', 'MAHR'),
(37, 'Punarnavasava(Dhoot)', 598, 235, 'Dhootpapeswr', 'PUSAVA'),
(38, 'Punarnavasava(Unjha)', 6300, 540, 'unjha', 'PUSAVA'),
(39, 'Saraswatarishta', 0, 0, 'Unjha', 'SRSW'),
(40, 'Takrarishta', 5000, 500, 'Goseva', 'TKRS'),
(41, 'Takrasava', 5000, 500, 'Goseva', 'TKR'),
(42, 'Vasakasava', 5000, 500, 'Goseva', 'VS'),
(43, 'Ushirasava', 4950, 501, 'Dhootpapeswr', 'USH'),
(44, 'Avipattikar choorna', -100, 50, 'Udupi', 'APC'),
(45, 'Charma ', 0, 50, 'Udupi', 'CC'),
(46, 'Haridra Khand', 0, 0, 'Udupi', 'HKC'),
(47, 'Hinguvachadi', -1, 0, 'Udupi', 'HVC'),
(48, 'Kottam Chukkli', 0, 50, 'Udupi', 'KCC'),
(49, 'Madhuveri', 3500, 130, 'Goseva', 'MDHV'),
(50, 'Pachanamrita', 3360, 80, 'Goseva', 'PCH'),
(51, 'Satavari Kalpa', 100, 10, 'Goseva', 'SK'),
(52, 'Sitopaladi', 450, 50, 'Udupi', 'SIC'),
(53, 'Talisadi', 150, 50, 'Udupi', 'TLC'),
(54, 'Triphala', NULL, 50, 'Udupi', 'TC'),
(55, 'Veeryashodhan Choorna', 200, 125, 'Unjha', 'VRYC'),
(56, 'Amritdhara', 39, 15, 'Home', 'ADROPS'),
(57, 'Bramhi- Ayur Ghee', -10, 52, 'Goseva', 'AYUR'),
(58, 'Netraseva', 10, 10, 'Goseva', 'NS'),
(59, 'Netranjan', 765, 22, 'Goseva', 'NETRA'),
(60, 'PG Drops', 79, 50, 'Goseva', 'PG'),
(61, 'Arjun', 1500, 70, 'Goseva', 'ARJ'),
(62, 'Bhasma Vati', 2160, 80, 'Goseva', 'BH'),
(63, 'Giloy', 1560, 70, 'Goseva', 'GI'),
(64, 'Haritaki', 959, 70, 'Goseva', 'HRT'),
(65, 'Madhuvati', 3600, 70, 'Goseva', 'MDH'),
(66, 'Manjishtha', 840, 82, 'Goseva', 'MJ'),
(67, 'Panchgavya', 1320, 65, 'Goseva', 'PCH'),
(68, 'Punarnava Vati', 840, 80, 'Goseva', 'PU'),
(69, 'Sarpgandha', 1320, 70, 'Goseva', 'SRP'),
(70, 'Triphala', NULL, 75, 'Goseva', 'TRI'),
(71, 'Tulasi Vati', 3480, 75, 'Goseva', 'TU'),
(72, 'PG Ghrita 250 gm', 4250, 251, 'Goseva', 'PG'),
(73, 'Phala Ghrita 125gms', 1100, 125, 'Nagarjuna', 'PHG'),
(74, 'Phala Ghrita 250gms', 0, 250, 'Nagarjuna', 'PHG'),
(75, 'Real Ghee 250 ml', 7250, 475, 'Goseva', 'RG'),
(76, 'Real Ghee 500 ml', 4500, 922, 'Goseva', 'RG'),
(77, 'Triphala Ghritam 125 gms', 2400, 125, 'Nagarjuna', 'TRG'),
(78, 'Triphala Ghritam 250 gms', 0, 250, 'Nagarjuna', 'TRG'),
(79, 'Abha(Nagarjuna)', 240, 47, 'Nagarjuna', 'ABHA'),
(80, 'Abha(Unjha)', 560, 30, 'Unjha', 'ABHA'),
(81, 'Abha 40 tab', 0, 0, 'Unjha', 'ABHA'),
(82, 'Abha 80 tab', 400, 30, 'Unjha', 'ABHA'),
(83, 'Amrutadi', 1200, 0, 'Udupi', 'AMR'),
(84, 'Gokshuradi(Udupi)', 1080, 40, 'Udupi', 'GOK'),
(85, 'Gokshuradi(Dhoot)', 60, 32, 'Dhoopapeswar', 'GOK'),
(86, 'Gokshuradi(Unjha)80 tabs', 2000, 31, 'Unjha', 'GOK'),
(87, 'Kaishora(Udupi)', 180, 35, 'Udupi', 'KAI'),
(88, 'Kaishora(Unjha)', 420, 26, 'Unjha', 'KAI'),
(89, 'Kaishora(Dhoot)', 540, 30, 'Dhoopapeswar', 'KAI'),
(90, 'Kaishora 80 tab(Unjha)', 560, 30, 'Unjha', 'KAI'),
(91, 'Kanchnar(Udupi)', 360, 30, 'Udupi', 'KCH'),
(92, 'Kanchnar(Dhoot)', 360, 30, 'Dhoopapeswar', 'KCH'),
(93, 'Kanchnar(Unjha)', 240, 28, 'Unjha', 'KCH'),
(94, 'Kanchnar 200 tab(Unjha)', 200, 68, 'Unjha', 'KCH'),
(95, 'Lakshadi(Udupi)', 720, 30, 'Udupi', 'LHK'),
(96, 'Lakshadi(Dhoot)', 300, 30, 'Dhoopapeswar', 'LHK'),
(97, 'Mahayogiraj', NULL, 15, 'Unjha', 'MAHY'),
(98, 'Mahayogiraj', NULL, 15, 'Unjha', 'MAHY'),
(99, 'Medohar(Nagarjuna)', 180, 45, 'Nagarjuna', 'MED'),
(100, 'Medohar 80 tabs(Unjha)', 960, 45, 'Unjha', 'MED'),
(101, 'Navaka Guggulu', 0, 0, 'Udupi', 'NAV'),
(102, 'simhanada(Udupi)', 1320, 50, 'Udupi', 'SIM'),
(103, 'simhanada(Dhoop)', 60, 35, 'Dhoopapeswar', 'SIM'),
(104, 'Trayodashang(Udupi)', -120, 0, 'Udupi', 'TRAYO'),
(105, 'Trayodashang(Dhoop)', 540, 55, 'Dhoopapeswar', 'TRAYO'),
(106, 'Trayodashang 40 tab(Unjha)', 0, 0, 'Unjha', 'TRAYO'),
(107, 'Triphala(Udupi)', 240, 20, 'Udupi', 'TRP'),
(108, 'Triphala(Unjha)', 480, 30, 'Unjha', 'TRP'),
(109, 'Triphala Guggulu 60 tab(Unjha)', 480, 28, 'Unjha', 'TRP'),
(110, 'vyoshashi ', 1080, 30, 'Udupi', 'VYO'),
(111, 'Yogiraj(Udupi)', 840, 35, 'Udupi', 'YOG'),
(112, 'Yogiraj(Unjha)', 600, 27, 'Unjha', 'YOG'),
(113, 'Yogiraj 200 tabs(Unjha)', 600, 68, 'Unjha', 'YOG'),
(114, 'Arjun Twak', 1260, 32, 'Nagarjuna', 'ARJT'),
(115, 'Arogyavardhini(Udupi)', 240, 4, 'Udupi', 'ARG'),
(116, 'Arogyavardhini(Dhoot)', 100, 45, 'Dhootpapeswr', 'ARG'),
(117, 'Bilwadi Gutika', 180, 178, 'Udupi', 'BIL'),
(118, 'Brahmi Vati', 360, 31, 'Dhootpapeswr', 'BRMH'),
(119, 'Bramhi', 0, 0, 'Unjha', 'BRMH'),
(120, 'Chandraprabha(Udupi)', -2, 0, 'Udupi', 'CHR'),
(121, 'Chandraprabha(Dhhot)', 0, 0, 'Dhootpapeswr', 'CHR'),
(122, 'Chandraprabha 40 tab(Unjha)', 0, 0, 'Unjha', 'CHR'),
(123, 'Chandraprabha 80 tab(Unjha)', 0, 0, 'Unjha', 'CHR'),
(124, 'ConVit', 1440, 41, 'Home', 'CON'),
(125, 'Cow collestrum', 0, 0, 'Goseva', 'COW'),
(126, 'Dhanvantaram ', 660, 25, 'Udupi', 'DHN'),
(127, 'Garbhpaal Ras', 660, 15, 'Unjha', 'GRBH'),
(128, 'Garbhpaal Ras 80 tab', 880, 16, 'Unjha', 'GRBH'),
(129, 'Kanyalohadi 66', 360, 15, 'Unjha', 'KNY'),
(130, 'Kanyalohadi 75', 300, 16, 'Unjha', 'KNY'),
(131, 'Kanyalohadi 100', 80, 18, 'Unjha', 'KNY'),
(132, 'Kanyalohadi 80 tab(Unjha)', 400, 20, 'Unjha', 'KNY'),
(133, 'Mahasudarshan vati', 1140, 31, 'Unjha', 'MAHS'),
(134, 'Mahasudarshan vati 80 tab', 880, 45, 'Unjha', 'MAHS'),
(135, 'Punarnava mandoor', 480, 17, 'Unjha', 'PUM'),
(136, 'Punarnava mandoor 40 tab', 480, 12, 'Unjha', 'PUM'),
(137, 'Punarvava Mandur', 60, 16, 'Unjha', 'PUM'),
(138, 'Saptamrit', 600, 15, 'Unjha', 'SPT'),
(139, 'Saptamrit 80 tabs', 880, 17, 'Unjha', 'SPT'),
(140, 'Smritisagar Ras', 720, 18, 'Unjha', 'SMR'),
(141, 'Smritisagar Ras 40 tab', 0, 0, 'Unjha', 'SMR'),
(142, 'Sootashekhar Ras(Udupi)', 0, 0, 'Udupi', 'SUT'),
(143, 'Sootashekhar Ras(Dhoot)', 220, 15, 'Dhootpapeswr', 'SUT'),
(144, 'Yashtimadhu', 1200, 30, 'Nagarjuna', 'YSHT'),
(145, 'Alovera Shampoo', 0, 0, 'Goseva', 'ALSHAMPOO'),
(146, 'Angarakshak', 700, 70, 'Goseva', 'ANGR'),
(147, 'Dantmanjan', 700, 70, 'Goseva', 'DNT'),
(148, 'Dhatri Rasayan', 0, 0, 'Unjha', 'DHATRI'),
(149, 'Dhoop', NULL, 75, 'Akola', 'DHOOP'),
(150, 'Dhoop', NULL, 0, 'Goseva', 'DHOOP'),
(151, 'Dhoop', NULL, 59, 'Venumadhuri', 'DHOOP'),
(152, 'Dishwash gel', 750, 279, 'Goseva', 'DISH'),
(153, 'Facepack', 500, 125, 'Goseva', 'FCP'),
(154, 'Floor Cleaner', 0, 0, 'Goseva', 'FLOOR'),
(155, 'Gopika Carbon', 75, 95, 'Goseva', 'GCS'),
(156, 'Gopika Panchgavya Soap', 0, 0, 'Goseva', 'GPS'),
(157, 'Handwash', 2600, 212, 'Goseva', 'HAND'),
(158, 'Honey', 1750, 375, 'Venumadhuri', 'HONEY'),
(159, 'Kesari Gulkand', 1600, 460, 'lion', 'GUL'),
(160, 'Maraham', 90, 50, 'Goseva', 'MARH'),
(161, 'Oxygel', 0, 0, 'Goseva', 'OXY'),
(162, 'Panchagavya Moisturizing lotion', 1000, 122, 'Goseva', 'LOTION'),
(163, 'Shampoo', 375, 145, 'Venumadhuri', 'SHAMPOO'),
(164, 'Shatavari Kalp', 750, 160, 'Dhootpapeswr', 'SHTVARI'),
(165, 'Toilet cleaner', 1000, 502, 'Goseva', 'TOI'),
(166, 'Ubtan', 0, 0, 'Goseva', 'UBT'),
(167, 'Angamardan', 720, 71, 'Goseva', 'ANGM'),
(168, 'Bramhi Amla', 300, 115, 'Goseva', 'BRMHLA'),
(169, 'Castor Oil', 1000, 100, 'Goseva', 'CO'),
(170, 'Liv Oil', 1000, 100, 'Goseva', 'LO');

-- --------------------------------------------------------

--
-- Table structure for table `stock_transaction`
--

CREATE TABLE `stock_transaction` (
  `id` int(11) NOT NULL,
  `Type_Name` varchar(50) NOT NULL DEFAULT '0',
  `Medicine_Name` varchar(50) DEFAULT NULL,
  `Typeval` varchar(50) DEFAULT NULL,
  `Amount` int(11) NOT NULL DEFAULT '0',
  `Updated_By` varchar(50) DEFAULT NULL,
  `Timeval` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='typeval means debit or credit,';

--
-- Dumping data for table `stock_transaction`
--

INSERT INTO `stock_transaction` (`id`, `Type_Name`, `Medicine_Name`, `Typeval`, `Amount`, `Updated_By`, `Timeval`) VALUES
(1, 'Alovera', 'Alovera Ark', 'credit', 5000, '7', '2019-02-09 06:37:53'),
(2, 'Alovera', 'Alovera Ark', 'credit', 14000, '7', '2019-02-18 04:08:44'),
(3, 'Alovera', 'Alovera Ark', 'credit', 1000, '7', '2019-02-18 04:42:20'),
(32, 'Alovera', 'Alovera Ark', 'credit', 10000, '7', '2019-02-20 05:45:51'),
(33, 'Guggulu', 'Amrutadi', 'credit', 1200, '7', '2019-02-20 05:46:18'),
(46, 'Other', 'Honey', 'credit', 1250, '7', '2019-03-07 05:22:13'),
(73, 'Ark', 'Gudmar', 'debit', 200, 'EHR1', '2019-03-16 06:44:23'),
(74, 'Ark', 'Raktashuddhi', 'debit', 200, 'EHR1', '2019-03-16 06:44:23'),
(75, 'Alovera', 'Alovera Ark', 'debit', 1000, 'EHR1', '2019-03-16 06:44:23'),
(76, 'Asava-Arishta', 'Arjunarishta', 'debit', 0, 'EHR1', '2019-03-16 06:44:23'),
(77, 'Asava-Arishta', 'Saraswatarishta', 'debit', 0, 'EHR1', '2019-03-16 06:44:23'),
(78, 'Asava-Arishta', 'Dashamularishta', 'debit', 0, 'EHR1', '2019-03-16 06:44:23'),
(79, 'Ghanavati', 'Madhuvati', 'debit', 0, 'EHR1', '2019-03-16 06:44:23'),
(80, 'Guggulu', 'Yogiraj(Udupi)', 'debit', 0, 'EHR1', '2019-03-16 06:44:23'),
(81, 'Gutika-Vati', 'Bramhi', 'debit', 0, 'EHR1', '2019-03-16 06:44:23'),
(82, 'Choorna', 'Pachanamrita', 'debit', 0, 'EHR1', '2019-03-16 06:44:23'),
(83, 'Ghrita', 'Real Ghee 250 ml', 'debit', 0, 'EHR1', '2019-03-16 06:44:23'),
(84, 'Drops', 'Bramhi- Ayur Ghee', 'debit', 0, 'EHR1', '2019-03-16 06:44:23'),
(85, 'Tailam', 'Angamardan', 'debit', 0, 'EHR1', '2019-03-16 06:44:23'),
(86, 'Ark', 'Gudmar', 'debit', 200, 'EHR1', '2019-03-16 06:46:01'),
(87, 'Ark', 'Raktashuddhi', 'debit', 200, 'EHR1', '2019-03-16 06:46:01'),
(88, 'Alovera', 'Alovera Ark', 'debit', 1000, 'EHR1', '2019-03-16 06:46:01'),
(89, 'Asava-Arishta', 'Arjunarishta', 'debit', 0, 'EHR1', '2019-03-16 06:46:01'),
(90, 'Asava-Arishta', 'Saraswatarishta', 'debit', 0, 'EHR1', '2019-03-16 06:46:01'),
(91, 'Asava-Arishta', 'Dashamularishta', 'debit', 0, 'EHR1', '2019-03-16 06:46:01'),
(92, 'Ghanavati', 'Madhuvati', 'debit', 0, 'EHR1', '2019-03-16 06:46:01'),
(93, 'Guggulu', 'Yogiraj(Udupi)', 'debit', 0, 'EHR1', '2019-03-16 06:46:01'),
(94, 'Gutika-Vati', 'Bramhi', 'debit', 0, 'EHR1', '2019-03-16 06:46:01'),
(95, 'Choorna', 'Pachanamrita', 'debit', 0, 'EHR1', '2019-03-16 06:46:01'),
(96, 'Ghrita', 'Real Ghee 250 ml', 'debit', 0, 'EHR1', '2019-03-16 06:46:01'),
(97, 'Drops', 'Bramhi- Ayur Ghee', 'debit', 0, 'EHR1', '2019-03-16 06:46:01'),
(98, 'Tailam', 'Angamardan', 'debit', 0, 'EHR1', '2019-03-16 06:46:01'),
(99, 'Ark', 'Gudmar', 'debit', 200, 'EHR1', '2019-03-16 07:23:33'),
(100, 'Ark', 'Raktashuddhi', 'debit', 200, 'EHR1', '2019-03-16 07:23:33'),
(101, 'Alovera', 'Alovera Ark', 'debit', 1000, 'EHR1', '2019-03-16 07:23:33'),
(102, 'Asava-Arishta', 'Arjunarishta', 'debit', 0, 'EHR1', '2019-03-16 07:23:33'),
(103, 'Asava-Arishta', 'Saraswatarishta', 'debit', 0, 'EHR1', '2019-03-16 07:23:33'),
(104, 'Asava-Arishta', 'Dashamularishta', 'debit', 0, 'EHR1', '2019-03-16 07:23:33'),
(105, 'Ghanavati', 'Madhuvati', 'debit', 0, 'EHR1', '2019-03-16 07:23:33'),
(106, 'Guggulu', 'Yogiraj(Udupi)', 'debit', 0, 'EHR1', '2019-03-16 07:23:33'),
(107, 'Gutika-Vati', 'Bramhi', 'debit', 0, 'EHR1', '2019-03-16 07:23:33'),
(108, 'Choorna', 'Pachanamrita', 'debit', 0, 'EHR1', '2019-03-16 07:23:33'),
(109, 'Ghrita', 'Real Ghee 250 ml', 'debit', 0, 'EHR1', '2019-03-16 07:23:33'),
(110, 'Drops', 'Bramhi- Ayur Ghee', 'debit', 0, 'EHR1', '2019-03-16 07:23:33'),
(111, 'Tailam', 'Angamardan', 'debit', 0, 'EHR1', '2019-03-16 07:23:33'),
(112, 'Ark', 'Plain ', 'debit', 0, 'EHR15', '2019-03-25 08:29:49'),
(113, 'Asava-Arishta', 'Vasakasava', 'debit', 0, 'EHR15', '2019-03-25 08:29:49'),
(114, 'Asava-Arishta', 'Drakshasava ', 'debit', 0, 'EHR15', '2019-03-25 08:29:49'),
(115, 'Ark', 'Punarnava ', 'debit', 0, 'EHR15', '2019-03-25 08:29:49'),
(116, 'Choorna', 'Pachanamrita', 'debit', 0, 'EHR15', '2019-03-25 08:29:49'),
(117, 'Drops', 'Bramhi- Ayur Ghee', 'debit', 0, 'EHR15', '2019-03-25 08:29:49'),
(118, 'Drops', 'Bramhi- Ayur Ghee', 'debit', 0, 'EHR16', '2019-03-25 08:30:42'),
(119, 'Ark', 'Punarnava ', 'debit', 0, 'EHR16', '2019-03-25 08:30:42'),
(120, 'Drops', 'Bramhi- Ayur Ghee', 'debit', 0, 'EHR16', '2019-03-25 08:31:00'),
(121, 'Ark', 'Punarnava ', 'debit', 0, 'EHR16', '2019-03-25 08:31:00'),
(122, 'Alovera', 'Alovera Ark', 'debit', 500, '', '2019-03-26 06:13:25'),
(123, 'Ark', 'Gudmar', 'debit', 200, '', '2019-03-26 06:13:25'),
(124, 'Ark', 'Kanchnar', 'debit', 300, '', '2019-03-26 06:13:25'),
(125, 'Choorna', 'Avipattikar choorna', 'debit', 100, '', '2019-03-26 06:13:25'),
(126, 'Guggulu', 'Trayodashang(Udupi)', 'debit', 120, '', '2019-03-26 06:13:25'),
(127, 'Gutika-Vati', 'Brahmi Vati', 'debit', 60, '', '2019-03-26 06:13:25');

-- --------------------------------------------------------

--
-- Table structure for table `table_seq`
--

CREATE TABLE `table_seq` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `table_seq`
--

INSERT INTO `table_seq` (`id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48),
(49),
(50),
(51),
(52),
(53),
(54),
(55),
(56),
(57),
(58),
(59),
(60),
(61),
(62),
(63),
(64),
(65),
(66),
(67),
(68),
(69),
(70),
(71),
(72),
(73);

-- --------------------------------------------------------

--
-- Table structure for table `userprofile`
--

CREATE TABLE `userprofile` (
  `Name` varchar(50) NOT NULL,
  `ID` int(11) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Phone` int(11) NOT NULL,
  `Type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `userprofile`
--

INSERT INTO `userprofile` (`Name`, `ID`, `Password`, `Phone`, `Type`) VALUES
('santosh', 1, '12345', 2147483647, 'Doctor'),
('7', 7, 'admin', 1111111, 'Admin'),
('admin', 8, 'admin123', 111111, 'Tech');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ayurvedic`
--
ALTER TABLE `ayurvedic`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ACategory_ID` (`ACategory_ID`);

--
-- Indexes for table `branch_master`
--
ALTER TABLE `branch_master`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Branch_ID` (`Branch_ID`);

--
-- Indexes for table `contact_form`
--
ALTER TABLE `contact_form`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Country_ID` (`Country_ID`);

--
-- Indexes for table `medicine`
--
ALTER TABLE `medicine`
  ADD PRIMARY KEY (`Medicine_ID`),
  ADD KEY `FK_medicines_medtype` (`Medicine_Type_ID`);

--
-- Indexes for table `medicine_type`
--
ALTER TABLE `medicine_type`
  ADD PRIMARY KEY (`Type_ID`);

--
-- Indexes for table `modern`
--
ALTER TABLE `modern`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patient_instruction`
--
ALTER TABLE `patient_instruction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patient_master`
--
ALTER TABLE `patient_master`
  ADD PRIMARY KEY (`Patient_ID`),
  ADD KEY `FK_patient_master_branch_master` (`Branch_ID`),
  ADD KEY `FK_patient_master_country` (`Country_ID`);

--
-- Indexes for table `patient_medicine`
--
ALTER TABLE `patient_medicine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patient_problem`
--
ALTER TABLE `patient_problem`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patient_reports`
--
ALTER TABLE `patient_reports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `state`
--
ALTER TABLE `state`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `State_ID` (`State_ID`);

--
-- Indexes for table `stock_master`
--
ALTER TABLE `stock_master`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_transaction`
--
ALTER TABLE `stock_transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `table_seq`
--
ALTER TABLE `table_seq`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userprofile`
--
ALTER TABLE `userprofile`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ayurvedic`
--
ALTER TABLE `ayurvedic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `branch_master`
--
ALTER TABLE `branch_master`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `contact_form`
--
ALTER TABLE `contact_form`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `medicine_type`
--
ALTER TABLE `medicine_type`
  MODIFY `Type_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `modern`
--
ALTER TABLE `modern`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `patient_instruction`
--
ALTER TABLE `patient_instruction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=155;

--
-- AUTO_INCREMENT for table `patient_medicine`
--
ALTER TABLE `patient_medicine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1709;

--
-- AUTO_INCREMENT for table `patient_problem`
--
ALTER TABLE `patient_problem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=169;

--
-- AUTO_INCREMENT for table `patient_reports`
--
ALTER TABLE `patient_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `state`
--
ALTER TABLE `state`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `stock_master`
--
ALTER TABLE `stock_master`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;

--
-- AUTO_INCREMENT for table `stock_transaction`
--
ALTER TABLE `stock_transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `table_seq`
--
ALTER TABLE `table_seq`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `userprofile`
--
ALTER TABLE `userprofile`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `medicine`
--
ALTER TABLE `medicine`
  ADD CONSTRAINT `FK_medicine_medicine_type` FOREIGN KEY (`Medicine_Type_ID`) REFERENCES `medicine_type` (`Type_ID`);

--
-- Constraints for table `patient_master`
--
ALTER TABLE `patient_master`
  ADD CONSTRAINT `FK_patient_master_branch_master` FOREIGN KEY (`Branch_ID`) REFERENCES `branch_master` (`Branch_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
