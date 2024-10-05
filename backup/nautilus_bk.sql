-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nautilus
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CLIENTE`
--

DROP TABLE IF EXISTS `CLIENTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENTE` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `dni` varchar(11) DEFAULT NULL,
  `cuenta` varchar(200) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='INFORMACION BASICA DEL CLIENTE';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENTE`
--

LOCK TABLES `CLIENTE` WRITE;
/*!40000 ALTER TABLE `CLIENTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TALLER`
--

DROP TABLE IF EXISTS `TALLER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TALLER` (
  `id_taller` int NOT NULL AUTO_INCREMENT,
  `cuit` varchar(13) DEFAULT NULL,
  `tipo_reparacion` varchar(200) DEFAULT NULL,
  `comentarios_de_reparacion` text,
  PRIMARY KEY (`id_taller`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TALLER`
--

LOCK TABLES `TALLER` WRITE;
/*!40000 ALTER TABLE `TALLER` DISABLE KEYS */;
/*!40000 ALTER TABLE `TALLER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TALLER_VEHICULO`
--

DROP TABLE IF EXISTS `TALLER_VEHICULO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TALLER_VEHICULO` (
  `id_repacion` int NOT NULL AUTO_INCREMENT,
  `id_taller` int DEFAULT NULL,
  `id_vehiculo` int DEFAULT NULL,
  `fecha_reparacion` datetime DEFAULT (now()),
  PRIMARY KEY (`id_repacion`),
  KEY `fk_taller_vehiculo` (`id_vehiculo`),
  KEY `fk_taller_taller` (`id_taller`),
  CONSTRAINT `fk_taller_taller` FOREIGN KEY (`id_taller`) REFERENCES `TALLER` (`id_taller`),
  CONSTRAINT `fk_taller_vehiculo` FOREIGN KEY (`id_vehiculo`) REFERENCES `VEHICULO` (`id_vehiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TALLER_VEHICULO`
--

LOCK TABLES `TALLER_VEHICULO` WRITE;
/*!40000 ALTER TABLE `TALLER_VEHICULO` DISABLE KEYS */;
/*!40000 ALTER TABLE `TALLER_VEHICULO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TASACION`
--

DROP TABLE IF EXISTS `TASACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TASACION` (
  `id_tasacion` int NOT NULL AUTO_INCREMENT,
  `fecha_tasacion` datetime DEFAULT (now()),
  `coste` decimal(12,2) DEFAULT NULL,
  `tasador` varchar(200) DEFAULT NULL,
  `id_vehiculo` int DEFAULT NULL,
  PRIMARY KEY (`id_tasacion`),
  KEY `fk_tasacion_vehiculo` (`id_vehiculo`),
  CONSTRAINT `fk_tasacion_vehiculo` FOREIGN KEY (`id_vehiculo`) REFERENCES `VEHICULO` (`id_vehiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TASACION`
--

LOCK TABLES `TASACION` WRITE;
/*!40000 ALTER TABLE `TASACION` DISABLE KEYS */;
/*!40000 ALTER TABLE `TASACION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TRANSACCION`
--

DROP TABLE IF EXISTS `TRANSACCION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TRANSACCION` (
  `id_transaccion` int NOT NULL AUTO_INCREMENT,
  `id_vehiculo` int DEFAULT NULL,
  `id_cliente` int DEFAULT NULL,
  `fecha` date DEFAULT (curdate()),
  `importe` decimal(12,2) DEFAULT '50000.00',
  PRIMARY KEY (`id_transaccion`),
  KEY `fk_trans_cliente` (`id_cliente`),
  KEY `fk_trans_vehiculo` (`id_vehiculo`),
  CONSTRAINT `fk_trans_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `CLIENTE` (`id_cliente`),
  CONSTRAINT `fk_trans_vehiculo` FOREIGN KEY (`id_vehiculo`) REFERENCES `VEHICULO` (`id_vehiculo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='TABLA LOGICA DEL NEGOCIO, VENTAS Y COMPRAS DE VEHICULOS';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TRANSACCION`
--

LOCK TABLES `TRANSACCION` WRITE;
/*!40000 ALTER TABLE `TRANSACCION` DISABLE KEYS */;
/*!40000 ALTER TABLE `TRANSACCION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VEHICULO`
--

DROP TABLE IF EXISTS `VEHICULO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VEHICULO` (
  `id_vehiculo` int NOT NULL AUTO_INCREMENT,
  `fecha_vehiculo` date DEFAULT NULL,
  `modelo` varchar(200) DEFAULT NULL,
  `tipo_vehiculo` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_vehiculo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VEHICULO`
--

LOCK TABLES `VEHICULO` WRITE;
/*!40000 ALTER TABLE `VEHICULO` DISABLE KEYS */;
INSERT INTO `VEHICULO` VALUES (1,'2015-05-10','Toyota Corolla','Automovil');
/*!40000 ALTER TABLE `VEHICULO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `riesgo_vehiculo_taller`
--

DROP TABLE IF EXISTS `riesgo_vehiculo_taller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `riesgo_vehiculo_taller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_vehiculo` int DEFAULT NULL,
  `dias_en_taller` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riesgo_vehiculo_taller`
--

LOCK TABLES `riesgo_vehiculo_taller` WRITE;
/*!40000 ALTER TABLE `riesgo_vehiculo_taller` DISABLE KEYS */;
/*!40000 ALTER TABLE `riesgo_vehiculo_taller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_costo_por_taller`
--

DROP TABLE IF EXISTS `vw_costo_por_taller`;
/*!50001 DROP VIEW IF EXISTS `vw_costo_por_taller`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_costo_por_taller` AS SELECT 
 1 AS `TALLER`,
 1 AS `periodo`,
 1 AS `COSTO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_transacciones_mes`
--

DROP TABLE IF EXISTS `vw_transacciones_mes`;
/*!50001 DROP VIEW IF EXISTS `vw_transacciones_mes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_transacciones_mes` AS SELECT 
 1 AS `ANIO`,
 1 AS `MES`,
 1 AS `TOTAL`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_costo_por_taller`
--

/*!50001 DROP VIEW IF EXISTS `vw_costo_por_taller`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_costo_por_taller` AS select `data_agrupada`.`taller` AS `TALLER`,concat_ws('-',year(`data_agrupada`.`fecha_reparacion`),month(`data_agrupada`.`fecha_reparacion`)) AS `periodo`,sum(`data_agrupada`.`costo_reparacion`) AS `COSTO` from (select `t`.`cuit` AS `taller`,`v`.`modelo` AS `modelo_vehiculo`,(case when (`v`.`tipo_vehiculo` like 'SUV') then 500 when (`v`.`tipo_vehiculo` like 'SEDAN') then 450 else 600 end) AS `costo_reparacion`,`tv`.`fecha_reparacion` AS `fecha_reparacion` from ((`TALLER_VEHICULO` `tv` join `TALLER` `t` on((`tv`.`id_taller` = `t`.`id_taller`))) join `VEHICULO` `v` on((`tv`.`id_vehiculo` = `v`.`id_vehiculo`)))) `data_agrupada` group by concat_ws('-',year(`data_agrupada`.`fecha_reparacion`),month(`data_agrupada`.`fecha_reparacion`)),`data_agrupada`.`taller` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_transacciones_mes`
--

/*!50001 DROP VIEW IF EXISTS `vw_transacciones_mes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_transacciones_mes` AS select year(`TRANSACCION`.`fecha`) AS `ANIO`,month(`TRANSACCION`.`fecha`) AS `MES`,sum(`TRANSACCION`.`importe`) AS `TOTAL` from `TRANSACCION` group by month(`TRANSACCION`.`fecha`),year(`TRANSACCION`.`fecha`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-05 15:41:17
