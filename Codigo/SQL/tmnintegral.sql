-- phpMyAdmin SQL Dump
-- version 4.0.10.10
-- http://www.phpmyadmin.net
--
-- Servidor: 127.3.223.130:3306
-- Tiempo de generación: 27-08-2015 a las 15:43:13
-- Versión del servidor: 5.5.45
-- Versión de PHP: 5.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `tmnintegral`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `COMMANDS`
--

CREATE TABLE IF NOT EXISTS `COMMANDS` (
  `id_command` int(11) NOT NULL,
  `command` varchar(120) NOT NULL,
  `command_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id_command`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `COMMAND_DEVICETYPE`
--

CREATE TABLE IF NOT EXISTS `COMMAND_DEVICETYPE` (
  `id_command` int(11) NOT NULL,
  `id_device_type` int(11) NOT NULL,
  PRIMARY KEY (`id_command`,`id_device_type`),
  KEY `FK_COMMAND` (`id_command`),
  KEY `FK_DEVICETYPE` (`id_device_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `CONFIGURATION`
--

CREATE TABLE IF NOT EXISTS `CONFIGURATION` (
  `id_configuration` int(11) NOT NULL,
  `file_name` varchar(80) NOT NULL,
  `content` varchar(80) NOT NULL,
  `id_version` int(11) NOT NULL,
  PRIMARY KEY (`id_configuration`),
  KEY `FK_VERSION` (`id_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DEVICE`
--

CREATE TABLE IF NOT EXISTS `DEVICE` (
  `device_id` int(11) NOT NULL,
  `communityRead` varchar(10) NOT NULL,
  `hostName` varchar(50) NOT NULL,
  `iosType` varchar(50) NOT NULL,
  `iosVersion` varchar(50) NOT NULL,
  `ip` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  `serialNumber` int(11) NOT NULL,
  `softwareRelease` varchar(50) NOT NULL,
  `id_device_type` int(11) NOT NULL,
  `id_network` int(11) NOT NULL,
  `id_configuration` int(11) NOT NULL,
  `id_equipment_info` int(11) NOT NULL,
  `id_interface` int(11) NOT NULL,
  PRIMARY KEY (`device_id`),
  KEY `FK_EQINFO` (`id_equipment_info`),
  KEY `FK_INTERFACE` (`id_interface`),
  KEY `FK_DEVICE_TYPE` (`id_device_type`),
  KEY `PK_NETWORK` (`id_network`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DEVICE_TYPE`
--

CREATE TABLE IF NOT EXISTS `DEVICE_TYPE` (
  `id_device_typ` int(11) NOT NULL,
  `default_comm_read` varchar(50) NOT NULL,
  `default_snmp_version` varchar(50) NOT NULL,
  `driver` varchar(50) NOT NULL,
  `technology` varchar(50) NOT NULL,
  `vendor` varchar(50) NOT NULL,
  PRIMARY KEY (`id_device_typ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `EQUIPMENT_INFORMATION`
--

CREATE TABLE IF NOT EXISTS `EQUIPMENT_INFORMATION` (
  `equipment_id` int(11) NOT NULL,
  `memoria_disponible` int(11) NOT NULL,
  `memoria_utilizada` int(11) NOT NULL,
  `timestamp` date NOT NULL,
  `trafico_entrante` int(11) NOT NULL,
  `trafico_saliente` int(11) NOT NULL,
  `utilizacion_cpu` int(11) NOT NULL,
  PRIMARY KEY (`equipment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `INTERFACE`
--

CREATE TABLE IF NOT EXISTS `INTERFACE` (
  `interface_id` int(11) NOT NULL,
  `admin_status` varchar(50) NOT NULL,
  `alias` varchar(50) NOT NULL,
  `location_port` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `port` int(11) NOT NULL,
  `rack` varchar(50) NOT NULL,
  `shelf` varchar(50) NOT NULL,
  `subport` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`interface_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `NETWORK`
--

CREATE TABLE IF NOT EXISTS `NETWORK` (
  `id_network` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `description` varchar(50) NOT NULL,
  PRIMARY KEY (`id_network`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ROLE`
--

CREATE TABLE IF NOT EXISTS `ROLE` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(15) NOT NULL,
  `allow_create` tinyint(1) NOT NULL,
  `allow_delete` tinyint(1) NOT NULL,
  `allow_update` tinyint(1) NOT NULL,
  `allow_reports` int(11) NOT NULL,
  PRIMARY KEY (`role_id`) COMMENT 'Role primary key'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ROLE`
--

INSERT INTO `ROLE` (`role_id`, `role_name`, `allow_create`, `allow_delete`, `allow_update`, `allow_reports`) VALUES
(1, 'ADMIN', 0, 0, 0, 0),
(2, 'USER', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `USER`
--

CREATE TABLE IF NOT EXISTS `USER` (
  `user_id` varchar(10) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(40) NOT NULL,
  `name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `role` int(11) NOT NULL,
  PRIMARY KEY (`user_id`) COMMENT 'Primary Key for user table',
  KEY `FK_UserRole` (`role`) COMMENT 'Foreing key for user role'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `VERSION`
--

CREATE TABLE IF NOT EXISTS `VERSION` (
  `id_version` int(11) NOT NULL,
  `version` bigint(20) NOT NULL,
  PRIMARY KEY (`id_version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `COMMAND_DEVICETYPE`
--
ALTER TABLE `COMMAND_DEVICETYPE`
  ADD CONSTRAINT `COMMAND_DEVICETYPE_ibfk_2` FOREIGN KEY (`id_device_type`) REFERENCES `DEVICE_TYPE` (`id_device_typ`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `COMMAND_DEVICETYPE_ibfk_1` FOREIGN KEY (`id_command`) REFERENCES `COMMANDS` (`id_command`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `CONFIGURATION`
--
ALTER TABLE `CONFIGURATION`
  ADD CONSTRAINT `CONFIGURATION_ibfk_1` FOREIGN KEY (`id_version`) REFERENCES `VERSION` (`id_version`);

--
-- Filtros para la tabla `DEVICE`
--
ALTER TABLE `DEVICE`
  ADD CONSTRAINT `DEVICE_ibfk_3` FOREIGN KEY (`id_network`) REFERENCES `NETWORK` (`id_network`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `DEVICE_ibfk_1` FOREIGN KEY (`id_device_type`) REFERENCES `DEVICE_TYPE` (`id_device_typ`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `DEVICE_ibfk_2` FOREIGN KEY (`id_interface`) REFERENCES `INTERFACE` (`interface_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `FK_EQINFO` FOREIGN KEY (`id_equipment_info`) REFERENCES `EQUIPMENT_INFORMATION` (`equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `USER`
--
ALTER TABLE `USER`
  ADD CONSTRAINT `USER_ibfk_1` FOREIGN KEY (`role`) REFERENCES `ROLE` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
