-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2022 at 04:20 AM
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
-- Database: `db_alumni`
--

-- --------------------------------------------------------

--
-- Table structure for table `alumni`
--

CREATE TABLE `alumni` (
  `id_alumni` varchar(10) NOT NULL,
  `nama` varchar(20) NOT NULL,
  `prodi` varchar(20) NOT NULL,
  `tgl_lulus` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `alumni`
--

INSERT INTO `alumni` (`id_alumni`, `nama`, `prodi`, `tgl_lulus`) VALUES
('A1000001', 'John', 'Ilmu Komputer', '2014-04-15'),
('A1000002', 'Asep', 'Teknik Elektro', '2013-07-01'),
('A1000003', 'Harris', 'Teknik Arsitektur', '2012-12-20'),
('A1000004', 'Fakhri', 'Teknik Elektro', '2015-08-23'),
('A1000005', 'Ayu', 'Teknik Arsitektur', '2015-12-20'),
('A1000006', 'Yuli', 'Ilmu Komputer', '2014-04-15'),
('A1000007', 'Drianto', 'Teknik Fisika', '2012-07-23'),
('A1000008', 'Shepard', 'Teknik Fisika', '2012-07-23'),
('A1000009', 'Toni', 'Seni Musik', '2016-04-14'),
('A1000010', 'Bill', 'Seni Rupa', '2016-04-14'),
('A1000011', 'Sony', 'Ilmu Komputer', '2015-12-20'),
('A1000012', 'Bambang', 'Ilmu Komputer', '2015-12-20');

-- --------------------------------------------------------

--
-- Table structure for table `pekerjaan`
--

CREATE TABLE `pekerjaan` (
  `id_pekerjaan` varchar(10) NOT NULL,
  `jns_pekerjaan` varchar(20) NOT NULL,
  `kesesuaian` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pekerjaan`
--

INSERT INTO `pekerjaan` (`id_pekerjaan`, `jns_pekerjaan`, `kesesuaian`) VALUES
('P001', 'Programmer', 'iya'),
('P002', 'Wirausaha', 'tidak'),
('P003', 'Aktris', 'tidak'),
('P004', 'Dosen', 'iya'),
('P005', 'Guru', 'iya'),
('P006', 'Model', 'tidak'),
('P007', 'System Analys', 'iya');

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_organisasi`
--

CREATE TABLE `riwayat_organisasi` (
  `id_alumni` varchar(30) NOT NULL,
  `organisasi` varchar(30) NOT NULL,
  `jabatan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `riwayat_organisasi`
--

INSERT INTO `riwayat_organisasi` (`id_alumni`, `organisasi`, `jabatan`) VALUES
('A1000001', 'KEC', 'Anggota'),
('A1000006', 'BEM', 'Sekretaris'),
('A1000010', 'OSIS', 'Ketua'),
('A1000012', 'POSS', 'Staff');

-- --------------------------------------------------------

--
-- Table structure for table `riwayat_pekerjaan`
--

CREATE TABLE `riwayat_pekerjaan` (
  `id_pekerjaan` varchar(10) NOT NULL,
  `id_alumni` varchar(10) NOT NULL,
  `alamat_institusi` varchar(30) NOT NULL,
  `tgl_masuk` date NOT NULL,
  `tgl_keluar` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `riwayat_pekerjaan`
--

INSERT INTO `riwayat_pekerjaan` (`id_pekerjaan`, `id_alumni`, `alamat_institusi`, `tgl_masuk`, `tgl_keluar`) VALUES
('P001', 'A1000001', 'Bandung', '2014-04-17', '2015-08-23'),
('P004', 'A1000002', 'Ambon', '2013-09-04', '2016-04-14'),
('P002', 'A1000003', 'Jakarta', '2013-01-05', '2015-10-20'),
('P007', 'A1000004', 'Subang', '2015-10-22', '2018-01-05'),
('P003', 'A1000005', 'Jakarta', '2015-12-08', '2019-02-04'),
('P001', 'A1000006', 'Bandung', '2014-05-06', '2015-08-23'),
('P002', 'A1000007', 'Yogyakarta', '2012-07-25', '2017-08-23'),
('P005', 'A1000008', 'Papua', '2012-12-20', '2019-10-20'),
('P001', 'A1000009', 'Surabaya', '2016-05-10', '2018-07-05'),
('P007', 'A1000010', 'Bandung', '2016-05-02', '2020-02-04'),
('P002', 'A1000003', 'Jayapura', '2015-11-01', '0000-00-00'),
('P006', 'A1000001', 'Bekasi', '2017-01-01', '2019-01-01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alumni`
--
ALTER TABLE `alumni`
  ADD PRIMARY KEY (`id_alumni`);

--
-- Indexes for table `pekerjaan`
--
ALTER TABLE `pekerjaan`
  ADD PRIMARY KEY (`id_pekerjaan`);

--
-- Indexes for table `riwayat_organisasi`
--
ALTER TABLE `riwayat_organisasi`
  ADD PRIMARY KEY (`id_alumni`);

--
-- Indexes for table `riwayat_pekerjaan`
--
ALTER TABLE `riwayat_pekerjaan`
  ADD KEY `id_pekerjaan` (`id_pekerjaan`),
  ADD KEY `id_alumni` (`id_alumni`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `riwayat_organisasi`
--
ALTER TABLE `riwayat_organisasi`
  ADD CONSTRAINT `riwayat_organisasi_ibfk_1` FOREIGN KEY (`id_alumni`) REFERENCES `alumni` (`id_alumni`);

--
-- Constraints for table `riwayat_pekerjaan`
--
ALTER TABLE `riwayat_pekerjaan`
  ADD CONSTRAINT `riwayat_pekerjaan_ibfk_1` FOREIGN KEY (`id_pekerjaan`) REFERENCES `pekerjaan` (`id_pekerjaan`),
  ADD CONSTRAINT `riwayat_pekerjaan_ibfk_2` FOREIGN KEY (`id_alumni`) REFERENCES `alumni` (`id_alumni`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
