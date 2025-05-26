-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-04-2025 a las 04:02:49
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
-- Base de datos: `market`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `categoria1` varchar(100) NOT NULL,
  `categoria2` varchar(200) NOT NULL,
  `categoria3` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `categoria1`, `categoria2`, `categoria3`) VALUES
(1, 'Moda deportiva', 'Moda sport', 'Moda casual'),
(2, 'Moda deportiva', 'Moda sport', 'Moda de alta costura'),
(3, 'Moda casual', 'Accesorios', 'Zapatos'),
(4, 'Moda de alta costura', 'Moda deportiva', 'Zapatos'),
(5, 'Zapatos', 'Moda sport', 'Accesorios'),
(6, 'Accesorios', 'Moda casual', 'Moda de alta costura'),
(7, 'Moda deportiva', 'Moda sport', 'Zapatos'),
(9, 'Moda casual', 'Accesorios', 'Moda deportiva'),
(10, 'Moda casual', 'Moda sport', 'Zapatos'),
(16, 'Accesorios', 'Moda casual', 'Moda de alta costura'),
(17, 'Moda deportiva', 'Accesorios', 'Moda sport'),
(18, 'Moda de alta costura', 'Moda casual', 'Zapatos'),
(19, 'Moda deportiva', 'Moda sport', 'Moda casual');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `id_estado` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`id_estado`, `estado`) VALUES
(1, 'Activo'),
(2, 'Vendido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagen`
--

CREATE TABLE `imagen` (
  `id_imagen` int(11) NOT NULL,
  `imagen1` varchar(50) NOT NULL,
  `imagen2` varchar(50) NOT NULL,
  `imagen3` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `imagen`
--

INSERT INTO `imagen` (`id_imagen`, `imagen1`, `imagen2`, `imagen3`) VALUES
(1, 'imagen1.png', 'imagen2.png', 'imagen3.png'),
(2, 'imagen1.png', 'imagen2.png', 'imagen3.png'),
(6, 'camara1.jpg', 'camara2.jpg', 'camara3.jpg'),
(7, 'feature_prod_01.jpg', 'feature_prod_02.jpg', 'feature_prod_03.jpg'),
(9, 'img1.jpg', 'img2.jpg', 'img3.jpg'),
(10, 'product_single_02.jpg', 'product_single_03.jpg', 'product_single_04.jpg'),
(18, 'accesorios.jpg', 'banner_img_02.jpg', 'category_img_01.jpg'),
(19, 'brand_02.png', 'brand_03.png', 'brand_04.png'),
(20, 'banersaco.png', 'bang.png', 'banner_img_01.jpg'),
(23, 'banersaco.png', 'bang.png', 'banner_img_01.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` double NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `id_estado` int(11) DEFAULT NULL,
  `id_vendedor` int(11) DEFAULT NULL,
  `id_img` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nombre`, `descripcion`, `precio`, `id_categoria`, `id_estado`, `id_vendedor`, `id_img`) VALUES
(1, 'Zapatillas Deportivas Nuevas editado', 'Zapatillas cómodas para correr editado', 125000, 1, 1, 10, 7),
(2, 'Camiseta Sport editado ', 'Camiseta transpirable para actividades al aire libre editado', 75000, 2, 1, 10, 7),
(3, 'Jeans Casual', 'Pantalón de mezclilla ideal para el día a día', 95000, 3, 1, 10, 7),
(4, 'Vestido de Gala', 'Vestido elegante para ocasiones especiales', 250000, 4, 2, 10, 7),
(5, 'Gorra Estilizada', 'Accesorio de moda para complementar tu outfit', 45000, 6, 2, 10, 7),
(6, 'Zapatillas Deportivas', 'Zapatillas cómodas para hacer ejercicio', 120000, 1, 1, 10, 7),
(15, 'accesorios', 'prueba accesorios', 12344, 16, 1, 10, 18),
(16, 'prueba nuevo ', 'prueba nuevo  ', 1234456, 17, 1, 9, 19),
(17, 'nuevo edit', 'nuevo edit ', 123456, 18, 1, 10, 20),
(18, 'prueba', 'dfgdfgfdgfd', 1235, 19, 1, 10, 23),
(19, 'PRUEBA', 'PRUENA', 123, 3, 1, 8, 2),
(20, 'Sudadera Térmica para Hombre', 'Esta sudadera térmica está diseñada para mantener el calor corporal en climas fríos. Hecha de algodón suave con interior afelpado, ofrece una sensación acogedora y transpirable. Su diseño moderno permite usarla tanto para deporte como para vestir casualmente. Cuenta con capucha ajustable, bolsillos laterales amplios y cierre frontal de alta resistencia.', 79.99, 1, 1, 8, 18),
(21, 'Zapatillas Urbanas FlexWave', 'Las zapatillas FlexWave están diseñadas para un estilo urbano moderno. Con una suela ultraligera y materiales transpirables, brindan confort en largas caminatas. El diseño de corte bajo y colores neutros las hace perfectas para cualquier atuendo. Además, cuentan con plantilla acolchada y suela antideslizante.', 64.9, 5, 1, 8, 19),
(22, 'Gorra Estilo Snapback Negra', 'Gorra clásica tipo snapback con visera plana y diseño minimalista en color negro. Confeccionada con materiales de alta calidad que garantizan durabilidad. Ideal para complementar tu estilo diario o usarla en actividades al aire libre. Ajuste trasero de broche para mayor comodidad.', 22.5, 6, 1, 8, 20),
(23, 'Blusa Casual Dama Manga 3/4', 'Blusa confeccionada en algodón suave con corte entallado. Diseño elegante y cómodo, ideal para el día a día o eventos casuales. Disponible en varios colores. La tela permite una excelente ventilación sin sacrificar estilo. Cuenta con botones decorativos y cuello redondo.', 35, 1, 1, 9, 18),
(24, 'Zapatos de Vestir Elegantes Hombre', 'Zapatos clásicos de vestir elaborados en cuero sintético con acabados premium. Plantilla interior acolchada, suela de goma resistente y diseño con costuras finas. Perfectos para oficina, reuniones formales o eventos sociales. Combinan bien con trajes o ropa semiformal.', 95.9, 5, 1, 9, 19),
(25, 'Reloj Pulsera Acero Inoxidable', 'Reloj elegante para hombre con correa de acero inoxidable y diseño minimalista. Movimiento de cuarzo, resistente al agua, ideal para el uso diario. Incluye caja elegante para regalo. La carátula es de cristal templado con números metálicos en bajo relieve.', 49.99, 6, 1, 9, 20),
(26, 'Chaqueta Corta Mujer Invierno', 'Chaqueta corta ideal para climas fríos, con forro interno térmico. Diseño moderno con cuello alto y cierre frontal de alta calidad. Fabricada en materiales resistentes al agua. Perfecta para combinar con jeans o pantalones casuales.', 84, 1, 1, 10, 18),
(27, 'Botines Mujer Cuero Sintético', 'Botines de tacón bajo con diseño elegante. Fabricados en cuero sintético resistente, con cremallera lateral y suela antideslizante. Ideales para invierno o media estación. Cómodos para caminar largas distancias sin perder estilo.', 69.99, 5, 1, 10, 19),
(28, 'Set Collares Capas Mujer', 'Conjunto de tres collares en capas, chapados en oro. Cada uno tiene un dije distinto: luna, estrella y corazón. Perfectos para usar juntos o por separado. No se oxidan fácilmente, hipoalergénicos. Vienen en caja decorativa para regalo.', 28.75, 6, 1, 10, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `rol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `rol`) VALUES
(0, 'usuario'),
(1, 'administrador');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo tienda`
--

CREATE TABLE `tipo tienda` (
  `id_tipo` int(11) NOT NULL,
  `nombre_tipo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo tienda`
--

INSERT INTO `tipo tienda` (`id_tipo`, `nombre_tipo`) VALUES
(1, 'Persona Natural'),
(2, 'Tienda');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` varchar(100) NOT NULL,
  `id_rol` int(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `email`, `password`, `token`, `id_rol`) VALUES
(5, 'prueba@gmail.com', '$2y$10$aYi.QfIWxr7oVURFA20BLumxB3Q4UVivEBC5OZAbuTTHnuYBU9ORC', '', 0),
(7, 'admin@gmail.com', '$2y$10$Scn13z.ut9JvVlVtkK0fs.rdD9Is64dL2UxWKnfGSr/UotQI0O25.', '', 1),
(8, 'pamela@gmail.com', '$2y$10$ozq0VGxwrj5FI1kp1bZAX.6Qr09do7hulmblLjwlyjW.RHjwaAVoK', '', 0),
(35, 'hooli@prueba.com', '$2y$10$JRxJdgwmlHJAyu9IvxQZqex148HiXctddMqzjqeUtnD/vAZs6HgWS', '', 0),
(36, 'tdarodriguez@especialito.com', '$2y$10$56ZaosTJDSyZIcyfMb5XAu9mHvGjRrw0Y8FgUYdT/I5u16dv7AWK6', '', 0),
(37, 'pruba123@gmail.com', '$2y$10$8Y/gWwcmbyYIKWrEuKGr5.A0Rz/DM1e2o9hKtRtjWgU6krAlT04da', '', 0),
(38, 'prueba4321@gmail.com', '$2y$10$5IUlqLukfGDAGVhRNDbugOpPjZxHWQiBNSS.F4T9Us0.6P16XreRy', '', 0),
(39, 'tdarodriguezprueba@especialito.com', '$2y$10$RZF65YQV434La89ByjCvbeE/ot9R0fr3TgGV68yB12JcGZihglMHq', '', 0),
(40, 'jcvm2001valencia@gmail.com', '$2y$10$UTA/sshZocvfg7t5PiNaBu9g2Xv1H6iTkCoyHuvAQvflV184L3Kk2', '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedor`
--

CREATE TABLE `vendedor` (
  `id_vendedor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `id_usu` int(200) NOT NULL,
  `id_tipotienda` int(11) NOT NULL,
  `imagen` varchar(100) NOT NULL,
  `ubicacion` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vendedor`
--

INSERT INTO `vendedor` (`id_vendedor`, `nombre`, `descripcion`, `telefono`, `id_usu`, `id_tipotienda`, `imagen`, `ubicacion`) VALUES
(8, 'prueba', 'Descripción de la tienda', '3218666530', 36, 2, 'logobu.webp', 'W8V8+R7 Suárez, Cauca, Colombia'),
(9, 'prueba zapatos', 'Descripción de la tienda', '3218666530', 37, 1, 'logobu.webp', 'X8HM+G5, Buenos Aires, Cauca, Colombia'),
(10, 'prueba', 'Descripción de la tienda', '3218666530', 38, 1, 'logobu.webp', 'Cra. 8ª # 3-9, Suarez, Suárez, Cauca, Colombia');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `imagen`
--
ALTER TABLE `imagen`
  ADD PRIMARY KEY (`id_imagen`),
  ADD UNIQUE KEY `id_imagen` (`id_imagen`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `id_vendedor` (`id_vendedor`),
  ADD KEY `producto_ibfk_img` (`id_img`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `tipo tienda`
--
ALTER TABLE `tipo tienda`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`id_vendedor`),
  ADD UNIQUE KEY `id_usu` (`id_usu`),
  ADD KEY `id_tipotienda` (`id_tipotienda`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `imagen`
--
ALTER TABLE `imagen`
  MODIFY `id_imagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `tipo tienda`
--
ALTER TABLE `tipo tienda`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `vendedor`
--
ALTER TABLE `vendedor`
  MODIFY `id_vendedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE CASCADE,
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id_estado`) ON DELETE CASCADE,
  ADD CONSTRAINT `producto_ibfk_3` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedor` (`id_vendedor`) ON DELETE CASCADE,
  ADD CONSTRAINT `producto_ibfk_img` FOREIGN KEY (`id_img`) REFERENCES `imagen` (`id_imagen`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`);

--
-- Filtros para la tabla `vendedor`
--
ALTER TABLE `vendedor`
  ADD CONSTRAINT `vendedor_ibfk_2` FOREIGN KEY (`id_usu`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `vendedor_ibfk_3` FOREIGN KEY (`id_tipotienda`) REFERENCES `tipo tienda` (`id_tipo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
