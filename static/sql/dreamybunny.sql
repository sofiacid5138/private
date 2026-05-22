-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 22, 2026 at 06:48 PM
-- Server version: 8.0.45
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dreamybunny`
--

-- --------------------------------------------------------

--
-- Table structure for table `bunny`
--

CREATE TABLE `bunny` (
  `id` int NOT NULL,
  `nombre` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `color` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `especialidad` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `precio` decimal(10,0) NOT NULL,
  `estado` enum('disponible','agotado') CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL DEFAULT 'disponible'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Dumping data for table `bunny`
--

INSERT INTO `bunny` (`id`, `nombre`, `color`, `especialidad`, `descripcion`, `precio`, `estado`) VALUES
(1, 'Hina Bunny', 'Rosa', 'Preparacion alimentos y decoracion ,Bienvenida', 'Maid dulce y delicada, siempre sonriente y experta en detalles kawaii.\r\nPersonalidad : es tímida y cariñosa \r\n ', 125, 'disponible'),
(2, 'Nami Bunny', 'Aqua', 'preparación de bebidas,smoothies ,entretenimiento', 'Descripción: Alegre y energética, especialista en bebidas y ambiente divertido\r\nPersonalidad: extrovertida y divertida', 110, 'disponible'),
(3, 'Yoru Bunny', 'Negro', ' atención de mesas ,supervisión /,caja', 'Descripción: Misteriosa y elegante, mantiene el orden y supervisa el servicio \r\nPersonalidad: seria y sofisticada', 120, 'disponible');

-- --------------------------------------------------------

--
-- Table structure for table `menu_bunny`
--

CREATE TABLE `menu_bunny` (
  `id` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `categoria` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `precio` decimal(10,0) DEFAULT NULL,
  `imagen` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Dumping data for table `menu_bunny`
--

INSERT INTO `menu_bunny` (`id`, `nombre`, `categoria`, `precio`, `imagen`) VALUES
(1, 'Pancakes Bunny Clásico ', 'PANCAKES', 80, 'pan1.png'),
(2, 'Pancakes Rosa Delicado ', 'PANCAKES', 85, 'pan2.png'),
(3, 'Pancakes Bunny Arándano', 'PANCAKES', 90, 'pan3.png'),
(4, 'Pancakes Bunny Chocolate', 'PANCAKES', 95, 'pan4.png'),
(5, 'Pancakes Bunny Matcha\r\n', 'PANCAKES', 90, 'pan6.png'),
(6, 'Desayuno Bunny Completo', 'COMIDAS COMPLETAS', 120, 'comida1.png'),
(7, 'Tostada Bunny Aguacate ', 'COMIDAS COMPLETAS', 95, 'comida2.png'),
(8, 'Mini Burgers Bunny ', 'COMIDAS COMPLETAS', 110, 'comida3.png'),
(9, 'Brunch Bunny', 'COMIDAS COMPLETAS', 130, 'comida5.png'),
(10, 'Ensalada Cute Bunny ', 'COMIDAS COMPLETAS', 85, 'comida4.png'),
(11, 'Sopa Cute Bunny ', 'COMIDAS COMPLETAS', 75, 'comida6.png'),
(12, 'Parfait Bunny Dreams', 'POSTRES', 70, 'pos1.png'),
(13, 'Pastelitos Bunny ', 'POSTRES', 65, 'pos2.png'),
(14, 'Cupcakes Bunny Gemelos', 'POSTRES', 75, 'pos3.png'),
(15, 'Tartaleta de Frutas Bunny', 'POSTRES', 80, 'pos4.png'),
(16, 'Donas Bunny Glasé ', 'POSTRES', 60, 'pos5.png'),
(17, 'Gelato Bunny', 'POSTRES', 70, 'pos6.png'),
(18, 'Soda Bubble Mint ', 'BEBIDAS', 50, 'be1.png'),
(19, 'Soda Bubble Berries ', 'BEBIDAS', 55, 'be2.png'),
(20, 'Chocolate Bunny Caliente', 'BEBIDAS', 60, 'be3.png'),
(21, 'Smoothie Bunny Melón', 'BEBIDAS', 60, 'be4.png'),
(22, 'Café Frío Bunny', 'BEBIDAS', 55, 'be5.png\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `nombre` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `correo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `clave` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `perfil` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'U'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `correo`, `clave`, `perfil`) VALUES
(1, 'sofi', 'sofiacidm@gmail.com', 'scrypt:32768:8:1$2d3pbfZkaclS2i8f$ef929d6f28816465b17b3a31d049f2a906ede388dffe2e7518d48fc9bab2a2b4fec24c46e5391ab84dfe564c94cb2e2cf8b5feed8a33f4001431443c78b481e1', 'A');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bunny`
--
ALTER TABLE `bunny`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_bunny`
--
ALTER TABLE `menu_bunny`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bunny`
--
ALTER TABLE `bunny`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `menu_bunny`
--
ALTER TABLE `menu_bunny`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
