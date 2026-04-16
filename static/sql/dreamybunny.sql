-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 16-04-2026 a las 17:30:15
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
  `nombre` varchar(50) COLLATE utf8mb3_spanish_ci NOT NULL,
  `color` varchar(20) COLLATE utf8mb3_spanish_ci NOT NULL,
  `especialidad` varchar(50) COLLATE utf8mb3_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb3_spanish_ci NOT NULL,
  `precio` decimal(10,0) NOT NULL,
  `estado` enum('disponible','agotado') COLLATE utf8mb3_spanish_ci NOT NULL DEFAULT 'disponible'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `bunny`
--

INSERT INTO `bunny` (`id`, `nombre`, `color`, `especialidad`, `descripcion`, `precio`, `estado`) VALUES
(1, 'Hina Bunny', 'Rosa', 'Preparacion alimentos y decoracion ,Bienvenida', 'Maid dulce y delicada, siempre sonriente y experta en detalles kawaii.\r\nPersonalidad : es tímida y cariñosa \r\n ', 125, 'disponible'),
(2, 'Shion Bunny', 'Lila', ' emplatado,control de calidad ,atención de mesas', 'Elegante y perfeccionista, cuida cada detalle en la presentación\r\nPersonalidad: tranquila y refinada', 135, 'disponible'),
(3, 'Nami Bunny', 'Aqua', 'preparación de bebidas,smoothies ,entretenimiento', 'Descripción: Alegre y energética, especialista en bebidas y ambiente divertido\r\nPersonalidad: extrovertida y divertida', 110, 'disponible'),
(4, 'Yoru Bunny', 'Negro', ' atención de mesas ,supervisión /,caja', 'Descripción: Misteriosa y elegante, mantiene el orden y supervisa el servicio \r\nPersonalidad: seria y sofisticada', 120, 'disponible'),
(5, 'Koharu Bunny', 'Amarillo', 'bienvenida , juegos con clientes , entretenimiento', 'Descripción: Brillante y adorable, siempre animando con juegos y energía \r\nPersonalidad: alegre y juguetona', 120, 'disponible'),
(6, 'Nao Bunny', 'Blanco', ' caja ,toma de pedidos ,organización', 'Descripción: Organizada y eficiente, asegura que todo funcione perfecto \r\nPersonalidad: seria pero amable', 130, 'disponible');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu_bunny`
--

CREATE TABLE `menu_bunny` (
  `id` int NOT NULL,
  `nombre` varchar(100) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `categoria` varchar(50) COLLATE utf8mb3_spanish_ci DEFAULT NULL,
  `precio` decimal(10,0) DEFAULT NULL,
  `imagen` varchar(255) COLLATE utf8mb3_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

--
-- Volcado de datos para la tabla `menu_bunny`
--

INSERT INTO `menu_bunny` (`id`, `nombre`, `categoria`, `precio`, `imagen`) VALUES
(2, 'Pancakes Bunny Clásico ', 'PANCAKES', 80, NULL),
(3, 'Pancakes Rosa Delicado ', 'PANCAKES', 85, NULL),
(4, 'Pancakes Bunny Arándano', 'PANCAKES', 90, NULL),
(5, 'Pancakes Bunny Chocolate', 'PANCAKES', 95, NULL),
(6, 'Pancakes Bunny Matcha\r\n', 'PANCAKES', 90, NULL),
(7, 'Desayuno Bunny Completo', 'COMIDAS COMPLETAS', 120, NULL),
(8, 'Tostada Bunny Aguacate ', 'COMIDAS COMPLETAS', 95, NULL),
(9, 'Mini Burgers Bunny ', 'COMIDAS COMPLETAS', 110, NULL),
(10, 'Brunch Bunny', 'COMIDAS COMPLETAS', 130, NULL),
(11, 'Ensalada Cute Bunny ', 'COMIDAS COMPLETAS', 85, NULL),
(12, 'Sopa Cute Bunny ', 'COMIDAS COMPLETAS', 75, NULL),
(13, 'Parfait Bunny Dreams', 'POSTRES', 70, NULL),
(14, 'Pastelitos Bunny ', 'POSTRES', 65, NULL),
(15, 'Cupcakes Bunny Gemelos', 'POSTRES', 75, NULL),
(16, 'Tartaleta de Frutas Bunny', 'POSTRES', 80, NULL),
(17, 'Donas Bunny Glasé ', 'POSTRES', 60, NULL),
(18, 'Gelato Bunny', 'POSTRES', 70, NULL),
(20, 'Soda Bubble Mint ', 'BEBIDAS', 50, NULL),
(21, 'Soda Bubble Berries ', 'BEBIDAS', 55, NULL),
(22, 'Chocolate Bunny Caliente', 'BEBIDAS', 60, NULL),
(23, 'Latte Arte Bunny', 'BEBIDAS', 65, NULL),
(24, 'Smoothie Bunny Melón', 'BEBIDAS', 60, NULL),
(25, 'Café Frío Bunny', 'BEBIDAS', 55, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `nombre` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `correo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `clave` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `perfil` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL DEFAULT 'U'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
