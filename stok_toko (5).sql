-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 23, 2017 at 04:18 AM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stok_toko`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `laporan` (IN `awal` DATE, IN `akhir` DATE)  begin
select 
`penjualan`.`tgl_trans`,
`detail_pj`.`kd_brg`,
`barang`.`nama_brg`,
sum(`detail_pj`.`jml`) as terjual,
`barang`.`hrg_beli`,
`barang`.`hrg_jual`,
`barang`.`hrg_jual`-`barang`.`hrg_beli` as laba,
sum(`detail_pj`.`jml`*`barang`.`hrg_jual`) as subtotal
from `barang`,`detail_pj`,`penjualan`
where `barang`.`kd_brg`=`detail_pj`.`kd_brg`
and `detail_pj`.`kd_pj`=`penjualan`.`kd_pj`
and `penjualan`.`tgl_trans`>awal 
and `penjualan`.`tgl_trans`<akhir
GROUP BY `detail_pj`.`kd_brg`;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `laporan_total` (IN `awal` DATE, IN `akhir` DATE)  BEGIN
SELECT 
SUM(`detail_pj`.`jml`) AS terjual,
SUM(`detail_pj`.`jml`*`barang`.`hrg_jual`) AS subtotal,
sum(`barang`.`hrg_jual`-`barang`.`hrg_beli`) AS laba
FROM `barang`,`detail_pj`,`penjualan`
WHERE `barang`.`kd_brg`=`detail_pj`.`kd_brg`
AND `detail_pj`.`kd_pj`=`penjualan`.`kd_pj`
AND `penjualan`.`tgl_trans`>awal 
AND `penjualan`.`tgl_trans`<akhir;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampil_total` (IN `kd` VARCHAR(5))  BEGIN
select
sum(barang.hrg_jual*detail_pj.jml) as total_final
from barang,detail_pj,penjualan 
where barang.kd_brg=detail_pj.kd_brg
and detail_pj.kd_pj=penjualan.kd_pj
and detail_pj.kd_pj=kd group by penjualan.kd_pj ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `transaksi_kasir` (IN `kd` VARCHAR(5))  BEGIN
select
detail_pj.kd_detail,
detail_pj.kd_brg,
barang.nama_brg,
barang.hrg_jual,
sum(detail_pj.jml) as jml,
sum(barang.hrg_jual*detail_pj.jml) as jumlah
from barang,detail_pj,penjualan 
where barang.kd_brg=detail_pj.kd_brg
and detail_pj.kd_pj=penjualan.kd_pj
and detail_pj.kd_pj=kd GROUP BY detail_pj.kd_brg;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `applikasi_log`
--

CREATE TABLE `applikasi_log` (
  `aktivitas` varchar(100) DEFAULT NULL,
  `waktu` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `applikasi_log`
--

INSERT INTO `applikasi_log` (`aktivitas`, `waktu`) VALUES
('input barang usb port kode barang B13', '2017-05-13 07:41:50'),
('input barang (USB PORT .1) kode barang = B14', '2017-05-13 07:43:11'),
('Hapus  barang USB PORT .1 dengan kode B14', '2017-05-13 13:50:35'),
('input barang (LCD CLEANING KIT) kode barang = B14', '2017-05-13 14:02:02'),
('update  barang (Sodim 2GB) menjadi = Sodim 2GB', '2017-05-13 14:03:01'),
('update  barang (LCD CLEANING KIT) menjadi = LCD CLEANING KIT', '2017-05-14 01:02:00'),
('Hapus  barang kabel uty 45 dengan kode B11', '2017-05-14 01:02:43'),
('Hapus  barang Mantap Usb 3.1  1Tb dengan kode B12', '2017-05-14 01:02:43'),
('Hapus  barang usb port  dengan kode B13', '2017-05-14 01:02:43'),
('Hapus  barang LCD CLEANING KIT dengan kode B14', '2017-05-14 01:02:43'),
('input barang (LCD CLEANING KIT) kode barang = B11', '2017-05-14 10:01:20'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-14 15:46:17'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-14 23:45:22'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-14 23:55:49'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-14 23:57:30'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-14 23:57:42'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-14 23:58:19'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-14 23:58:52'),
('update  barang (Flashdisk 2GB) menjadi = Flashdisk 2GB', '2017-05-14 23:59:30'),
('update  barang (Flashdisk 2GB) menjadi = Flashdisk 2GB', '2017-05-14 23:59:33'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-14 23:59:59'),
('update  barang (Flashdisk 2GB) menjadi = Flashdisk 2GB', '2017-05-15 00:00:06'),
('update  barang (Flashdisk 2GB) menjadi = Flashdisk 2GB', '2017-05-15 00:00:23'),
('update  barang (Flashdisk 2GB) menjadi = Flashdisk 2GB', '2017-05-15 00:06:02'),
('update  barang (Speaker) menjadi = Speaker', '2017-05-15 00:06:09'),
('input barang (kabel utp) kode barang = B12', '2017-05-15 02:19:32'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-15 02:23:18'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-15 02:23:37'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-15 02:23:54'),
('update  barang (Flashdisk 2GB) menjadi = Flashdisk 2GB', '2017-05-19 10:00:00'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-19 10:00:14'),
('update  barang (Flashdisk 4GB) menjadi = Flashdisk 4GB', '2017-05-19 12:51:15'),
('update  barang (Mouse) menjadi = Mouse', '2017-05-19 12:51:23'),
('update  barang (Mouse) menjadi = Mouse', '2017-05-20 04:06:34');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `kd_brg` varchar(5) NOT NULL,
  `nama_brg` varchar(100) NOT NULL,
  `hrg_jual` int(11) NOT NULL,
  `hrg_beli` int(11) NOT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`kd_brg`, `nama_brg`, `hrg_jual`, `hrg_beli`, `stok`) VALUES
('B01', 'Flashdisk 4GB', 50000, 30000, 78),
('B02', 'Flashdisk 2GB', 30000, 15000, 4),
('B03', 'Flashdisk 8GB', 65000, 50000, 4),
('B04', 'Speaker', 230000, 150000, 7),
('B05', 'Mouse', 50000, 30000, 2),
('B06', 'Keyboard', 75000, 50000, 10),
('B07', 'Headset', 50000, 80000, 3),
('B08', 'RAM 2GB', 150000, 120000, 2),
('B09', 'RAM 4GB', 250000, 180000, 2),
('B10', 'Sodim 2GB', 110000, 70000, 80),
('B11', 'LCD CLEANING KIT', 100000, 75000, 100),
('B12', 'kabel utp', 10000, 8000, 100);

--
-- Triggers `barang`
--
DELIMITER $$
CREATE TRIGGER `barang_hapus` AFTER DELETE ON `barang` FOR EACH ROW BEGIN
INSERT INTO applikasi_log (aktivitas)
VALUES (
CONCAT('Hapus  barang ',old.nama_brg,' dengan kode ',old.kd_brg)
);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `barang_input` AFTER INSERT ON `barang` FOR EACH ROW begin
insert into applikasi_log (aktivitas)
values (
concat('input barang (',new.nama_brg,') kode barang = ',new.kd_brg)
);
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `barang_update` AFTER UPDATE ON `barang` FOR EACH ROW BEGIN
INSERT INTO applikasi_log (aktivitas)
VALUES (
CONCAT('update  barang (',old.nama_brg,') menjadi = ',new.nama_brg)
);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `kd_customer` varchar(5) NOT NULL,
  `nama_cus` varchar(100) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `alamat` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`kd_customer`, `nama_cus`, `tgl_lahir`, `alamat`) VALUES
('C01', 'ADI FERI ISMAIL', '1984-08-13', 'Wonosobo Rt 2 Rw 5'),
('C02', 'Beni', '1990-09-13', 'yogyakarta'),
('C03', 'Ahmad', '1986-04-19', 'Kalikajar'),
('C04', 'Supri', '1989-09-25', 'Wonogirii'),
('C05', 'Ipul ubah', '1991-07-22', 'Magelang oyi');

--
-- Triggers `customer`
--
DELIMITER $$
CREATE TRIGGER `cus_update` AFTER UPDATE ON `customer` FOR EACH ROW BEGIN
INSERT INTO applikasi_log (aktivitas)
VALUES (
CONCAT('update  Customer (',old.nama_cus,') menjadi = ',new.nama_cus)
);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_pj`
--

CREATE TABLE `detail_pj` (
  `kd_detail` int(11) NOT NULL,
  `kd_pj` varchar(5) NOT NULL,
  `kd_brg` varchar(5) NOT NULL,
  `jml` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detail_pj`
--

INSERT INTO `detail_pj` (`kd_detail`, `kd_pj`, `kd_brg`, `jml`) VALUES
(1, 'PJ01', 'B01', 3),
(2, 'PJ01', 'B08', 5),
(3, 'PJ02', 'B06', 1),
(4, 'PJ02', 'B04', 5),
(5, 'PJ03', 'B04', 2),
(6, 'PJ04', 'B02', 5),
(7, 'PJ05', 'B05', 7),
(8, 'PJ06', 'B06', 6),
(9, 'PJ07', 'B07', 9),
(10, 'PJ08', 'B10', 3),
(11, 'PJ09', 'B09', 12),
(14, 'PJ09', 'B04', 12),
(15, 'PJ07', 'B07', 8),
(16, 'PJ06', 'B02', 3),
(17, 'PJ01', 'B07', 6),
(18, 'PJ06', 'B08', 7),
(19, 'PJ04', 'B09', 7),
(21, 'PJ10', 'b02', 2),
(31, 'PJ10', 'B03', 1),
(36, 'PJ10', 'b03', 1),
(39, 'PJ01', 'B01', 1),
(40, 'PJ01', 'B01', 6),
(41, 'PJ01', 'B01', 2),
(44, 'PJ11', 'b01', 1),
(46, 'PJ11', 'b02', 2),
(47, 'PJ12', 'b01', 1),
(48, 'PJ12', 'B05', 1),
(49, 'PJ14', 'B08', 3),
(50, 'PJ14', 'b02', 1),
(53, 'PJ15', 'b01', 1),
(54, 'PJ16', 'b03', 1),
(57, 'pj16', 'B01', 1),
(58, 'pj16', 'B01', 1),
(63, 'PJ17', 'b01', 1),
(65, 'PJ17', 'b01', 1),
(67, 'PJ17', 'b02', 1),
(68, 'PJ17', 'b04', 1),
(69, 'PJ18', 'b01', 10),
(70, 'PJ18', 'b01', 10),
(72, 'PJ19', 'b02', 2),
(73, 'PJ19', 'b01', 1),
(75, 'PJ19', 'B01', 1);

--
-- Triggers `detail_pj`
--
DELIMITER $$
CREATE TRIGGER `update_stok` AFTER INSERT ON `detail_pj` FOR EACH ROW BEGIN
UPDATE barang SET stok=stok-new.jml 
WHERE kd_brg=new.kd_brg;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_stok_hapus` AFTER DELETE ON `detail_pj` FOR EACH ROW BEGIN
UPDATE barang SET stok=stok+old.jml WHERE kd_brg=old.kd_brg;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `menu_id` int(11) NOT NULL,
  `menu` varchar(20) NOT NULL,
  `menu_link` varchar(200) NOT NULL,
  `icon` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`menu_id`, `menu`, `menu_link`, `icon`) VALUES
(3, 'Petugas', '#', 'fa fa-address-card-o'),
(2, 'pelanggan', '#', 'fa fa-user-o'),
(1, 'Barang', '#', 'fa fa-file'),
(4, 'Pengaturan', '#', 'fa fa-gear'),
(5, 'Laporan', '#', 'fa fa-sticky-note-o'),
(6, 'log aktifitas', '#', 'fa fa-random'),
(0, 'TRANSAKSI', '#', 'fa fa-cart-plus');

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `kd_pj` varchar(5) NOT NULL,
  `tgl_trans` date NOT NULL,
  `kd_petugas` varchar(5) NOT NULL,
  `kd_customer` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`kd_pj`, `tgl_trans`, `kd_petugas`, `kd_customer`) VALUES
('PJ01', '2013-03-01', 'P01', 'C01'),
('PJ02', '2013-03-01', 'P01', 'C03'),
('PJ03', '2013-03-01', 'P02', 'C04'),
('PJ04', '2013-03-01', 'P03', 'C05'),
('PJ05', '2013-03-03', 'P03', 'C04'),
('PJ06', '2013-03-03', 'P02', 'C03'),
('PJ07', '2013-03-03', 'P02', 'C04'),
('PJ08', '2013-03-03', 'P02', 'C04'),
('PJ09', '2013-03-05', 'P02', 'C04'),
('PJ10', '2013-03-05', 'P01', 'C02'),
('PJ11', '2017-05-11', 'P01', 'C01'),
('PJ12', '2017-05-11', 'P01', 'C01'),
('PJ13', '2017-05-11', 'P01', 'C01'),
('PJ14', '2017-05-11', 'P01', 'C01'),
('PJ15', '2017-05-12', 'P01', 'C01'),
('PJ16', '2017-05-13', 'P01', 'C01'),
('PJ17', '2017-05-14', 'P01', 'C01'),
('PJ18', '2017-05-15', 'P01', 'C01'),
('PJ19', '2017-05-15', 'P01', 'C01');

-- --------------------------------------------------------

--
-- Table structure for table `petugas`
--

CREATE TABLE `petugas` (
  `kd_petugas` varchar(5) NOT NULL,
  `nama_petugas` varchar(100) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `jabatan` varchar(50) NOT NULL,
  `kunci` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `petugas`
--

INSERT INTO `petugas` (`kd_petugas`, `nama_petugas`, `tgl_lahir`, `jabatan`, `kunci`) VALUES
('P01', 'admin', '1989-05-09', 'admin', '202cb962ac59075b964b07152d234b70'),
('P02', 'Isnan', '1980-07-04', 'kasir', '202cb962ac59075b964b07152d234b70'),
('P03', 'Salasah', '1990-05-08', 'master', '202cb962ac59075b964b07152d234b70'),
('P05', 'Tia', '1992-07-13', 'kasir', '202cb962ac59075b964b07152d234b70');

--
-- Triggers `petugas`
--
DELIMITER $$
CREATE TRIGGER `petugas_hapus` AFTER DELETE ON `petugas` FOR EACH ROW BEGIN
INSERT INTO applikasi_log (aktivitas)
VALUES (
CONCAT('Hapus  petugas ',old.nama_petugas,' dengan kode ',old.nama_petugas)
);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `submenu`
--

CREATE TABLE `submenu` (
  `submenu_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `submenu` varchar(20) NOT NULL,
  `submenu_link` varchar(200) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `submenu`
--

INSERT INTO `submenu` (`submenu_id`, `menu_id`, `submenu`, `submenu_link`) VALUES
(11, 2, 'pelanggan edit', 'pages/pelanggan/pelanggan_edit.php'),
(4, 2, 'tambah pelanggan', 'pages/pelanggan/pelanggan_input.php'),
(3, 1, 'cari barang', 'pages/barang/barang.php'),
(2, 1, 'edit barang', 'pages/barang/barang_edit.php'),
(1, 1, 'input barang', 'pages/barang/barang_input.php'),
(6, 3, 'petugas tambah', 'pages/petugas/petugas_input.php'),
(7, 3, 'petugas edit', 'pages/petugas/petugas_edit.php'),
(8, 4, 'tambah menu', 'pages/pengaturan/tambahmenu.php'),
(9, 2, 'tampil pelanggan', 'pages/pelanggan/pelanggan.php'),
(10, 3, 'data petugas', 'pages/petugas/petugas_tampil.php'),
(14, 0, 'transaksi penjualan', 'pages/transaksi/penjualan.php'),
(15, 6, 'Aktifitas Aplikasi', 'pages/log/log.php'),
(16, 8, 'tambah sub menu', 'pages/menu/submenu_tambah.php'),
(17, 5, 'Laporan Bulanan', 'pages/laporan/laporan.php');

-- --------------------------------------------------------

--
-- Stand-in structure for view `tampil`
-- (See below for the actual view)
--
CREATE TABLE `tampil` (
`kd_petugas` varchar(5)
,`nama_petugas` varchar(100)
,`tgl_lahir` date
);

-- --------------------------------------------------------

--
-- Structure for view `tampil`
--
DROP TABLE IF EXISTS `tampil`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tampil`  AS  select `petugas`.`kd_petugas` AS `kd_petugas`,`petugas`.`nama_petugas` AS `nama_petugas`,`petugas`.`tgl_lahir` AS `tgl_lahir` from `petugas` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`kd_brg`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`kd_customer`);

--
-- Indexes for table `detail_pj`
--
ALTER TABLE `detail_pj`
  ADD PRIMARY KEY (`kd_detail`),
  ADD KEY `kd_pj` (`kd_pj`),
  ADD KEY `kd_brg` (`kd_brg`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`menu_id`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`kd_pj`),
  ADD KEY `kd_petugas` (`kd_petugas`),
  ADD KEY `kd_customer` (`kd_customer`);

--
-- Indexes for table `petugas`
--
ALTER TABLE `petugas`
  ADD PRIMARY KEY (`kd_petugas`);

--
-- Indexes for table `submenu`
--
ALTER TABLE `submenu`
  ADD PRIMARY KEY (`submenu_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_pj`
--
ALTER TABLE `detail_pj`
  MODIFY `kd_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `menu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `submenu`
--
ALTER TABLE `submenu`
  MODIFY `submenu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_pj`
--
ALTER TABLE `detail_pj`
  ADD CONSTRAINT `detail_pj_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjualan` (`kd_pj`),
  ADD CONSTRAINT `detail_pj_ibfk_2` FOREIGN KEY (`kd_brg`) REFERENCES `barang` (`kd_brg`);

--
-- Constraints for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `penjualan_ibfk_3` FOREIGN KEY (`kd_petugas`) REFERENCES `petugas` (`kd_petugas`),
  ADD CONSTRAINT `penjualan_ibfk_4` FOREIGN KEY (`kd_customer`) REFERENCES `customer` (`kd_customer`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
