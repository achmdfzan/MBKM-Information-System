-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2022 at 05:11 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_mbkm`
--

-- --------------------------------------------------------

--
-- Table structure for table `kontrakmatkul`
--

CREATE TABLE `kontrakmatkul` (
  `KODE_MK` varchar(10) NOT NULL,
  `NIM` varchar(10) NOT NULL,
  `NILAI` float DEFAULT NULL,
  `ID_KONTRAKMATKUL` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `kontrakmbkm`
--

CREATE TABLE `kontrakmbkm` (
  `NIM` varchar(10) NOT NULL,
  `ID_PROGRAM` varchar(10) NOT NULL,
  `STATUS` varchar(20) NOT NULL,
  `ID_KONTRAKMBKM` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tmahasiswa`
--

CREATE TABLE `tmahasiswa` (
  `NIP` varchar(20) NOT NULL,
  `NIM` varchar(10) NOT NULL,
  `NAMA_MAHASISWA` varchar(50) NOT NULL,
  `PRODI` varchar(50) NOT NULL,
  `EMAIL_MAHASISWA` varchar(50) NOT NULL,
  `SEMESTER_MAHASISWA` int(11) NOT NULL,
  `SKS_AKUMULATIF` int(11) DEFAULT 0,
  `IPK_MAHASISWA` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tmahasiswa`
--

INSERT INTO `tmahasiswa` (`NIP`, `NIM`, `NAMA_MAHASISWA`, `PRODI`, `EMAIL_MAHASISWA`, `SEMESTER_MAHASISWA`, `SKS_AKUMULATIF`, `IPK_MAHASISWA`) VALUES
('22222222', '2102585', 'Apri Anggara Yudha', 'Ilmu Komputer', 'aprianggarayudha585@upi.edu', 5, 0, 4),
('33333333', '2102843', 'Najma Qalbi Dwiharani', 'Ilmu Komputer', 'najmadwiharani@upi.edu', 6, 0, 4),
('11111111', '2108061', 'Achmad Fauzan', 'Ilmu Komputer', 'achmdfzan@upi.edu', 5, 0, 3.96);

-- --------------------------------------------------------

--
-- Table structure for table `tmatkul`
--

CREATE TABLE `tmatkul` (
  `KODE_MK` varchar(10) NOT NULL,
  `NAMA_MK` varchar(50) NOT NULL,
  `SKS_MK` int(11) NOT NULL,
  `SEMESTER_MK` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tmatkul`
--

INSERT INTO `tmatkul` (`KODE_MK`, `NAMA_MK`, `SKS_MK`, `SEMESTER_MK`) VALUES
('IK310', 'Kriptografi', 3, 5),
('IK320', 'Kecerdasan Buatan', 5, 3),
('IK330', 'Algoritma dan Pemrograman 5', 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `tpembimbing`
--

CREATE TABLE `tpembimbing` (
  `NIP` varchar(20) NOT NULL,
  `NAMA_PEMBIMBING` varchar(50) NOT NULL,
  `EMAIL_PEMBIMBING` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tpembimbing`
--

INSERT INTO `tpembimbing` (`NIP`, `NAMA_PEMBIMBING`, `EMAIL_PEMBIMBING`) VALUES
('11111111', 'Dr. Rani Megasari, M.T.', 'megasari.upi.edu'),
('22222222', 'Rosa Ariani Sukamto,  M.T.', 'rosa.ariani@upi.edu'),
('33333333', 'Dr. Asep Wahyudin, M.T.', 'away@upi.edu');

-- --------------------------------------------------------

--
-- Table structure for table `tprogrammbkm`
--

CREATE TABLE `tprogrammbkm` (
  `ID_PROGRAM` varchar(10) NOT NULL,
  `NAMA_PROGRAM` varchar(50) NOT NULL,
  `JENIS_PROGRAM` varchar(50) NOT NULL,
  `DURASI` int(11) NOT NULL,
  `SKS_PROGRAM` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tprogrammbkm`
--

INSERT INTO `tprogrammbkm` (`ID_PROGRAM`, `NAMA_PROGRAM`, `JENIS_PROGRAM`, `DURASI`, `SKS_PROGRAM`) VALUES
('11111', 'Magang di Google', 'Magang', 6, 20),
('22222', 'KKN di desa Konoha', 'KKN', 6, 20),
('33333', 'Pertukaran Mahasiswa ke Harvard', 'Pertukaran Mahasiswa', 6, 20);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kontrakmatkul`
--
ALTER TABLE `kontrakmatkul`
  ADD PRIMARY KEY (`ID_KONTRAKMATKUL`),
  ADD KEY `FK_KONTRAKM_KONTRAKMA_TMATKUL` (`KODE_MK`),
  ADD KEY `FK_KONTRAKM_KONTRAKMA_TMAHASIS` (`NIM`);

--
-- Indexes for table `kontrakmbkm`
--
ALTER TABLE `kontrakmbkm`
  ADD PRIMARY KEY (`ID_KONTRAKMBKM`),
  ADD KEY `FK_KONTRAKM_KONTRAKMB_TMAHASIS` (`NIM`),
  ADD KEY `FK_KONTRAKM_KONTRAKMB_TPROGRAM` (`ID_PROGRAM`);

--
-- Indexes for table `tmahasiswa`
--
ALTER TABLE `tmahasiswa`
  ADD PRIMARY KEY (`NIM`),
  ADD KEY `FK_TMAHASIS_MEMBIMBIN_TPEMBIMB` (`NIP`);

--
-- Indexes for table `tmatkul`
--
ALTER TABLE `tmatkul`
  ADD PRIMARY KEY (`KODE_MK`);

--
-- Indexes for table `tpembimbing`
--
ALTER TABLE `tpembimbing`
  ADD PRIMARY KEY (`NIP`);

--
-- Indexes for table `tprogrammbkm`
--
ALTER TABLE `tprogrammbkm`
  ADD PRIMARY KEY (`ID_PROGRAM`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kontrakmatkul`
--
ALTER TABLE `kontrakmatkul`
  ADD CONSTRAINT `FK_KONTRAKM_KONTRAKMA_TMAHASIS` FOREIGN KEY (`NIM`) REFERENCES `tmahasiswa` (`NIM`),
  ADD CONSTRAINT `FK_KONTRAKM_KONTRAKMA_TMATKUL` FOREIGN KEY (`KODE_MK`) REFERENCES `tmatkul` (`KODE_MK`);

--
-- Constraints for table `kontrakmbkm`
--
ALTER TABLE `kontrakmbkm`
  ADD CONSTRAINT `FK_KONTRAKM_KONTRAKMB_TMAHASIS` FOREIGN KEY (`NIM`) REFERENCES `tmahasiswa` (`NIM`),
  ADD CONSTRAINT `FK_KONTRAKM_KONTRAKMB_TPROGRAM` FOREIGN KEY (`ID_PROGRAM`) REFERENCES `tprogrammbkm` (`ID_PROGRAM`);

--
-- Constraints for table `tmahasiswa`
--
ALTER TABLE `tmahasiswa`
  ADD CONSTRAINT `FK_TMAHASIS_MEMBIMBIN_TPEMBIMB` FOREIGN KEY (`NIP`) REFERENCES `tpembimbing` (`NIP`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
