-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: app_conexion
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `conexion_red`
--

DROP TABLE IF EXISTS `conexion_red`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conexion_red` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` int DEFAULT NULL,
  `nombre_red` varchar(45) DEFAULT NULL,
  `tipo_cifrado` varchar(45) DEFAULT NULL,
  `usuario` varchar(45) DEFAULT NULL,
  `contrasenia_conexion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conexion_red`
--

LOCK TABLES `conexion_red` WRITE;
/*!40000 ALTER TABLE `conexion_red` DISABLE KEYS */;
INSERT INTO `conexion_red` VALUES (18,2,'ElverRed','WEP','Komodo','1234');
/*!40000 ALTER TABLE `conexion_red` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dispositivo_electronico`
--

DROP TABLE IF EXISTS `dispositivo_electronico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dispositivo_electronico` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mac` varchar(45) DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `estado_conexion` tinyint DEFAULT NULL,
  `conexion` int DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conexionRedFkDispositivo_idx` (`conexion`),
  CONSTRAINT `conexionRedFkDispositivo` FOREIGN KEY (`conexion`) REFERENCES `conexion_red` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dispositivo_electronico`
--

LOCK TABLES `dispositivo_electronico` WRITE;
/*!40000 ALTER TABLE `dispositivo_electronico` DISABLE KEYS */;
INSERT INTO `dispositivo_electronico` VALUES (55,'1.111.111','PC',1,18,'1.222.222.223'),(56,'1.333','Tablet',1,18,'11111');
/*!40000 ALTER TABLE `dispositivo_electronico` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insertHistorial` AFTER INSERT ON `dispositivo_electronico` FOR EACH ROW INSERT INTO historico_dispositivo
(id,mac,tipo,fecha_creacion,ip,nombre_red,tipo_cifrado,usuario,motivo)
VALUES(null,NEW.mac,NEW.tipo,now(),NEW.ip,(select nombre_red from conexion_red where id = NEW.conexion),(select tipo_cifrado from conexion_red where id = NEW.conexion),(select usuario from conexion_red where id = NEW.conexion),'Insert') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insertHistorialConexiones` AFTER INSERT ON `dispositivo_electronico` FOR EACH ROW INSERT INTO historico_conexiones
(id,tipo,nombre_red,tipo_cifrado,usuario,mac,ip,tipo_dispositivo,motivo,red,fecha_creacion)
VALUES(
null,
(select tipo from conexion_red where id = NEW.conexion),
(select nombre_red from conexion_red where id = NEW.conexion),
(select tipo_cifrado from conexion_red where id = NEW.conexion),
(select usuario from conexion_red where id = NEW.conexion),
NEW.mac,
NEW.ip,
NEW.tipo,
'Insert',
(select id from conexion_red where id = NEW.conexion),
now()
) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `updateDispositivoHistorico` BEFORE UPDATE ON `dispositivo_electronico` FOR EACH ROW INSERT INTO historico_dispositivo
(id,mac,tipo,fecha_creacion,ip,nombre_red,tipo_cifrado,usuario,motivo)
VALUES(null,OLD.mac,NEW.tipo,now(),NEW.ip,(select nombre_red from conexion_red where id = NEW.conexion),(select tipo_cifrado from conexion_red where id = NEW.conexion),(select usuario from conexion_red where id = NEW.conexion),'Update') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `historico_conexiones`
--

DROP TABLE IF EXISTS `historico_conexiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_conexiones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` int DEFAULT NULL,
  `nombre_red` varchar(45) DEFAULT NULL,
  `tipo_cifrado` varchar(45) DEFAULT NULL,
  `usuario` varchar(45) DEFAULT NULL,
  `mac` varchar(45) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `tipo_dispositivo` varchar(45) DEFAULT NULL,
  `motivo` varchar(45) DEFAULT NULL,
  `red` int DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_conexiones`
--

LOCK TABLES `historico_conexiones` WRITE;
/*!40000 ALTER TABLE `historico_conexiones` DISABLE KEYS */;
INSERT INTO `historico_conexiones` VALUES (2,2,'ElverRed','WEP','Komodo','1.111.111','1.222.222.223','PC','Insert',18,'2021-08-22 20:55:52'),(3,2,'ElverRed','WEP','Komodo','1.333','11111','Tablet','Insert',18,'2021-08-22 20:56:21');
/*!40000 ALTER TABLE `historico_conexiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_dispositivo`
--

DROP TABLE IF EXISTS `historico_dispositivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_dispositivo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mac` varchar(45) DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `nombre_red` varchar(45) DEFAULT NULL,
  `tipo_cifrado` varchar(45) DEFAULT NULL,
  `usuario` varchar(45) DEFAULT NULL,
  `motivo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_dispositivo`
--

LOCK TABLES `historico_dispositivo` WRITE;
/*!40000 ALTER TABLE `historico_dispositivo` DISABLE KEYS */;
INSERT INTO `historico_dispositivo` VALUES (56,'1.111.111','PC','2021-08-22 20:55:52','1.222.222.223','ElverRed','WEP','Komodo','Insert'),(57,'1.333','Tablet','2021-08-22 20:56:21','11111','ElverRed','WEP','Komodo','Insert');
/*!40000 ALTER TABLE `historico_dispositivo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-22 16:23:00
