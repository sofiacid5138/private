-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 26-05-2026 a las 16:45:25
-- Versión del servidor: 8.0.43
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dreamybunny`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bunny`
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
-- Volcado de datos para la tabla `bunny`
--

INSERT INTO `bunny` (`id`, `nombre`, `color`, `especialidad`, `descripcion`, `precio`, `estado`) VALUES
(1, 'Hina Bunny', 'Rosa', 'Preparacion alimentos y decoracion ,Bienvenida', 'Maid dulce y delicada, siempre sonriente y experta en detalles kawaii.\r\nPersonalidad : es tímida y cariñosa \r\n ', 125, 'disponible'),
(2, 'Nami Bunny', 'Aqua', 'preparación de bebidas,smoothies ,entretenimiento', 'Descripción: Alegre y energética, especialista en bebidas y ambiente divertido\r\nPersonalidad: extrovertida y divertida', 110, 'disponible'),
(3, 'Yoru Bunny', 'Negro', ' atención de mesas ,supervisión /,caja', 'Descripción: Misteriosa y elegante, mantiene el orden y supervisa el servicio \r\nPersonalidad: seria y sofisticada', 120, 'disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_bunny`
--

CREATE TABLE `menu_bunny` (
  `id` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `categoria` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `precio` decimal(10,0) DEFAULT NULL,
  `imagen` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `menu_bunny`
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
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `nombre` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `correo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `clave` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `perfil` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'U'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `correo`, `clave`, `perfil`) VALUES
(1, 'sofi', 'sofiacidm@gmail.com', 'scrypt:32768:8:1$2d3pbfZkaclS2i8f$ef929d6f28816465b17b3a31d049f2a906ede388dffe2e7518d48fc9bab2a2b4fec24c46e5391ab84dfe564c94cb2e2cf8b5feed8a33f4001431443c78b481e1', 'A'),
(3, 'Sakura Moon', 'sakura1@dreamy.com', 'scrypt:kawaii$hash01', 'U'),
(4, 'Luna Bunny', 'luna2@dreamy.com', 'scrypt:kawaii$hash02', 'U'),
(5, 'Mimi Cherry', 'mimi3@dreamy.com', 'scrypt:kawaii$hash03', 'U'),
(6, 'Yuki Star', 'yuki4@dreamy.com', 'scrypt:kawaii$hash04', 'U'),
(7, 'Hana Sweet', 'hana5@dreamy.com', 'scrypt:kawaii$hash05', 'U'),
(8, 'Neko Love', 'neko6@dreamy.com', 'scrypt:kawaii$hash06', 'U'),
(9, 'Aiko Dream', 'aiko7@dreamy.com', 'scrypt:kawaii$hash07', 'U'),
(10, 'Rina Cloud', 'rina8@dreamy.com', 'scrypt:kawaii$hash08', 'U'),
(11, 'Moka Puff', 'moka9@dreamy.com', 'scrypt:kawaii$hash09', 'U'),
(12, 'Choco Berry', 'choco10@dreamy.com', 'scrypt:kawaii$hash10', 'U'),
(13, 'Pinky Sky', 'pinky11@dreamy.com', 'scrypt:kawaii$hash11', 'U'),
(14, 'Kira Moonlight', 'kira12@dreamy.com', 'scrypt:kawaii$hash12', 'U'),
(15, 'Sora Bunny', 'sora13@dreamy.com', 'scrypt:kawaii$hash13', 'U'),
(16, 'Mika Sugar', 'mika14@dreamy.com', 'scrypt:kawaii$hash14', 'U'),
(17, 'Yume Star', 'yume15@dreamy.com', 'scrypt:kawaii$hash15', 'U'),
(18, 'Nana Soft', 'nana16@dreamy.com', 'scrypt:kawaii$hash16', 'U'),
(19, 'Hoshi Glow', 'hoshi17@dreamy.com', 'scrypt:kawaii$hash17', 'U'),
(20, 'Lili Pink', 'lili18@dreamy.com', 'scrypt:kawaii$hash18', 'U'),
(21, 'Momo Dreamy', 'momo19@dreamy.com', 'scrypt:kawaii$hash19', 'U'),
(22, 'Koko Sweet', 'koko20@dreamy.com', 'scrypt:kawaii$hash20', 'U'),
(23, 'Suki Cloud', 'suki21@dreamy.com', 'scrypt:kawaii$hash21', 'U'),
(24, 'Ami Cherry', 'ami22@dreamy.com', 'scrypt:kawaii$hash22', 'U'),
(25, 'Hina Glow', 'hina23@dreamy.com', 'scrypt:kawaii$hash23', 'U'),
(26, 'Ruru Bunny', 'ruru24@dreamy.com', 'scrypt:kawaii$hash24', 'U'),
(27, 'Tori Star', 'tori25@dreamy.com', 'scrypt:kawaii$hash25', 'U'),
(28, 'Mimi Latte', 'mimi26@dreamy.com', 'scrypt:kawaii$hash26', 'U'),
(29, 'Lala Moon', 'lala27@dreamy.com', 'scrypt:kawaii$hash27', 'U'),
(30, 'Kiki Dream', 'kiki28@dreamy.com', 'scrypt:kawaii$hash28', 'U'),
(31, 'Nini Soft', 'nini29@dreamy.com', 'scrypt:kawaii$hash29', 'U'),
(32, 'Yaya Pink', 'yaya30@dreamy.com', 'scrypt:kawaii$hash30', 'U'),
(33, 'Coco Star', 'coco31@dreamy.com', 'scrypt:kawaii$hash31', 'U'),
(34, 'Luna Sugar', 'luna32@dreamy.com', 'scrypt:kawaii$hash32', 'U'),
(35, 'Mimi Sky', 'mimi33@dreamy.com', 'scrypt:kawaii$hash33', 'U'),
(36, 'Sakura Glow', 'sakura34@dreamy.com', 'scrypt:kawaii$hash34', 'U'),
(37, 'Hana Bunny', 'hana35@dreamy.com', 'scrypt:kawaii$hash35', 'U'),
(38, 'Yuki Cloud', 'yuki36@dreamy.com', 'scrypt:kawaii$hash36', 'U'),
(39, 'Rina Star', 'rina37@dreamy.com', 'scrypt:kawaii$hash37', 'U'),
(40, 'Moka Dream', 'moka38@dreamy.com', 'scrypt:kawaii$hash38', 'U'),
(41, 'Neko Pink', 'neko39@dreamy.com', 'scrypt:kawaii$hash39', 'U'),
(42, 'Aiko Moon', 'aiko40@dreamy.com', 'scrypt:kawaii$hash40', 'U'),
(43, 'Puffy Love', 'puffy41@dreamy.com', 'scrypt:kawaii$hash41', 'U'),
(44, 'Chibi Star', 'chibi42@dreamy.com', 'scrypt:kawaii$hash42', 'U'),
(45, 'Mimi Candy', 'mimi43@dreamy.com', 'scrypt:kawaii$hash43', 'U'),
(46, 'Sora Dream', 'sora44@dreamy.com', 'scrypt:kawaii$hash44', 'U'),
(47, 'Hoshi Bunny', 'hoshi45@dreamy.com', 'scrypt:kawaii$hash45', 'U'),
(48, 'Kira Glow', 'kira46@dreamy.com', 'scrypt:kawaii$hash46', 'U'),
(49, 'Lili Moon', 'lili47@dreamy.com', 'scrypt:kawaii$hash47', 'U'),
(50, 'Momo Pink', 'momo48@dreamy.com', 'scrypt:kawaii$hash48', 'U'),
(51, 'Yume Cloud', 'yume49@dreamy.com', 'scrypt:kawaii$hash49', 'U'),
(52, 'Nana Star', 'nana50@dreamy.com', 'scrypt:kawaii$hash50', 'U');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bunny`
--
ALTER TABLE `bunny`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `menu_bunny`
--
ALTER TABLE `menu_bunny`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bunny`
--
ALTER TABLE `bunny`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `menu_bunny`
--
ALTER TABLE `menu_bunny`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
