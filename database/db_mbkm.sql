-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 02, 2022 at 05:06 AM
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
  `kode_mk` varchar(10) NOT NULL,
  `nim` varchar(10) NOT NULL,
  `tipe` varchar(10) DEFAULT NULL,
  `id_kontrakmatkul` int(11) NOT NULL,
  `sem_kontrak` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kontrakmatkul`
--

INSERT INTO `kontrakmatkul` (`kode_mk`, `nim`, `tipe`, `id_kontrakmatkul`, `sem_kontrak`) VALUES
('IK330', '2100901', 'konversi', 16, 6);

--
-- Triggers `kontrakmatkul`
--
DELIMITER $$
CREATE TRIGGER `after_konversi_insert` BEFORE INSERT ON `kontrakmatkul` FOR EACH ROW BEGIN

	DECLARE sks_sisa int(11);
    DECLARE sks int(11);
    
    SET sks_sisa = (SELECT tma.sks_sisa_konversi FROM tmahasiswa AS tma WHERE tma.nim = new.nim);
    SET sks = (SELECT tm.sks_mk FROM tmatkul AS tm WHERE new.kode_mk=tm.kode_mk);
    
    IF new.tipe LIKE 'konversi' AND (sks_sisa - sks) >= 0 THEN
        UPDATE tmahasiswa AS tm SET sks_sisa_konversi=sks_sisa_konversi-sks WHERE new.nim=tm.nim;
    END IF;
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kontrakmbkm`
--

CREATE TABLE `kontrakmbkm` (
  `nim` varchar(10) NOT NULL,
  `id_program` varchar(10) NOT NULL,
  `status` varchar(20) NOT NULL,
  `id_kontrakmbkm` int(11) NOT NULL,
  `nip_pembimbingmbkm` varchar(20) DEFAULT NULL,
  `semester_kontrak` int(11) NOT NULL,
  `waktu_mulai` date DEFAULT NULL,
  `waktu_selesai` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kontrakmbkm`
--

INSERT INTO `kontrakmbkm` (`nim`, `id_program`, `status`, `id_kontrakmbkm`, `nip_pembimbingmbkm`, `semester_kontrak`, `waktu_mulai`, `waktu_selesai`) VALUES
('2100901', '33333', 'selesai', 9, '11111111', 6, '2022-06-02', '2022-06-02'),
('2108061', '22222', 'sedang mendaftar', 10, NULL, 5, NULL, NULL);

--
-- Triggers `kontrakmbkm`
--
DELIMITER $$
CREATE TRIGGER `after_insert_kontrakbmkm` AFTER INSERT ON `kontrakmbkm` FOR EACH ROW UPDATE tmahasiswa
SET status_mahasiswa = 'sudah berpartisipasi'
WHERE nim = NEW.nim
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_sedangmengikuti_update` BEFORE UPDATE ON `kontrakmbkm` FOR EACH ROW BEGIN
    IF new.status LIKE 'sedang mengikuti' THEN
    	SET new.waktu_mulai=CURRENT_DATE;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_selesai_update` BEFORE UPDATE ON `kontrakmbkm` FOR EACH ROW BEGIN

    DECLARE sks int(11);
    DECLARE lingkup varchar(10);
    SET sks = (SELECT tp.sks_program FROM tprogrammbkm AS tp WHERE new.id_program=tp.id_program);
    SET lingkup = (SELECT tp.lingkup_program FROM tprogrammbkm AS tp WHERE new.id_program=tp.id_program);
    
    IF new.status LIKE 'selesai' THEN
    	SET new.waktu_selesai=CURRENT_DATE;
        UPDATE tmahasiswa AS tm SET sks_sisa_konversi=sks_sisa_konversi+sks WHERE new.nim=tm.nim;

        IF lingkup LIKE 'luar' THEN
            UPDATE tmahasiswa AS tm SET sks_luar_univ=sks_luar_univ-sks WHERE new.nim=tm.nim;
        ELSEIF lingkup LIKE 'dalam' THEN
            UPDATE tmahasiswa AS tm SET sks_dalam_univ=sks_dalam_univ-sks WHERE new.nim=tm.nim;
        END IF;

        UPDATE tmahasiswa AS tm SET sks_akumulatif=sks_akumulatif+sks WHERE new.nim=tm.nim;
    END IF;
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tmahasiswa`
--

CREATE TABLE `tmahasiswa` (
  `nip` varchar(20) NOT NULL,
  `nim` varchar(10) NOT NULL,
  `nama_mahasiswa` varchar(50) NOT NULL,
  `prodi` varchar(50) NOT NULL,
  `email_mahasiswa` varchar(50) NOT NULL,
  `semester_mahasiswa` int(11) NOT NULL,
  `sks_akumulatif` int(11) DEFAULT 0,
  `sks_sisa_konversi` int(11) DEFAULT 0,
  `sks_dalam_univ` int(11) DEFAULT 20,
  `sks_luar_univ` int(11) DEFAULT 40,
  `ipk_mahasiswa` float NOT NULL,
  `status_mahasiswa` varchar(25) DEFAULT 'belum berpartisipasi'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tmahasiswa`
--

INSERT INTO `tmahasiswa` (`nip`, `nim`, `nama_mahasiswa`, `prodi`, `email_mahasiswa`, `semester_mahasiswa`, `sks_akumulatif`, `sks_sisa_konversi`, `sks_dalam_univ`, `sks_luar_univ`, `ipk_mahasiswa`, `status_mahasiswa`) VALUES
('11111111', '2000199', 'NELLY JOY CHRISTI SIMANJUNTAK', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.8, 'belum berpartisipasi'),
('11111111', '2003662', 'RIGEL DEVANO HIDAYATULLAH', 'Ilkom', 'dummy@gmail.com', 6, 0, 0, 20, 40, 3.9, 'belum berpartisipasi'),
('11111111', '2100137', 'MUHAMAD NUR YASIN AMADUDIN', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.1, 'belum berpartisipasi'),
('11111111', '2100187', 'MUHAMMAD HILMY RASYAD SOFYAN', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.87, 'belum berpartisipasi'),
('11111111', '2100192', 'MUHAMMAD RAYHAN NUR', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.87, 'belum berpartisipasi'),
('11111111', '2100195', 'DAVIN FAUSTA PUTRA SANJAYA', 'Ilkom', 'dummy@gmail.com', 6, 0, 0, 20, 40, 3.87, 'belum berpartisipasi'),
('11111111', '2100846', 'RAFLY PUTRA SANTOSO', 'Ilkom', 'dummy@gmail.com', 6, 0, 0, 20, 40, 3.87, 'belum berpartisipasi'),
('11111111', '2100901', 'AZZAHRA SITI HADJAR', 'Ilkom', 'dummy@gmail.com', 6, 20, 17, 0, 40, 3.87, 'sudah berpartisipasi'),
('11111111', '2100991', 'KHANA YUSDIANA', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.87, 'belum berpartisipasi'),
('11111111', '2101103', 'RIFQI FAJAR INDRAYADI', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 4, 'belum berpartisipasi'),
('11111111', '2101114', 'ANANDITA KUSUMAH MULYADI', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 4, 'belum berpartisipasi'),
('11111111', '2101147', 'AMIDA ZULFA LAILA', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 4, 'belum berpartisipasi'),
('11111111', '2102159', 'VIRZA RAIHAN KURNIAWAN', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 4, 'belum berpartisipasi'),
('11111111', '2102204', 'MOHAMAD ASYQARI ANUGRAH', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 4, 'belum berpartisipasi'),
('11111111', '2102268', 'AUDRY LEONARDO LOO', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 4, 'belum berpartisipasi'),
('11111111', '2102292', 'HAROLD VIDIAN EXAUDI SIMARMATA', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 4, 'belum berpartisipasi'),
('22222222', '2102313', 'MUHAMMAD KAMAL ROBBANI', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2102421', 'KANIA DINDA FASYA', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2102545', 'ZAHRA FITRIA MAHARANI', 'Ilkom', 'dummy@gmail.com', 6, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2102585', 'APRI ANGGARA YUDHA', 'Ilmu Komputer', 'aprianggarayudha585@upi.edu', 5, 0, 0, 20, 40, 4, 'belum berpartisipasi'),
('22222222', '2102665', 'M. CAHYANA BINTANG FAJAR', 'Ilkom', 'dummy@gmail.com', 6, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2102671', 'ANDERFA JALU KAWANI', 'Ilkom', 'dummy@gmail.com', 6, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('33333333', '2102843', 'NAJMA QALBI DWIHARANI', 'Ilmu Komputer', 'najmadwiharani@upi.edu', 6, 0, 0, 20, 40, 4, 'belum berpartisipasi'),
('22222222', '2103207', 'YASMIN FATHANAH ZAKIYYAH', 'Ilkom', 'dummy@gmail.com', 6, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2103507', 'INDAH RESTI FAUZI', 'Ilkom', 'dummy@gmail.com', 6, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2103703', 'FAUZIYYAH ZAYYAN NUR', 'Ilkom', 'dummy@gmail.com', 6, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2103727', 'CANTIKA PUTRI ARBILIANSYAH', 'Ilkom', 'dummy@gmail.com', 6, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2105673', 'ALGHANIYU NAUFAL HAMID', 'Ilkom', 'dummy@gmail.com', 6, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2105745', 'RIDWAN ALBANA', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2105879', 'FARHAN MUZHAFFAR TIRAS PUTRA', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2105885', 'QURROTU\' AINII', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('22222222', '2105927', 'FEBRY SYAMAN HASAN', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('33333333', '2105997', 'MUHAMMAD FAKHRI FADHLURRAHMAN', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.6, 'belum berpartisipasi'),
('33333333', '2106000', 'SABILA ROSAD', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.5, 'belum berpartisipasi'),
('11111111', '2108061', 'ACHMAD FAUZAN', 'Ilmu Komputer', 'achmdfzan@upi.edu', 5, 0, 0, 20, 40, 3.96, 'sudah berpartisipasi'),
('33333333', '2108067', 'VILLENEUVE ANDHIRA SUWANDHI', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.5, 'belum berpartisipasi'),
('33333333', '2108077', 'HESTINA DWI HARTIWI', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.5, 'belum berpartisipasi'),
('33333333', '2108804', 'LAELATUSYA\'DIYAH', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.5, 'belum berpartisipasi'),
('33333333', '2108927', 'MUHAMMAD FAHRU ROZI', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.5, 'belum berpartisipasi'),
('33333333', '2108938', 'RAFI ARSALAN MI\'RAJ', 'Ilkom', 'dummy@gmail.com', 5, 0, 0, 20, 40, 3.5, 'belum berpartisipasi'),
('11111111', '2201234', 'Mahasiswa Baru', 'Ilkom', 'dummy@gmail.com', 4, 0, 0, 20, 40, 4, 'belum berpartisipasi');

-- --------------------------------------------------------

--
-- Table structure for table `tmatkul`
--

CREATE TABLE `tmatkul` (
  `kode_mk` varchar(10) NOT NULL,
  `nama_mk` varchar(50) NOT NULL,
  `sks_mk` int(11) NOT NULL,
  `semester_mk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tmatkul`
--

INSERT INTO `tmatkul` (`kode_mk`, `nama_mk`, `sks_mk`, `semester_mk`) VALUES
('IK310', 'Kriptografi', 3, 5),
('IK320', 'Kecerdasan Buatan', 5, 3),
('IK330', 'Algoritma dan Pemrograman 5', 3, 5);

-- --------------------------------------------------------

--
-- Table structure for table `tpembimbing`
--

CREATE TABLE `tpembimbing` (
  `nip` varchar(20) NOT NULL,
  `nama_pembimbing` varchar(50) NOT NULL,
  `email_pembimbing` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tpembimbing`
--

INSERT INTO `tpembimbing` (`nip`, `nama_pembimbing`, `email_pembimbing`) VALUES
('11111111', 'Dr. Rani Megasari, M.T.', 'megasari.upi.edu'),
('22222222', 'Rosa Ariani Sukamto,  M.T.', 'rosa.ariani@upi.edu'),
('33333333', 'Dr. Asep Wahyudin, M.T.', 'away@upi.edu');

-- --------------------------------------------------------

--
-- Table structure for table `tprogrammbkm`
--

CREATE TABLE `tprogrammbkm` (
  `id_program` varchar(10) NOT NULL,
  `nama_program` varchar(50) NOT NULL,
  `jenis_program` varchar(50) NOT NULL,
  `durasi` int(11) NOT NULL,
  `sks_program` int(11) NOT NULL,
  `lingkup_program` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tprogrammbkm`
--

INSERT INTO `tprogrammbkm` (`id_program`, `nama_program`, `jenis_program`, `durasi`, `sks_program`, `lingkup_program`) VALUES
('11111', 'Magang di Google', 'Magang', 6, 20, 'luar'),
('22222', 'KKN di desa Konoha', 'KKN', 6, 20, 'luar'),
('33333', 'Pertukaran Mahasiswa ke Harvard', 'Pertukaran Mahasiswa', 6, 20, 'dalam');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kontrakmatkul`
--
ALTER TABLE `kontrakmatkul`
  ADD PRIMARY KEY (`id_kontrakmatkul`),
  ADD KEY `FK_KONTRAKM_KONTRAKMA_TMATKUL` (`kode_mk`),
  ADD KEY `FK_KONTRAKM_KONTRAKMA_TMAHASIS` (`nim`);

--
-- Indexes for table `kontrakmbkm`
--
ALTER TABLE `kontrakmbkm`
  ADD PRIMARY KEY (`id_kontrakmbkm`),
  ADD KEY `FK_KONTRAKM_KONTRAKMB_TMAHASIS` (`nim`),
  ADD KEY `FK_KONTRAKM_KONTRAKMB_TPROGRAM` (`id_program`),
  ADD KEY `NIP_Pembimbing_MBKM` (`nip_pembimbingmbkm`);

--
-- Indexes for table `tmahasiswa`
--
ALTER TABLE `tmahasiswa`
  ADD PRIMARY KEY (`nim`),
  ADD KEY `FK_TMAHASIS_MEMBIMBIN_TPEMBIMB` (`nip`);

--
-- Indexes for table `tmatkul`
--
ALTER TABLE `tmatkul`
  ADD PRIMARY KEY (`kode_mk`);

--
-- Indexes for table `tpembimbing`
--
ALTER TABLE `tpembimbing`
  ADD PRIMARY KEY (`nip`);

--
-- Indexes for table `tprogrammbkm`
--
ALTER TABLE `tprogrammbkm`
  ADD PRIMARY KEY (`id_program`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kontrakmatkul`
--
ALTER TABLE `kontrakmatkul`
  MODIFY `id_kontrakmatkul` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `kontrakmbkm`
--
ALTER TABLE `kontrakmbkm`
  MODIFY `id_kontrakmbkm` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  ADD CONSTRAINT `FK_KONTRAKM_KONTRAKMB_TMAHASIS` FOREIGN KEY (`nim`) REFERENCES `tmahasiswa` (`NIM`),
  ADD CONSTRAINT `FK_KONTRAKM_KONTRAKMB_TPROGRAM` FOREIGN KEY (`id_program`) REFERENCES `tprogrammbkm` (`ID_PROGRAM`),
  ADD CONSTRAINT `kontrakmbkm_ibfk_1` FOREIGN KEY (`nip_pembimbingmbkm`) REFERENCES `tpembimbing` (`NIP`);

--
-- Constraints for table `tmahasiswa`
--
ALTER TABLE `tmahasiswa`
  ADD CONSTRAINT `FK_TMAHASIS_MEMBIMBIN_TPEMBIMB` FOREIGN KEY (`NIP`) REFERENCES `tpembimbing` (`NIP`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
