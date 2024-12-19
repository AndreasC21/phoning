-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 02, 2024 at 03:05 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `phoning`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id_cart` int NOT NULL,
  `id_user` int NOT NULL,
  `id_phone` int NOT NULL,
  `quantity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id_cart`, `id_user`, `id_phone`, `quantity`) VALUES
(23, 1, 5, 1),
(24, 1, 3, 2),
(28, 1, 20, 4),
(29, 6, 19, 3),
(30, 1, 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `merk`
--

CREATE TABLE `merk` (
  `id_merk` int NOT NULL,
  `nama_merk` varchar(10) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `merk`
--

INSERT INTO `merk` (`id_merk`, `nama_merk`) VALUES
(101, 'Samsung'),
(102, 'Oppo'),
(103, 'Apple'),
(104, 'Xiaomi'),
(105, 'Redmi'),
(106, 'Vivo'),
(107, 'POCO'),
(108, 'Infinix'),
(109, 'Tecno'),
(110, 'itel'),
(111, 'Realme'),
(112, 'iQOO'),
(113, 'nubia');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id_order` varchar(50) NOT NULL DEFAULT '',
  `id_user` int NOT NULL,
  `id_phone` int NOT NULL DEFAULT '0',
  `quantity` int NOT NULL DEFAULT '0',
  `total_price` decimal(10,2) NOT NULL,
  `shipping` decimal(10,2) NOT NULL,
  `fee` decimal(10,2) NOT NULL,
  `order_date` datetime NOT NULL,
  `status` enum('pending','on progress','cancelled','completed') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id_order`, `id_user`, `id_phone`, `quantity`, `total_price`, `shipping`, `fee`, `order_date`, `status`) VALUES
('P1732641219366G', 1, 9, 2, 3938592.00, 25000.00, 15592.00, '2024-11-27 00:13:39', 'on progress'),
('P1732721336016G', 1, 6, 1, 1478347.00, 25000.00, 4347.00, '2024-11-27 22:28:56', 'on progress'),
('P1732987417494G', 1, 17, 1, 5243697.00, 25000.00, 19497.00, '2024-12-01 00:23:37', 'pending'),
('P1733046154749G', 4, 5, 1, 2029997.00, 25000.00, 5997.00, '2024-12-01 16:42:34', 'pending'),
('P1733061647312G', 1, 4, 1, 3236197.00, 25000.00, 11997.00, '2024-12-01 21:00:47', 'pending'),
('P1733104989181G', 6, 19, 3, 40975591.00, 25000.00, 152991.00, '2024-12-02 09:03:09', 'completed');

-- --------------------------------------------------------

--
-- Table structure for table `phone`
--

CREATE TABLE `phone` (
  `id_phone` int NOT NULL,
  `nama_merk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_phone` varchar(50) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `img_phone` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `harga` int NOT NULL,
  `stok` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `phone`
--

INSERT INTO `phone` (`id_phone`, `nama_merk`, `nama_phone`, `description`, `img_phone`, `harga`, `stok`) VALUES
(1, 'POCO', 'POCO X6 Pro 5G', '12/512GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-poco-x6-pro.jpg', 4899000, NULL),
(2, 'POCO', 'POCO F6', '8/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-poco-f6.jpg', 4999000, NULL),
(3, 'POCO', 'POCO M6 Pro', '8/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-poco-m6-pro-4g.jpg', 2999000, NULL),
(4, 'POCO', 'POCO X6 5G', '12/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-poco-x6.jpg', 3999000, NULL),
(5, 'POCO', 'POCO M6', '8/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-poco-m6-4g.jpg', 1999000, NULL),
(6, 'POCO', 'POCO C75', '6/126GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-poco-c75-.jpg', 1449000, NULL),
(7, 'Redmi', 'Redmi Note 13', '8/128GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-redmi-note-13-4g.jpg', 2189000, NULL),
(8, 'Redmi', 'Redmi 14C', '6/128GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-redmi-14c.jpg', 1499000, NULL),
(9, 'Redmi', 'Redmi 13', '8/128GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-redmi-13-.jpg', 1949000, NULL),
(10, 'Redmi', 'Redmi Note 13 Pro 5G', '8/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-redmi-note-13-pro-5g.jpg', 4399000, NULL),
(11, 'Redmi', 'Redmi Note 13 Pro', '8/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-redmi-note-13-pro-4g.jpg', 3499000, NULL),
(12, 'Redmi', 'Redmi A3', '4/128GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-redmi-a3.jpg', 1299000, NULL),
(13, 'Redmi', 'Redmi Note 13 5G', '8/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-redmi-note-13-5g.jpg', 2999000, NULL),
(14, 'Redmi', 'Redmi Note 13 Pro+ 5G', '12/512GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-redmi-note-13-pro-plus-int.jpg', 5999000, NULL),
(15, 'Redmi', 'Redmi 13C', '8/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-redmi-13c.jpg', 1799000, NULL),
(16, 'Xiaomi', 'Xiaomi 14', '12/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-14-new.jpg', 11999000, NULL),
(17, 'Xiaomi', 'Xiaomi 14T', '12/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-14t.jpg', 6499000, NULL),
(18, 'Xiaomi', 'Xiaomi 14T Pro', '12/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/xiaomi-14t-pro.jpg', 8499000, NULL),
(19, 'Samsung', 'Samsung Galaxy Z Flip6', '12/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/samsung-galaxy-z-flip6.jpg', 16999000, NULL),
(20, 'Samsung', 'Samsung Galaxy Z Fold6', '12/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/samsung-galaxy-z-fold6.jpg', 25999000, NULL),
(21, 'Samsung', 'Samsung Galaxy S24 Ultra', '12/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/samsung-galaxy-s24-ultra-5g-sm-s928-stylus.jpg', 19099000, NULL),
(22, 'Samsung', 'Samsung Galaxy S24+', '12/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/samsung-galaxy-s24-plus-5g-sm-s926.jpg', 15150000, NULL),
(23, 'Samsung', 'Samsung Galaxy S24', '8/256GB', 'https://fdn2.gsmarena.com/vv/bigpic/samsung-galaxy-s24-5g-sm-s921.jpg', 12499000, NULL),
(24, 'Samsung', 'Samsung Galaxy S23 FE', '8/128GB', 'https://fdn2.gsmarena.com/vv/bigpic/samsung-galaxy-s23-fe.jpg', 7149000, NULL),
(25, 'Apple', 'iPhone 16 Pro Max', '6/128GB', 'https://fdn2.gsmarena.com/vv/bigpic/apple-iphone-15.jpg', 12599000, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `spec`
--

CREATE TABLE `spec` (
  `id_spec` int NOT NULL,
  `id_phone` int NOT NULL,
  `chipset` text NOT NULL,
  `kamera` text NOT NULL,
  `layar` text NOT NULL,
  `memori` text NOT NULL,
  `baterai` text NOT NULL,
  `sistem` text NOT NULL,
  `berat` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `spec`
--

INSERT INTO `spec` (`id_spec`, `id_phone`, `chipset`, `kamera`, `layar`, `memori`, `baterai`, `sistem`, `berat`) VALUES
(1, 1, 'Mediatek Dimensity 8300 Ultra (4 nm)', '64 MP, f/1.7, 25mm (wide), 1/2.0\", 0.7µm, PDAF, OIS. 8 MP, f/2.2, 120˚ (ultrawide). 2 MP, f/2.4, (macro)', 'AMOLED, 68B colors, 120Hz, HDR10+, Dolby Vision, 6.67 inches, 1220 x 2712 pixels, Corning Gorilla Glass 5', '12GB RAM, 512GB (UFS 4.0)', '5000 mAh, non-removable. 67W wired', 'Android 14, up to 3 major Android upgrades, HyperOS', 186),
(2, 2, 'Qualcomm SM8635 Snapdragon 8s Gen 3 (4 nm)', '50 MP, f/1.6, (wide), 1/1.95\", 0.8µm, multi-directional PDAF, OIS. 8 MP, (ultrawide), 1/4.0\", 1.12µm', 'AMOLED, 68B colors, 120Hz, HDR10+, Dolby Vision, 6.67 inches, 1220 x 2712 pixels, Corning Gorilla Glass Victus', '8GB RAM, 256GB (UFS 4.0)', '5000 mAh, non-removable. 90W wired', 'Android 14, up to 3 major Android upgrades, HyperOS', 179),
(3, 3, 'Mediatek Helio G99 Ultra', '64 MP, f/1.8, 25mm (wide), 1/2.0\", 0.7µm, PDAF, OIS. 8 MP, f/2.2, (ultrawide). 2 MP, f/2.4, (macro)', 'AMOLED, 120Hz, 6.67 inches, 1080 x 2400 pixels, Corning Gorilla Glass 5', '8GB RAM, 256GB (UFS 2.2)', '5000 mAh, non-removable. 67W wired', 'Android 13, MIUI 14, planned upgrade to Android 14, HyperOS', 179),
(4, 4, 'Qualcomm SM7435-AB Snapdragon 7s Gen 2 (4 nm)', '64 MP, f/1.8, 25mm (wide), 0.7µm, PDAF, OIS. 8 MP, f/2.2, 118˚ (ultrawide), 1/4.0\", 1.12µm. 2 MP, f/2.4, (macro)', 'AMOLED, 68B colors, 120Hz, Dolby Vision, 6.67 inches, 1220 x 2712 pixels, Corning Gorilla Glass Victus', '12GB RAM, 256GB (UFS 2.2)', '5100 mAh, non-removable. 67W wired', 'Android 13, up to 3 major Android upgrades, HyperOS', 181),
(5, 5, 'Mediatek Dimensity 6100+ (6 nm)', '50 MP, f/1.8, 28mm (wide), PDAF. 0.08 MP (auxiliary lens)', 'IPS LCD, 90Hz, 6.74 inches, 720 x 1600 pixels, Corning Gorilla Glass', '8GB RAM, 256GB (UFS 2.2)', 'Li-Po 5000 mAh, non-removable. 18W wired', 'Android 13, MIUI 14', 195),
(6, 6, 'Mediatek Helio G81 Ultra (12 nm)', '50 MP, f/1.8, 28mm (wide), PDAF. Auxiliary lens', 'IPS LCD, 120Hz, 6.88 inches, 720 x 1640 pixels', '6GB RAM, 128GB (eMMC 5.1)', '5160 mAh, non-removable. 18W wired', 'Android 14, HyperOS', 204),
(8, 7, 'Mediatek Dimensity 6080 (6 nm)', '108 MP, f/1.7, (wide), 1/1.67\", 0.64µm, PDAF. 8 MP, f/2.2, (ultrawide). 2 MP, f/2.4, (depth)', 'AMOLED, 1B colors*, 120Hz, 6.67 inches, 1080 x 2400 pixels, Corning Gorilla Glass 5', '8GB RAM, 128GB (UFS 2.2)', 'Li-Po 5000 mAh, non-removable. 33W wired', 'Android 13, up to 3 major Android upgrades, HyperOS', 174),
(9, 8, 'Mediatek Helio G81 Ultra', '50 MP, f/1.8, 28mm (wide), PDAF. 2 MP, f/2.4, (depth). 0.08 MP (auxiliary lens)', 'IPS LCD, 120Hz, 6.88 inches, 720 x 1640 pixels', '6GB RAM, 128GB (eMMC 5.1)', '5160 mAh, non-removable. 18W wired', 'Android 14, HyperOS', 204),
(10, 9, 'Mediatek Helio G91 Ultra (12 nm)', '108 MP, f/1.8, (wide), 1/1.67\", 0.64µm, PDAF. 2 MP, f/2.4, (macro)', 'IPS LCD, 90Hz, 6.79 inches, 1080 x 2460 pixels, Corning Gorilla Glass', '8GB RAM, 128GB (eMMC 5.1)', '5030 mAh, non-removable. 33W wired', 'Android 14, HyperOS', 205),
(11, 10, 'Qualcomm SM7435-AB Snapdragon 7s Gen 2 (4 nm)', '200 MP, f/1.7, 23mm (wide), 1/1.4\", 0.56µm, multi-directional PDAF, OIS. 8 MP, f/2.2, 118˚ (ultrawide). 2 MP, f/2.4, (macro)', 'AMOLED, 68B colors, 120Hz, Dolby Vision, 6.67 inches, 1220 x 2712 pixels, Corning Gorilla Glass Victus', '8GB RAM, 256GB (UFS 2.2)', 'Li-Po 5100 mAh, non-removable. 67W wired', 'Android 13, up to 3 major Android upgrades, HyperOS', 187),
(12, 11, 'Mediatek Helio G99 Ultra', '200 MP, f/1.7, 23mm (wide), 1/1.4\", 0.56µm, multi-directional PDAF, OIS. 8 MP, f/2.2, 120˚, (ultrawide). 2 MP, f/2.4, (macro)', 'AMOLED, 1B colors, 120Hz, 6.67 inches, 1080 x 2400 pixels, Corning Gorilla Glass 5', '8GB RAM, 256GB (UFS 2.2)', '5000 mAh, non-removable. 67W wired', 'Android 13, up to 3 major Android upgrades, HyperOS', 188),
(13, 12, 'Mediatek Helio G36 (12 nm)', '8 MP, f/2.0, (wide). 0.08 MP (auxiliary lens). 5 MP, f/2.2, (selfie)', 'IPS LCD, 90Hz, 6.71 inches, 720 x 1650 pixels, Corning Gorilla Glass 3 ', '4GB RAM, 128GB (eMMC 5.1)', '5000 mAh, non-removable. 10W wired', 'Android 14, MIUI', 193),
(14, 13, 'Mediatek Dimensity 6080 (6 nm)', '108 MP, f/1.7, (wide), 1/1.67\", 0.64µm, PDAF. 8 MP, f/2.2, (ultrawide). 2 MP, f/2.4, (depth). 16 MP, f/2.4, (selfie)', 'AMOLED, 1B colors*, 120Hz, 6.67 inches, 1080 x 2400 pixels, Corning Gorilla Glass 5', '8GB RAM, 256GB (UFS 2.2)', 'Li-Po 5000 mAh, non-removable. 33W wired', 'Android 13, up to 3 major Android upgrades, HyperOS', 174),
(15, 14, 'Mediatek Dimensity 7200 Ultra (4 nm)', '200 MP, f/1.7, 23mm (wide), 1/1.4\", 0.56µm, multi-directional PDAF, OIS. 8 MP, f/2.2, 120˚ (ultrawide). 2 MP, f/2.4, (macro). 16 MP, f/2.4, (selfie)', 'AMOLED, 68B colors, 120Hz, Dolby Vision, HDR10+, 6.67 inches, 1220 x 2712 pixels, Corning Gorilla Glass Victus', '12GB RAM, 512GB (UFS 3.1)', 'Li-Po 5000 mAh, non-removable. 120W wired', 'Android 13, up to 3 major Android upgrades, HyperOS', 199),
(16, 15, 'Mediatek MT6769Z Helio G85 (12 nm)', '50 MP, f/1.8, 28mm (wide), PDAF. 2 MP, f/2.4, (macro). 0.08 MP (auxiliary lens). 8 MP, f/2.0 (selfie)', 'IPS LCD, 90Hz, 6.74 inches, 720 x 1600 pixels, Corning Gorilla Glass', '8GB RAM, 256GB (eMMC 5.1)', 'Li-Po 5000 mAh, non-removable. 18W wired', 'Android 13, MIUI 14', 192),
(17, 16, 'Qualcomm SM8650-AB Snapdragon 8 Gen 3 (4 nm)', '50 MP, f/1.6, 23mm (wide), 1/1.31\", 1.2µm, dual pixel PDAF, OIS. 50 MP, f/2.0, 75mm (telephoto), PDAF (10cm - ∞), OIS, 3.2x optical zoom. 50 MP, f/2.2, 14mm, 115˚ (ultrawide). 32 MP, f/2.0, 22mm (wide), 0.7µm (selfie)', 'LTPO OLED, 68B colors, 120Hz, Dolby Vision, HDR10+, 6.36 inches, 1200 x 2670 pixels, Corning Gorilla Glass Victus', '12GB RAM, 256GB (UFS 4.0)', 'Li-Po 4610 mAh, non-removable. 90W wired, 50W wireless, 10W reverse wireless', 'Android 14, upgradable to Android 15, up to 4 major Android upgrades, HyperOS 1.1', 188),
(18, 17, 'Mediatek Dimensity 8300 Ultra (4 nm)', '50 MP (wide) OIS. 50 MP (telephoto) 2x optical zoom. 12 MP (ultrawide). 32 MP (selfie)', 'AMOLED, 68B colors, 144Hz, Dolby Vision, HDR10+, 6.67 inches, 1220 x 2712 pixels, Corning Gorilla Glass 5', '12GB RAM, 256GB (UFS 4.0)', 'Li-Po 5000 mAh, non-removable. 67W wired', 'Android 14, HyperOS', 193),
(19, 18, 'Mediatek Dimensity 9300+ (4 nm)', '50 MP (wide) OIS. 50 MP (telephoto) 2.6x optical zoom. 12 MP (ultrawide). 32 MP (selfie)', 'AMOLED, 68B colors, 144Hz, Dolby Vision, HDR10+, 6.67 inches, 1220 x 2712 pixels, Scratch/drop-resistant glass', '12GB RAM, 256GB (UFS 4.0)', 'Li-Po 5000 mAh, non-removable. 120W wired', 'Android 14, HyperOS', 209),
(20, 19, 'Qualcomm SM8650-AC Snapdragon 8 Gen 3 (4 nm)', '50 MP (wide) OIS.\r\n12 MP (ultrawide).\r\n10 MP (selfie).', 'Foldable Dynamic LTPO AMOLED 2X, 120Hz, HDR10+, 6.7 inches, 1080 x 2640 pixels.\r\n\r\nCover Display: Super AMOLED, 60Hz, 3.4 inches, 720 x 748 pixels, Gorilla Glass Victus 2.', '12GB RAM, 256GB (UFS 4.0)', '4000 mAh, non-removable. 25W wired,\r\n15W wireless,\r\n4.5W reverse wireless.', 'Android 14, One UI 6.1.1', 187),
(21, 20, 'Qualcomm SM8650-AC Snapdragon 8 Gen 3 (4 nm)', '50 MP (wide) OIS.\r\n10 MP (telephoto) OIS, 3x optical zoom.\r\n12 MP (ultrawide). \r\n\r\n4 MP (selfie) under display.\r\n10 MP (selfie cover display)', 'Foldable Dynamic LTPO AMOLED 2X, 120Hz, HDR10+, 7.6 inches, 1856 x 2160 pixels.\r\n\r\nCover display:\r\nDynamic LTPO AMOLED 2X, 120Hz, Corning Gorilla Glass Victus 2.', '12GB RAM, 256GB (UFS 4.0)', 'Li-Po 4400 mAh, non-removable. 25W wired,\r\n15W wireless,\r\n4.5W reverse wireless.', 'Android 14, up to 4 major Android upgrades, One UI 6.1.1', 239),
(22, 21, 'Qualcomm SM8650-AC Snapdragon 8 Gen 3 (4 nm)', '200 MP (wide) multi-directional PDAF OIS.\r\n10 MP (telephoto) OIS 3x optical zoom.\r\n50 MP (periscope telephoto) OIS, 5x optical zoom.\r\n12 MP (ultrawide) dual pixel PDAF, Super Steady video.\r\n12 MP (selfie) dual pixel PDAF', 'Dynamic LTPO AMOLED 2X, 120Hz, HDR10+, 6.8 inches, 1440 x 3120 pixels, Corning Gorilla Armor', '12GB RAM, 256GB (UFS 4.0)', 'Li-Ion 5000 mAh, non-removable. 45W wired, \r\n15W wireless (Qi/PMA),\r\n4.5W reverse wireless.', 'Android 14, up to 7 major Android upgrades, One UI 6.1.1', 232),
(23, 22, 'Exynos 2400 (4 nm)', '50 MP (wide) dual pixel PDAF OIS.\r\n10 MP (telephoto)OIS, 3x optical zoom.\r\n12 MP 120˚ (ultrawide) Super Steady video.\r\n12 MP (selfie), dual pixel PDAF.', 'Dynamic LTPO AMOLED 2X, 120Hz, HDR10+, 6.7 inches, 1440 x 3120 pixels, Corning Gorilla Glass Victus 2.', '12GB RAM, 256GB (UFS 4.0)', 'Li-Ion 4900 mAh, non-removable.\r\n45W wired, 15W wireless (Qi/PMA), 4.5W reverse wireless.', 'Android 14, up to 7 major Android upgrades, One UI 6.1.1', 196),
(24, 23, 'Exynos 2400 (4 nm)', '50 MP (wide) dual pixel PDAF OIS.\r\n10 MP (telephoto) OIS 3x optical zoom.\r\n12 MP 120˚ (ultrawide) Super Steady video.\r\n12 MP (selfie) dual pixel PDAF.', 'Dynamic LTPO AMOLED 2X, 120Hz, HDR10+, 6.2 inches, 1080 x 2340 pixels, Corning Gorilla Glass Victus 2', '8GB RAM, 256GB (UFS 4.0)', 'Li-Ion 4000 mAh, non-removable. 25W wired, \r\n15W wireless (Qi/PMA), 4.5W reverse wireless.', 'Android 14, up to 7 major Android upgrades, One UI 6.1.1', 167),
(25, 24, 'https://fdn2.gsmarena.com/vv/bigpic/samsung-galaxy-s23-fe.jpg', '50 MP (wide) dual pixel PDAF OIS. 8 MP (telephoto) OIS 3x optical zoom. 12 MP 123˚ (ultrawide). 10 MP (selfie).', 'Dynamic AMOLED 2X, 120Hz, HDR10+, 6.4 inches, 1080 x 2340 pixels, Corning Gorilla Glass 5', '8GB RAM, 128GB (UFS 3.1)', 'Li-Ion 4500 mAh, non-removable. 25W wired, 15W wireless, Reverse wireless', 'Android 13, up to 4 major Android upgrades, One UI 6.1', 209),
(26, 25, 'Apple A16 Bionic (4 nm)', '48 MP (wide) OIS.\r\n12 MP 120˚ (ultrawide).\r\n12 MP (selfie).', 'Super Retina XDR OLED, HDR10, Dolby Vision, 6.1 inches, 1179 x 2556 pixels, Ceramic Shield glass', '6GB RAM, 128GB (NVMe)', 'Li-Ion 3349 mAh, non-removable.\r\nWired, PD2.0, 50% in 30 min (advertised),\r\n15W wireless (MagSafe),\r\n15W wireless,\r\n4.5W reverse wired.', 'iOS 17, upgradable to iOS 18.1', 171);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `no_telp` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `img` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `email`, `no_telp`, `alamat`, `img`) VALUES
(1, 'kitakita', '$2b$08$Ahl/4q2CkdeCTxcHJKErMem4ohqAyeMMTPWottQvmlmsIBRnvuU/q', 'andreascalvin21@gmail.com', '08987688767', 'Jalan Kemayoran Bangsa no 126 Provinsi Natlan.', 'uploads\\profile\\img-1733062668394-492142356.jpg'),
(2, 'Itsuki', '$2b$08$v5gEWAjBrmiqZH0E9okveuG6qqFzwG9sF9pkTdoKzbOovd3mwzpXS', NULL, NULL, NULL, NULL),
(3, 'Andreas', '$2b$08$osCmOZctjspPynafI45gE.yH4b6EPm9hFc1gFftkQcgbrA46E9Rfy', 'fnjiwcdh@kozk.com', '0847383423', 'Jalan Phoning', 'uploads\\profile\\img-1733045164774-287729747.jpg'),
(4, 'Bryan', '$2b$08$ftfBZ017pEkP/t8S8/3YB.atkSinrEl2rDm5bDIX4kG4FUV1idOZG', 'btehud@kofds.com', '089876887655', 'fsdfsfsfs', ''),
(5, 'kit', '$2b$08$MuQgNEF1XeGN.gXRJm.qTuPMANtkzoY47UQpJFOGAUTAWh0MwVEi2', NULL, NULL, NULL, NULL),
(6, 'satudua', '$2b$08$BxSdpR7AtgTSrda2HsOSQeZXiPYiE6yI4esnnLyhO5Aaqf05oKLOu', 'gamerkece21@gmail.com', '089876887655', 'Jalan demang lebar daun', 'uploads\\profile\\img-1733105084020-471106052.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `vouchers`
--

CREATE TABLE `vouchers` (
  `id` int NOT NULL,
  `code` varchar(50) NOT NULL,
  `tipe` enum('persentase','nominal') NOT NULL,
  `nilai` decimal(10,2) NOT NULL,
  `status` enum('aktif','nonaktif') DEFAULT 'aktif',
  `expired_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `vouchers`
--

INSERT INTO `vouchers` (`id`, `code`, `tipe`, `nilai`, `status`, `expired_date`, `created_at`) VALUES
(1, 'DISKONPPN', 'persentase', 20.00, 'aktif', NULL, '2024-11-30 15:07:37'),
(2, 'POTONGANCOY', 'nominal', 200000.00, 'aktif', NULL, '2024-11-30 15:07:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id_cart`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_phone` (`id_phone`);

--
-- Indexes for table `merk`
--
ALTER TABLE `merk`
  ADD PRIMARY KEY (`id_merk`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id_order`),
  ADD KEY `userFKorders` (`id_user`),
  ADD KEY `phoneFKorders` (`id_phone`);

--
-- Indexes for table `phone`
--
ALTER TABLE `phone`
  ADD PRIMARY KEY (`id_phone`) USING BTREE;

--
-- Indexes for table `spec`
--
ALTER TABLE `spec`
  ADD PRIMARY KEY (`id_spec`),
  ADD KEY `phoneFKspec` (`id_phone`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id_cart` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `phone`
--
ALTER TABLE `phone`
  MODIFY `id_phone` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `spec`
--
ALTER TABLE `spec`
  MODIFY `id_spec` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `phoneFKcart` FOREIGN KEY (`id_phone`) REFERENCES `phone` (`id_phone`),
  ADD CONSTRAINT `userFKcart` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `phoneFKorders` FOREIGN KEY (`id_phone`) REFERENCES `phone` (`id_phone`),
  ADD CONSTRAINT `userFKorders` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `spec`
--
ALTER TABLE `spec`
  ADD CONSTRAINT `phoneFKspec` FOREIGN KEY (`id_phone`) REFERENCES `phone` (`id_phone`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
