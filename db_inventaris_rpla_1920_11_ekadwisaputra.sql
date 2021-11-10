-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 08, 2021 at 11:22 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_inventaris_rpla_1920_11_ekadwisaputra`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_barangmasuk` (`kode_barang` CHAR(8), `sisupplier` CHAR(8), `jumlah_barang_masuk` INT)  BEGIN

    DECLARE jml_lama INT DEFAULT 0;
    DECLARE total_lama INT DEFAULT 0;
    DECLARE total_baru INT DEFAULT 0;
    
    INSERT INTO barang_masuk VALUES(kode_barang,NOW(),jumlah_barang_masuk,sisupplier); 
    SELECT jml_masuk INTO jml_lama FROM stok WHERE id_barang = kode_barang;
    SELECT total_barang INTO total_lama FROM stok WHERE id_barang = kode_barang;
    UPDATE stok SET jml_masuk =jml_lama+jumlah_barang_masuk WHERE id_barang = kode_barang;
    UPDATE stok SET total_barang = jml_masuk-jml_keluar WHERE id_barang = kode_barang;
    SELECT total_barang INTO total_baru FROM stok WHERE id_barang = kode_barang;
    UPDATE barang SET jumlah_barang = total_baru WHERE id_barang = kode_barang;    
  
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `newkodebarang` () RETURNS CHAR(8) CHARSET utf8mb4 BEGIN
    DECLARE kode_lama CHAR(8) DEFAULT 'BRG00001';
    DECLARE ambil_angka INT DEFAULT 00001;
    DECLARE kode_baru CHAR(8) DEFAULT 'BRG00001';

    SELECT MAX(id_barang) INTO kode_lama FROM barang;

    SET ambil_angka = SUBSTR(kode_lama,4,5);
    SET kode_baru = CONCAT('BRG',LPAD(ambil_angka + 1,5, 0));
    
RETURN kode_baru;   
 
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `newkodesupplier` () RETURNS VARCHAR(8) CHARSET utf8mb4 BEGIN
    DECLARE kode_lama CHAR(6) DEFAULT 'SPR001';
    DECLARE ambil_angka INT DEFAULT 001;
    DECLARE kode_baru CHAR(6) DEFAULT 'SPR001';

    SELECT MAX(id_supplier) INTO kode_lama FROM supplier;

    SET ambil_angka = SUBSTR(kode_lama,4,3);
    SET kode_baru = CONCAT('SPR',LPAD(ambil_angka + 1,3, 0));
    
RETURN kode_baru;   
 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` char(8) NOT NULL,
  `nama_barang` varchar(225) NOT NULL,
  `spesifikasi` text NOT NULL,
  `lokasi` char(4) NOT NULL,
  `kondisi` varchar(20) NOT NULL,
  `jumlah_barang` int(4) NOT NULL,
  `sumber_dana` char(4) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`id_barang`, `nama_barang`, `spesifikasi`, `lokasi`, `kondisi`, `jumlah_barang`, `sumber_dana`, `image`) VALUES
('BRG10001', 'Kursi siswa', 'Bantalan', 'R001', 'Baik', 40, 'S001', 'kursi-siswa'),
('BRG10002', 'Kursi lipat siswa', 'Kursi lipat\r\nmerek Informa\r\nBantalan', 'R002', 'Baik', 36, 'S001', 'kursi-lipat'),
('BRG20001', 'Laptop Acer Aspire E1-471', 'Core i3 Ram \r\n4GB\r\nHDD 500GB', 'R002', 'Baik', 30, 'S002', 'laptop-acer'),
('BRG20002', 'Laptop Lenovo E550', 'Laptop Lenovo E550\r\nintel Core i7\r\nRam 8GB\r\nHDD 1TB', 'R002', 'Baik', 23, 'S003', NULL),
('BRG20003', 'PC Rakitan i7', 'Intel Core i7\r\nRam 16GB\r\nSSD 512GB', 'R001', 'Baik', 12, 'S004', NULL),
('BRG20004', 'Camera DSLR D60', 'Spek high end ', 'R005', 'Baik', 16, 'S003', NULL),
('BRG30001', 'Lightning set', 'Spek High end', 'R005', 'Baik', 2, 'S005', NULL),
('BRG30002', 'Tripod Kamera', 'Takara tripod', 'R005', 'Baik', 4, 'S002', NULL),
('BRG30003', 'Earphone', 'Earphone ROG Gen 3', 'R001', 'Baik', 5, 'S001', '1636195332_9f7d51fb97129352f1a4.jpg'),
('BRG30004', 'Handphone ', 'Samsung XX12 dengan teknologi terbaru', 'R001', 'Baik', 52, 'S001', '1636341974_17a7503c41e5412e4b3f.png');

-- --------------------------------------------------------

--
-- Table structure for table `barang_keluar`
--

CREATE TABLE `barang_keluar` (
  `id_barang` char(8) NOT NULL,
  `tgl_keluar` date NOT NULL,
  `jml_keluar` int(11) NOT NULL,
  `supplier` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang_keluar`
--

INSERT INTO `barang_keluar` (`id_barang`, `tgl_keluar`, `jml_keluar`, `supplier`) VALUES
('BRG10001', '2020-11-03', 16, 'SPR001'),
('BRG20001', '2017-11-06', 3, 'SPR005');

-- --------------------------------------------------------

--
-- Table structure for table `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_barang` char(8) NOT NULL,
  `tgl_masuk` date NOT NULL,
  `jml_masuk` int(11) NOT NULL,
  `supplier` char(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_barang`, `tgl_masuk`, `jml_masuk`, `supplier`) VALUES
('BRG10001', '2007-08-03', 36, 'SPR001'),
('BRG10002', '2007-08-01', 36, 'SPR002'),
('BRG20001', '2013-07-09', 30, 'SPR004'),
('BRG20002', '2014-03-08', 23, 'SPR003'),
('BRG20003', '2020-11-10', 12, 'SPR004'),
('BRG20004', '2014-04-13', 16, 'SPR005'),
('BRG30001', '2018-04-06', 2, 'SPR005'),
('BRG30002', '2018-04-06', 2, 'SPR005'),
('BRG10001', '2021-11-03', 4, 'SPR001');

-- --------------------------------------------------------

--
-- Stand-in structure for view `jumlah_barang_dipinjam_tiap_ruang`
-- (See below for the actual view)
--
CREATE TABLE `jumlah_barang_dipinjam_tiap_ruang` (
`id_lokasi` char(4)
,`nama_lokasi` varchar(225)
,`id_barang` char(8)
,`Lebih dari 1` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `jumlah_ruang`
-- (See below for the actual view)
--
CREATE TABLE `jumlah_ruang` (
`Total Ruang` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `jumlah_ruang_tiap_penanggung_jawab`
-- (See below for the actual view)
--
CREATE TABLE `jumlah_ruang_tiap_penanggung_jawab` (
`penanggung_jawab` varchar(225)
,`Total Lokasi` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `level_user`
--

CREATE TABLE `level_user` (
  `id_level` char(3) NOT NULL,
  `nama` varchar(225) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `level_user`
--

INSERT INTO `level_user` (`id_level`, `nama`, `keterangan`) VALUES
('U01', 'Administrator', ''),
('U02', 'Manajemen', ''),
('U03', 'Peminjam', '');

-- --------------------------------------------------------

--
-- Table structure for table `lokasi`
--

CREATE TABLE `lokasi` (
  `id_lokasi` char(4) NOT NULL,
  `nama_lokasi` varchar(225) NOT NULL,
  `penanggung_jawab` varchar(225) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lokasi`
--

INSERT INTO `lokasi` (`id_lokasi`, `nama_lokasi`, `penanggung_jawab`, `keterangan`) VALUES
('R001', 'Lab RPL 1', 'Satria Ade Putra ', 'Lantai 3'),
('R002', 'Lab RPL 2', 'Satria Ade Putra', 'Lantai 3'),
('R003', 'Lab TKJ 1', 'Supriyadi', 'Lantai 2 Gedung D'),
('R004', 'Lab TKJ 2', 'Supriyadi', 'Lantai 2 Gedung D'),
('R005', 'Lab Multimedia', 'Bayu Setiawan', 'Gedung Multimedia');

-- --------------------------------------------------------

--
-- Table structure for table `pinjam_barang`
--

CREATE TABLE `pinjam_barang` (
  `id_pinjam` int(11) NOT NULL,
  `peminjam` char(8) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `barang_pinjam` char(8) NOT NULL,
  `jml_pinjam` int(11) NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kondisi` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pinjam_barang`
--

INSERT INTO `pinjam_barang` (`id_pinjam`, `peminjam`, `tgl_pinjam`, `barang_pinjam`, `jml_pinjam`, `tgl_kembali`, `kondisi`) VALUES
(1, 'USR20001', '2021-06-09', 'BRG20002', 1, '2021-06-23', 'Baik'),
(2, 'USR20002', '2021-06-09', 'BRG20002', 1, '2021-06-09', 'Baik'),
(3, 'USR20004', '2021-08-05', 'BRG20004', 3, '2021-08-21', 'Baik'),
(4, 'USR20004', '2021-08-05', 'BRG30002', 3, '2021-08-05', 'Baik');

-- --------------------------------------------------------

--
-- Table structure for table `stok`
--

CREATE TABLE `stok` (
  `id_barang` char(8) NOT NULL,
  `jml_masuk` int(11) NOT NULL,
  `jml_keluar` int(11) NOT NULL,
  `total_barang` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stok`
--

INSERT INTO `stok` (`id_barang`, `jml_masuk`, `jml_keluar`, `total_barang`) VALUES
('BRG10001', 40, 0, 40),
('BRG10002', 36, 16, 20),
('BRG20001', 30, 3, 29),
('BRG20002', 23, 0, 23),
('BRG20003', 12, 0, 12),
('BRG20004', 16, 0, 16),
('BRG30001', 2, 0, 2),
('BRG30002', 4, 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `sumber_dana`
--

CREATE TABLE `sumber_dana` (
  `id_sumber` char(4) NOT NULL,
  `nama_sumber` varchar(225) NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sumber_dana`
--

INSERT INTO `sumber_dana` (`id_sumber`, `nama_sumber`, `keterangan`) VALUES
('S001', 'Komite 07/09', 'Bantuan komite 2007/2009'),
('S002', 'Komite 13', 'Bantuan Komite 2013'),
('S003', 'Sed t-vet', 'Bantuan kerjasama indonesia jerman'),
('S004', 'BOPD 2020', 'Bantuan Provinsi Jawa Barat 2020'),
('S005', 'BOSDA 2018', 'Bantuan Operasional Sekaolah Daerah Jawa Barat 2018');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` varchar(8) NOT NULL,
  `nama_supplier` varchar(225) NOT NULL,
  `alamat_supplier` text NOT NULL,
  `telp_supplier` varchar(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `nama_supplier`, `alamat_supplier`, `telp_supplier`) VALUES
('SPR001', 'INFORMA - MALL METROPOLITAN BEKASI', 'Mal Metropolitan, Jl. KH. Noer Ali No.1, RT.008/RW.002, Pekayon Jaya, Kec. Bekasi Sel., Kota Bks, Jawa Barat 17148', '0812-9604-6051'),
('SPR002', 'Mitrakantor.com', 'Jl. I Gusti Ngurah Rai No.20, RT.1/RW.10, Klender, Kec. Duren Sawit, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13470', '(021) 22862086'),
('SPR003', 'Bhinneka.Com', 'Jl. Gn. Sahari No.73C, RT.9/RW.7, Gn. Sahari Sel., Kec. Kemayoran, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10610', '(021) 29292828'),
('SPR004', 'World Computer', 'Harco Mangga Dua Plaza B3/1, Jalan Arteri Mangga Dua Raya, RT.17/RW.11, Mangga Dua Sel., Kecamatan Sawah Besar, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10730', '(021) 6125266'),
('SPR005', 'Anekafoto Metro Atom', 'Metro Atom Plaza Jalan Samanhudi Blok AKS No. 19, RT.20/RW.3, Ps. Baru, Kecamatan Sawah Besar, Kota Jakarta Pusat, Daerah Khusus Ibukota Jakarta 10710', '(021) 3455544');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` char(8) NOT NULL,
  `nama` varchar(225) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `level` char(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `nama`, `username`, `password`, `level`) VALUES
('USR00001', 'Nana Sukmana', 'Admin', 'd41d8cd98f00b204e9800998ecf8427e', 'U01'),
('USR00002', 'Deden Deendi', 'toolman=RPL', 'd41d8cd98f00b204e9800998ecf8427e', 'U02'),
('USR00003', 'Ilham Kamil', 'Toolman=MM', 'd41d8cd98f00b204e9800998ecf8427e', 'U02'),
('USR00004', 'Abdul Rahman', 'toolman=TKJ', 'd41d8cd98f00b204e9800998ecf8427e', 'U02'),
('USR20001', 'Dzaki', 'dzaki', 'd41d8cd98f00b204e9800998ecf8427e', 'U03'),
('USR20002', 'Sulthan', 'sultan', 'd41d8cd98f00b204e9800998ecf8427e', 'U03'),
('USR20003', 'Fahru', 'fahru', 'd41d8cd98f00b204e9800998ecf8427e', 'U03'),
('USR20004', 'Akwan', 'akwan', 'd41d8cd98f00b204e9800998ecf8427e', 'U03');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_barang_dipinjam`
-- (See below for the actual view)
--
CREATE TABLE `v_barang_dipinjam` (
`id_barang` char(8)
,`nama_barang` varchar(225)
,`peminjam` char(8)
,`tgl_pinjam` date
,`jml_pinjam` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_barang_keluar`
-- (See below for the actual view)
--
CREATE TABLE `v_barang_keluar` (
`id_barang` char(8)
,`nama_barang` varchar(225)
,`kondisi` varchar(20)
,`tgl_keluar` date
,`jml_keluar` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_jumlah_barang_masuk`
-- (See below for the actual view)
--
CREATE TABLE `v_jumlah_barang_masuk` (
`jumlah barang masuk` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_nilai_terendah`
-- (See below for the actual view)
--
CREATE TABLE `v_nilai_terendah` (
`id_barang` char(8)
,`nilai_terendah` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_nilai_tertinggi`
-- (See below for the actual view)
--
CREATE TABLE `v_nilai_tertinggi` (
`id_barang` char(8)
,`nilai_tertinggi` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_peminjam`
-- (See below for the actual view)
--
CREATE TABLE `v_peminjam` (
`id_user` char(8)
,`nama` varchar(225)
,`id_pinjam` int(11)
,`barang_pinjam` char(8)
,`tgl_pinjam` date
,`tgl_kembali` date
,`kondisi` varchar(225)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_ratarata_brg`
-- (See below for the actual view)
--
CREATE TABLE `v_ratarata_brg` (
`Rata rata barang masuk` decimal(14,4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_stok`
-- (See below for the actual view)
--
CREATE TABLE `v_stok` (
`id_barang` char(8)
,`nama_barang` varchar(225)
,`total_barang` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_sumber_dana`
-- (See below for the actual view)
--
CREATE TABLE `v_sumber_dana` (
`id_barang` char(8)
,`nama_barang` varchar(225)
,`id_sumber` char(4)
,`nama_sumber` varchar(225)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_suplai_barang_masuk`
-- (See below for the actual view)
--
CREATE TABLE `v_suplai_barang_masuk` (
`id_barang` char(8)
,`tgl_masuk` date
,`jml_masuk` int(11)
,`id_supplier` varchar(8)
,`nama_supplier` varchar(225)
);

-- --------------------------------------------------------

--
-- Structure for view `jumlah_barang_dipinjam_tiap_ruang`
--
DROP TABLE IF EXISTS `jumlah_barang_dipinjam_tiap_ruang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jumlah_barang_dipinjam_tiap_ruang`  AS SELECT `lk`.`id_lokasi` AS `id_lokasi`, `lk`.`nama_lokasi` AS `nama_lokasi`, `brg`.`id_barang` AS `id_barang`, count(`pjm`.`jml_pinjam`) AS `Lebih dari 1` FROM ((`pinjam_barang` `pjm` join `barang` `brg` on(`brg`.`id_barang` = `pjm`.`barang_pinjam`)) join `lokasi` `lk` on(`lk`.`id_lokasi` = `brg`.`lokasi`)) GROUP BY `pjm`.`barang_pinjam` HAVING `Lebih dari 1` > 1 ;

-- --------------------------------------------------------

--
-- Structure for view `jumlah_ruang`
--
DROP TABLE IF EXISTS `jumlah_ruang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jumlah_ruang`  AS SELECT count(`lokasi`.`nama_lokasi`) AS `Total Ruang` FROM `lokasi` ;

-- --------------------------------------------------------

--
-- Structure for view `jumlah_ruang_tiap_penanggung_jawab`
--
DROP TABLE IF EXISTS `jumlah_ruang_tiap_penanggung_jawab`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `jumlah_ruang_tiap_penanggung_jawab`  AS SELECT `lokasi`.`penanggung_jawab` AS `penanggung_jawab`, count(`lokasi`.`penanggung_jawab`) AS `Total Lokasi` FROM `lokasi` GROUP BY `lokasi`.`penanggung_jawab` ;

-- --------------------------------------------------------

--
-- Structure for view `v_barang_dipinjam`
--
DROP TABLE IF EXISTS `v_barang_dipinjam`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_barang_dipinjam`  AS SELECT `b`.`id_barang` AS `id_barang`, `b`.`nama_barang` AS `nama_barang`, `pb`.`peminjam` AS `peminjam`, `pb`.`tgl_pinjam` AS `tgl_pinjam`, `pb`.`jml_pinjam` AS `jml_pinjam` FROM (`barang` `b` left join `pinjam_barang` `pb` on(`b`.`id_barang` = `pb`.`barang_pinjam`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_barang_keluar`
--
DROP TABLE IF EXISTS `v_barang_keluar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_barang_keluar`  AS SELECT `b`.`id_barang` AS `id_barang`, `b`.`nama_barang` AS `nama_barang`, `b`.`kondisi` AS `kondisi`, `bk`.`tgl_keluar` AS `tgl_keluar`, `bk`.`jml_keluar` AS `jml_keluar` FROM (`barang` `b` left join `barang_keluar` `bk` on(`b`.`id_barang` = `bk`.`id_barang`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_jumlah_barang_masuk`
--
DROP TABLE IF EXISTS `v_jumlah_barang_masuk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_jumlah_barang_masuk`  AS SELECT sum(`stok`.`jml_masuk`) AS `jumlah barang masuk` FROM `stok` ;

-- --------------------------------------------------------

--
-- Structure for view `v_nilai_terendah`
--
DROP TABLE IF EXISTS `v_nilai_terendah`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_nilai_terendah`  AS SELECT `stok`.`id_barang` AS `id_barang`, min(`stok`.`jml_masuk`) AS `nilai_terendah` FROM `stok` GROUP BY `stok`.`jml_masuk` ;

-- --------------------------------------------------------

--
-- Structure for view `v_nilai_tertinggi`
--
DROP TABLE IF EXISTS `v_nilai_tertinggi`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_nilai_tertinggi`  AS SELECT `stok`.`id_barang` AS `id_barang`, max(`stok`.`jml_masuk`) AS `nilai_tertinggi` FROM `stok` ;

-- --------------------------------------------------------

--
-- Structure for view `v_peminjam`
--
DROP TABLE IF EXISTS `v_peminjam`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_peminjam`  AS SELECT `u`.`id_user` AS `id_user`, `u`.`nama` AS `nama`, `pb`.`id_pinjam` AS `id_pinjam`, `pb`.`barang_pinjam` AS `barang_pinjam`, `pb`.`tgl_pinjam` AS `tgl_pinjam`, `pb`.`tgl_kembali` AS `tgl_kembali`, `pb`.`kondisi` AS `kondisi` FROM (`user` `u` left join `pinjam_barang` `pb` on(`u`.`id_user` = `pb`.`peminjam`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_ratarata_brg`
--
DROP TABLE IF EXISTS `v_ratarata_brg`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_ratarata_brg`  AS SELECT avg(`stok`.`jml_masuk`) AS `Rata rata barang masuk` FROM `stok` ;

-- --------------------------------------------------------

--
-- Structure for view `v_stok`
--
DROP TABLE IF EXISTS `v_stok`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_stok`  AS SELECT `b`.`id_barang` AS `id_barang`, `b`.`nama_barang` AS `nama_barang`, `s`.`total_barang` AS `total_barang` FROM (`barang` `b` left join `stok` `s` on(`b`.`id_barang` = `s`.`id_barang`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_sumber_dana`
--
DROP TABLE IF EXISTS `v_sumber_dana`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_sumber_dana`  AS SELECT `b`.`id_barang` AS `id_barang`, `b`.`nama_barang` AS `nama_barang`, `sd`.`id_sumber` AS `id_sumber`, `sd`.`nama_sumber` AS `nama_sumber` FROM (`barang` `b` join `sumber_dana` `sd` on(`sd`.`id_sumber` = `b`.`sumber_dana`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_suplai_barang_masuk`
--
DROP TABLE IF EXISTS `v_suplai_barang_masuk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_suplai_barang_masuk`  AS SELECT `bm`.`id_barang` AS `id_barang`, `bm`.`tgl_masuk` AS `tgl_masuk`, `bm`.`jml_masuk` AS `jml_masuk`, `s`.`id_supplier` AS `id_supplier`, `s`.`nama_supplier` AS `nama_supplier` FROM (`barang_masuk` `bm` join `supplier` `s` on(`s`.`id_supplier` = `bm`.`supplier`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `sumber_dana` (`sumber_dana`),
  ADD KEY `lokasi` (`lokasi`);

--
-- Indexes for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `supplier` (`supplier`);

--
-- Indexes for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD KEY `id_barang` (`id_barang`),
  ADD KEY `supplier` (`supplier`);

--
-- Indexes for table `level_user`
--
ALTER TABLE `level_user`
  ADD PRIMARY KEY (`id_level`);

--
-- Indexes for table `lokasi`
--
ALTER TABLE `lokasi`
  ADD PRIMARY KEY (`id_lokasi`);

--
-- Indexes for table `pinjam_barang`
--
ALTER TABLE `pinjam_barang`
  ADD PRIMARY KEY (`id_pinjam`),
  ADD KEY `peminjam` (`peminjam`),
  ADD KEY `barang_pinjam` (`barang_pinjam`);

--
-- Indexes for table `stok`
--
ALTER TABLE `stok`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `sumber_dana`
--
ALTER TABLE `sumber_dana`
  ADD PRIMARY KEY (`id_sumber`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `level` (`level`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`sumber_dana`) REFERENCES `sumber_dana` (`id_sumber`),
  ADD CONSTRAINT `barang_ibfk_2` FOREIGN KEY (`lokasi`) REFERENCES `lokasi` (`id_lokasi`);

--
-- Constraints for table `barang_keluar`
--
ALTER TABLE `barang_keluar`
  ADD CONSTRAINT `barang_keluar_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `barang_keluar_ibfk_2` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`id_supplier`);

--
-- Constraints for table `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD CONSTRAINT `barang_masuk_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  ADD CONSTRAINT `barang_masuk_ibfk_2` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`id_supplier`);

--
-- Constraints for table `pinjam_barang`
--
ALTER TABLE `pinjam_barang`
  ADD CONSTRAINT `pinjam_barang_ibfk_1` FOREIGN KEY (`peminjam`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `pinjam_barang_ibfk_2` FOREIGN KEY (`barang_pinjam`) REFERENCES `barang` (`id_barang`);

--
-- Constraints for table `stok`
--
ALTER TABLE `stok`
  ADD CONSTRAINT `stok_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`level`) REFERENCES `level_user` (`id_level`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
