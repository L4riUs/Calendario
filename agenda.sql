-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-08-2024 a las 05:00:24
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `agenda`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `notificar_eventos` ()  BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE eventoId INT;
    DECLARE fechaVencimiento DATE;
    DECLARE evento VARCHAR(255);
    DECLARE diff INT;
    DECLARE cur CURSOR FOR 
        SELECT a.id, a.fechaVencimiento, a.evento
        FROM agenda a 
        WHERE a.estado = 1;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO eventoId, fechaVencimiento, evento;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET diff = dias_diferencia(CURDATE(), fechaVencimiento);

        CASE diff
            WHEN 30 THEN
                INSERT INTO notificaciones (id_usuario, status, mensaje, fecha)
                VALUES (1, 0, CONCAT('El evento nro°', eventoId, ' llamado ', evento, ' vence en 30 días.'), NOW());
            WHEN 15 THEN
                INSERT INTO notificaciones (id_usuario, status, mensaje, fecha)
                VALUES (1, 0, CONCAT('El evento nro°', eventoId, ' llamado ', evento, ' vence en 15 días.'), NOW());
            WHEN 7 THEN
                INSERT INTO notificaciones (id_usuario, status, mensaje, fecha)
                VALUES (1, 0, CONCAT('El evento nro°', eventoId, ' llamado ', evento, ' vence en 7 días.'), NOW());
            WHEN 0 THEN
                INSERT INTO notificaciones (id_usuario, status, mensaje, fecha)
                VALUES (1, 0, CONCAT('El evento nro°', eventoId, ' llamado ', evento, ' vence hoy.'), NOW());
            ELSE
                -- No se especifica ELSE ya que no queremos realizar ninguna acción adicional.
                SET diff = diff;  -- No-op
        END CASE;

    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agenda`
--

CREATE TABLE `agenda` (
  `id` int(11) NOT NULL,
  `fechaElaboracion` date NOT NULL,
  `evento` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `fechaVencimiento` datetime NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `agenda`
--
ALTER TABLE `agenda`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agenda`
--
ALTER TABLE `agenda`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
