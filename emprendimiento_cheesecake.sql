-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3307
-- Tiempo de generación: 02-09-2026 a las 16:33:51
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `emprendimiento_cheesecake`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cheesecakes_personalizados`
--

CREATE TABLE `cheesecakes_personalizados` (
  `id_cheesecake` int(11) NOT NULL,
  `id_sabor` int(11) NOT NULL,
  `id_tamano` int(11) NOT NULL,
  `mensaje` varchar(200) DEFAULT NULL,
  `precio_total` decimal(10,2) NOT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cheesecake_extras`
--

CREATE TABLE `cheesecake_extras` (
  `id_cheesecake` int(11) NOT NULL,
  `id_extra` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cheesecake_toppings`
--

CREATE TABLE `cheesecake_toppings` (
  `id_cheesecake` int(11) NOT NULL,
  `id_topping` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 1
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `estado` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_internos`
--

CREATE TABLE `clientes_internos` (
  `id_interno` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `documento` varchar(30) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `id_rol` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `estado` tinyint(1) DEFAULT 1,
  `fecha_ingreso` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `id_detalle` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_cheesecake` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devoluciones`
--

CREATE TABLE `devoluciones` (
  `id_devolucion` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_interno` int(11) DEFAULT NULL,
  `fecha_devolucion` datetime DEFAULT current_timestamp(),
  `motivo` varchar(500) NOT NULL,
  `tipo` enum('Devolucion total','Devolucion parcial') NOT NULL,
  `monto_devuelto` decimal(10,2) NOT NULL,
  `estado` enum('Solicitada','Aprobada','Rechazada','Procesada') DEFAULT 'Solicitada',
  `observaciones` varchar(500) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `errores_pedido`
--

CREATE TABLE `errores_pedido` (
  `id_error` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_tipo_error` int(11) NOT NULL,
  `id_interno` int(11) DEFAULT NULL,
  `descripcion` varchar(500) NOT NULL,
  `fecha_error` datetime DEFAULT current_timestamp(),
  `estado` enum('Reportado','En revision','Solucionado','Cerrado') DEFAULT 'Reportado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `extras`
--

CREATE TABLE `extras` (
  `id_extra` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `disponible` tinyint(1) DEFAULT 1
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingredientes`
--

CREATE TABLE `ingredientes` (
  `id_ingrediente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `unidad_medida` enum('Unidad','Gramos','Kilogramos','Mililitros','Litros') NOT NULL,
  `cantidad_stock` decimal(10,2) NOT NULL DEFAULT 0.00,
  `stock_minimo` decimal(10,2) NOT NULL DEFAULT 0.00,
  `precio_compra` decimal(10,2) NOT NULL DEFAULT 0.00,
  `disponible` tinyint(1) DEFAULT 1
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_inventario`
--

CREATE TABLE `movimientos_inventario` (
  `id_movimiento` int(11) NOT NULL,
  `id_ingrediente` int(11) NOT NULL,
  `id_interno` int(11) DEFAULT NULL,
  `tipo` enum('Entrada','Salida','Ajuste') NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `motivo` varchar(300) DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_interno` int(11) DEFAULT NULL,
  `fecha_pedido` datetime DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `estado` enum('Pendiente','Confirmado','En preparacion','Listo','Entregado','Cancelado','Devuelto') DEFAULT 'Pendiente',
  `metodo_pago` enum('Efectivo','Nequi','Daviplata','Tarjeta','Transferencia') NOT NULL,
  `observaciones` varchar(300) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sabores`
--

CREATE TABLE `sabores` (
  `id_sabor` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `disponible` tinyint(1) DEFAULT 1
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tamaños`
--

CREATE TABLE `tamaños` (
  `id_tamano` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_error`
--

CREATE TABLE `tipos_error` (
  `id_tipo_error` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `toppings`
--

CREATE TABLE `toppings` (
  `id_topping` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `disponible` tinyint(1) DEFAULT 1
) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cheesecakes_personalizados`
--
ALTER TABLE `cheesecakes_personalizados`
  ADD PRIMARY KEY (`id_cheesecake`),
  ADD KEY `fk_cheesecake_sabor` (`id_sabor`),
  ADD KEY `fk_cheesecake_tamano` (`id_tamano`);

--
-- Indices de la tabla `cheesecake_extras`
--
ALTER TABLE `cheesecake_extras`
  ADD PRIMARY KEY (`id_cheesecake`,`id_extra`),
  ADD KEY `fk_ce_extra` (`id_extra`);

--
-- Indices de la tabla `cheesecake_toppings`
--
ALTER TABLE `cheesecake_toppings`
  ADD PRIMARY KEY (`id_cheesecake`,`id_topping`),
  ADD KEY `fk_ct_topping` (`id_topping`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `clientes_internos`
--
ALTER TABLE `clientes_internos`
  ADD PRIMARY KEY (`id_interno`),
  ADD UNIQUE KEY `documento` (`documento`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `fk_interno_rol` (`id_rol`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id_detalle`),
  ADD KEY `fk_detalle_pedido` (`id_pedido`),
  ADD KEY `fk_detalle_cheesecake` (`id_cheesecake`);

--
-- Indices de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD PRIMARY KEY (`id_devolucion`),
  ADD KEY `fk_devolucion_pedido` (`id_pedido`),
  ADD KEY `fk_devolucion_interno` (`id_interno`);

--
-- Indices de la tabla `errores_pedido`
--
ALTER TABLE `errores_pedido`
  ADD PRIMARY KEY (`id_error`),
  ADD KEY `fk_error_pedido` (`id_pedido`),
  ADD KEY `fk_error_tipo` (`id_tipo_error`),
  ADD KEY `fk_error_interno` (`id_interno`);

--
-- Indices de la tabla `extras`
--
ALTER TABLE `extras`
  ADD PRIMARY KEY (`id_extra`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `ingredientes`
--
ALTER TABLE `ingredientes`
  ADD PRIMARY KEY (`id_ingrediente`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `fk_movimiento_ingrediente` (`id_ingrediente`),
  ADD KEY `fk_movimiento_interno` (`id_interno`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `fk_pedido_cliente` (`id_cliente`),
  ADD KEY `fk_pedido_interno` (`id_interno`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `sabores`
--
ALTER TABLE `sabores`
  ADD PRIMARY KEY (`id_sabor`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `tamaños`
--
ALTER TABLE `tamaños`
  ADD PRIMARY KEY (`id_tamano`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `tipos_error`
--
ALTER TABLE `tipos_error`
  ADD PRIMARY KEY (`id_tipo_error`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `toppings`
--
ALTER TABLE `toppings`
  ADD PRIMARY KEY (`id_topping`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cheesecakes_personalizados`
--
ALTER TABLE `cheesecakes_personalizados`
  MODIFY `id_cheesecake` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clientes_internos`
--
ALTER TABLE `clientes_internos`
  MODIFY `id_interno` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `id_detalle` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  MODIFY `id_devolucion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `errores_pedido`
--
ALTER TABLE `errores_pedido`
  MODIFY `id_error` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `extras`
--
ALTER TABLE `extras`
  MODIFY `id_extra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ingredientes`
--
ALTER TABLE `ingredientes`
  MODIFY `id_ingrediente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sabores`
--
ALTER TABLE `sabores`
  MODIFY `id_sabor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tamaños`
--
ALTER TABLE `tamaños`
  MODIFY `id_tamano` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipos_error`
--
ALTER TABLE `tipos_error`
  MODIFY `id_tipo_error` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `toppings`
--
ALTER TABLE `toppings`
  MODIFY `id_topping` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cheesecakes_personalizados`
--
ALTER TABLE `cheesecakes_personalizados`
  ADD CONSTRAINT `fk_cheesecake_sabor` FOREIGN KEY (`id_sabor`) REFERENCES `sabores` (`id_sabor`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cheesecake_tamano` FOREIGN KEY (`id_tamano`) REFERENCES `tamaños` (`id_tamano`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `cheesecake_extras`
--
ALTER TABLE `cheesecake_extras`
  ADD CONSTRAINT `fk_ce_cheesecake` FOREIGN KEY (`id_cheesecake`) REFERENCES `cheesecakes_personalizados` (`id_cheesecake`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ce_extra` FOREIGN KEY (`id_extra`) REFERENCES `extras` (`id_extra`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `cheesecake_toppings`
--
ALTER TABLE `cheesecake_toppings`
  ADD CONSTRAINT `fk_ct_cheesecake` FOREIGN KEY (`id_cheesecake`) REFERENCES `cheesecakes_personalizados` (`id_cheesecake`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ct_topping` FOREIGN KEY (`id_topping`) REFERENCES `toppings` (`id_topping`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `clientes_internos`
--
ALTER TABLE `clientes_internos`
  ADD CONSTRAINT `fk_interno_rol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `fk_detalle_cheesecake` FOREIGN KEY (`id_cheesecake`) REFERENCES `cheesecakes_personalizados` (`id_cheesecake`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detalle_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `devoluciones`
--
ALTER TABLE `devoluciones`
  ADD CONSTRAINT `fk_devolucion_interno` FOREIGN KEY (`id_interno`) REFERENCES `clientes_internos` (`id_interno`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_devolucion_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `errores_pedido`
--
ALTER TABLE `errores_pedido`
  ADD CONSTRAINT `fk_error_interno` FOREIGN KEY (`id_interno`) REFERENCES `clientes_internos` (`id_interno`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_error_pedido` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_error_tipo` FOREIGN KEY (`id_tipo_error`) REFERENCES `tipos_error` (`id_tipo_error`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `movimientos_inventario`
--
ALTER TABLE `movimientos_inventario`
  ADD CONSTRAINT `fk_movimiento_ingrediente` FOREIGN KEY (`id_ingrediente`) REFERENCES `ingredientes` (`id_ingrediente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_movimiento_interno` FOREIGN KEY (`id_interno`) REFERENCES `clientes_internos` (`id_interno`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `fk_pedido_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pedido_interno` FOREIGN KEY (`id_interno`) REFERENCES `clientes_internos` (`id_interno`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
