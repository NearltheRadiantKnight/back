-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: manager
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `date_config`
--

DROP TABLE IF EXISTS `date_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `date_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `config_key` varchar(50) NOT NULL,
  `config_value` date NOT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_config_key` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_config`
--

LOCK TABLES `date_config` WRITE;
/*!40000 ALTER TABLE `date_config` DISABLE KEYS */;
INSERT INTO `date_config` VALUES (1,'defense_date','2026-01-05','2026-01-05 12:36:43'),(2,'evaluation_date','2026-01-05','2026-01-05 12:36:43');
/*!40000 ALTER TABLE `date_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbgroup`
--

DROP TABLE IF EXISTS `dbgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dbgroup` (
  `id` int NOT NULL AUTO_INCREMENT,
  `year` int DEFAULT NULL,
  `admin_id` char(10) DEFAULT NULL,
  `max_student_count` int DEFAULT NULL,
  `adjustmentCoefficient` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_id` (`admin_id`),
  CONSTRAINT `dbgroup_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbgroup`
--

LOCK TABLES `dbgroup` WRITE;
/*!40000 ALTER TABLE `dbgroup` DISABLE KEYS */;
INSERT INTO `dbgroup` VALUES (1,2026,'100001',NULL,NULL);
/*!40000 ALTER TABLE `dbgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbinfo`
--

DROP TABLE IF EXISTS `dbinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dbinfo` (
  `gid` int DEFAULT NULL,
  `stu_id` char(10) DEFAULT NULL,
  `type` int DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `time` date DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `reviewer_id` char(10) DEFAULT NULL,
  `total_score` int DEFAULT '0',
  `comment` text,
  `graded_by` varchar(10) DEFAULT NULL,
  `teacher_scores` json DEFAULT NULL,
  UNIQUE KEY `uk_stu_gid` (`stu_id`,`gid`),
  KEY `reviewer_id` (`reviewer_id`),
  KEY `gid` (`gid`),
  CONSTRAINT `dbinfo_ibfk_1` FOREIGN KEY (`reviewer_id`) REFERENCES `user` (`id`),
  CONSTRAINT `dbinfo_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `dbgroup` (`id`),
  CONSTRAINT `dbinfo_ibfk_3` FOREIGN KEY (`stu_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbinfo`
--

LOCK TABLES `dbinfo` WRITE;
/*!40000 ALTER TABLE `dbinfo` DISABLE KEYS */;
INSERT INTO `dbinfo` VALUES (1,'2023001',1,'鍩轰簬springboot鐨勫湪绾挎暀鑲插钩鍙拌璁′笌瀹炵幇','2023-05-20','鏈瘯涓氳璁″熀浜巗pringboot妗嗘灦寮€鍙戜簡涓€涓湪绾挎暀鑲插钩鍙帮紝瀹炵幇浜嗚绋嬬鐞嗐€佸湪绾垮涔犮€佽€冭瘯绯荤粺绛夊姛鑳姐€?,'100002',86,NULL,'100001','[{\"design_qa1\": 13, \"design_qa2\": 13, \"teacher_id\": \"100002\", \"total_score\": 86, \"teacher_name\": \"鏉庤€佸笀\", \"design_quality1\": 13, \"design_quality2\": 13, \"design_quality3\": 13, \"design_presentation\": 22}, {\"design_qa1\": 13, \"design_qa2\": 13, \"teacher_id\": \"100003\", \"total_score\": 89, \"teacher_name\": \"鐜嬭€佸笀\", \"design_quality1\": 14, \"design_quality2\": 14, \"design_quality3\": 13, \"design_presentation\": 22}, {\"design_qa1\": 12, \"design_qa2\": 12, \"teacher_id\": \"100004\", \"total_score\": 84, \"teacher_name\": \"璧佃€佸笀\", \"design_quality1\": 13, \"design_quality2\": 13, \"design_quality3\": 12, \"design_presentation\": 22}]'),(1,'2023002',2,'浜哄伐鏅鸿兘鍦ㄦ櫤鑳藉鏈嶇郴缁熶腑鐨勫叧閿妧鏈爺绌朵笌搴旂敤','2023-05-20','鏈瘯涓氳鏂囩爺绌朵簡浜哄伐鏅鸿兘鎶€鏈湪鏅鸿兘瀹㈡湇绯荤粺涓殑搴旂敤锛岄噸鐐规帰璁ㄤ簡鑷劧璇█澶勭悊鍜屾満鍣ㄥ涔犵畻娉曘€?,'100002',98,NULL,'100001','[{\"teacher_id\": \"100002\", \"total_score\": 100, \"presentation\": 25, \"teacher_name\": \"鏉庤€佸笀\", \"paper_quality\": 45, \"qa_performance\": 30}, {\"teacher_id\": \"100003\", \"total_score\": 100, \"presentation\": 28, \"teacher_name\": \"鐜嬭€佸笀\", \"paper_quality\": 43, \"qa_performance\": 29}, {\"teacher_id\": \"100004\", \"total_score\": 93, \"presentation\": 25, \"teacher_name\": \"璧佃€佸笀\", \"paper_quality\": 40, \"qa_performance\": 28}]');
/*!40000 ALTER TABLE `dbinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_defense`
--

DROP TABLE IF EXISTS `group_defense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_defense` (
  `group_id` int NOT NULL,
  `stu_id` char(10) NOT NULL,
  `major_score` int DEFAULT NULL,
  PRIMARY KEY (`group_id`,`stu_id`),
  KEY `stu_id` (`stu_id`),
  CONSTRAINT `group_defense_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `dbgroup` (`id`),
  CONSTRAINT `group_defense_ibfk_2` FOREIGN KEY (`stu_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_defense`
--

LOCK TABLES `group_defense` WRITE;
/*!40000 ALTER TABLE `group_defense` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_defense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institute`
--

DROP TABLE IF EXISTS `institute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institute` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `user_id` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_institute` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institute`
--

LOCK TABLES `institute` WRITE;
/*!40000 ALTER TABLE `institute` DISABLE KEYS */;
INSERT INTO `institute` VALUES (1,'璁＄畻鏈轰笌淇℃伅瀛﹂櫌','inst'),(2,'鍦熸湪',NULL);
/*!40000 ALTER TABLE `institute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `placeholder_config`
--

DROP TABLE IF EXISTS `placeholder_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `placeholder_config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `template_type` int NOT NULL,
  `placeholder_key` varchar(100) NOT NULL,
  `placeholder_name` varchar(100) NOT NULL,
  `is_required` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_type_placeholder` (`template_type`,`placeholder_key`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `placeholder_config`
--

LOCK TABLES `placeholder_config` WRITE;
/*!40000 ALTER TABLE `placeholder_config` DISABLE KEYS */;
INSERT INTO `placeholder_config` VALUES (1,1,'{{student_name}}','瀛︾敓濮撳悕',1),(2,1,'{{student_id}}','瀛﹀彿',1),(3,1,'{{date_year}}','骞翠唤',1),(4,1,'{{date_month}}','鏈堜唤',1),(5,1,'{{date_day}}','鏃ユ湡',1),(6,1,'{{thesis_title}}','棰樼洰',1),(7,1,'{{design_quality_score1}}','璁捐璐ㄩ噺鍒?',1),(8,1,'{{design_quality_score2}}','璁捐璐ㄩ噺鍒?',1),(9,1,'{{design_quality_score3}}','璁捐璐ㄩ噺鍒?',1),(10,1,'{{defense_report_score}}','绛旇京鎶ュ憡鍒?,1),(11,1,'{{response_score1}}','鍥炵瓟闂鍒?',1),(12,1,'{{response_score2}}','鍥炵瓟闂鍒?',1),(13,1,'{{total_score}}','鎬绘垚缁?,1),(14,1,'{{signature_judge}}','璇勫绛惧悕',1),(15,2,'{{student_name}}','瀛︾敓濮撳悕',1),(16,2,'{{student_id}}','瀛﹀彿',1),(17,2,'{{date_year}}','骞翠唤',1),(18,2,'{{date_month}}','鏈堜唤',1),(19,2,'{{date_day}}','鏃ユ湡',1),(20,2,'{{thesis_title}}','棰樼洰',1),(21,2,'{{advisor_score}}','鎸囧鑰佸笀鎴愮哗',1),(22,2,'{{reviewer_score}}','璇勯槄浜烘垚缁?,1),(23,2,'{{defense_score}}','绛旇京鎴愮哗',1),(24,2,'{{advisor_calculated}}','鎸囧鑰佸笀鎴愮哗脳0.3',1),(25,2,'{{reviewer_calculated}}','璇勯槄浜烘垚缁┟?.3',1),(26,2,'{{defense_calculated}}','绛旇京鎴愮哗脳0.4',1),(27,2,'{{final_score}}','鏈€缁堟垚缁?,1),(28,2,'{{signature_department_head}}','绯讳富浠荤鍚?,1),(29,3,'{{student_name}}','瀛︾敓濮撳悕',1),(30,3,'{{student_id}}','瀛﹀彿',1),(31,3,'{{date_year}}','骞翠唤',1),(32,3,'{{date_month}}','鏈堜唤',1),(33,3,'{{date_day}}','鏃ユ湡',1),(34,3,'{{thesis_title}}','棰樼洰',1),(35,3,'{{paper_quality_score}}','璁烘枃璐ㄩ噺鍒?,1),(36,3,'{{defense_report_score}}','绛旇京鎶ュ憡鍒?,1),(37,3,'{{response_score}}','鍥炵瓟闂鍒?,1),(38,3,'{{total_score}}','鎬绘垚缁?,1),(39,3,'{{defense_comment}}','绛旇京璇勮',1),(40,3,'{{signature_group_leader}}','缁勯暱绛惧悕',1),(41,4,'{{student_name}}','瀛︾敓濮撳悕',1),(42,4,'{{student_id}}','瀛﹀彿',1),(43,4,'{{date_year}}','骞翠唤',1),(44,4,'{{date_month}}','鏈堜唤',1),(45,4,'{{date_day}}','鏃ユ湡',1),(46,4,'{{thesis_title}}','棰樼洰',1),(47,4,'{{advisor_score}}','鎸囧鑰佸笀鎴愮哗',1),(48,4,'{{reviewer_score}}','璇勯槄浜烘垚缁?,1),(49,4,'{{defense_score}}','绛旇京鎴愮哗',1),(50,4,'{{advisor_calculated}}','鎸囧鑰佸笀鎴愮哗脳0.3',1),(51,4,'{{reviewer_calculated}}','璇勯槄浜烘垚缁┟?.3',1),(52,4,'{{defense_calculated}}','绛旇京鎴愮哗脳0.4',1),(53,4,'{{final_score}}','鏈€缁堟垚缁?,1),(54,4,'{{signature_department_head}}','绯讳富浠荤鍚?,1),(55,5,'{{student_name}}','瀛︾敓濮撳悕',1),(56,5,'{{student_id}}','瀛﹀彿',1),(57,5,'{{date_year}}','骞翠唤',1),(58,5,'{{date_month}}','鏈堜唤',1),(59,5,'{{date_day}}','鏃ユ湡',1),(60,5,'{{thesis_title}}','棰樼洰',1),(61,5,'{{total_score}}','鎬绘垚缁?,1),(62,5,'{{signature_judge}}','璇勫绛惧悕',1),(63,6,'{{student_name}}','瀛︾敓濮撳悕',1),(64,6,'{{student_id}}','瀛﹀彿',1),(65,6,'{{date_year}}','骞翠唤',1),(66,6,'{{date_month}}','鏈堜唤',1),(67,6,'{{date_day}}','鏃ユ湡',1),(68,6,'{{thesis_title}}','棰樼洰',1),(69,6,'{{paper_quality_score}}','璁烘枃璐ㄩ噺鍒?,1),(70,6,'{{defense_report_score}}','绛旇京鎶ュ憡鍒?,1),(71,6,'{{response_score}}','鍥炵瓟闂鍒?,1),(72,6,'{{total_score}}','鎬绘垚缁?,1),(73,6,'{{signature_judge}}','璇勫绛惧悕',1),(74,7,'{{student_name}}','瀛︾敓濮撳悕',1),(75,7,'{{student_id}}','瀛﹀彿',1),(76,7,'{{date_year}}','骞翠唤',1),(77,7,'{{date_month}}','鏈堜唤',1),(78,7,'{{date_day}}','鏃ユ湡',1),(79,7,'{{thesis_title}}','棰樼洰',1),(80,7,'{{design_quality_score1}}','璁捐璐ㄩ噺鍒?',1),(81,7,'{{design_quality_score2}}','璁捐璐ㄩ噺鍒?',1),(82,7,'{{design_quality_score3}}','璁捐璐ㄩ噺鍒?',1),(83,7,'{{defense_report_score}}','绛旇京鎶ュ憡鍒?,1),(84,7,'{{response_score1}}','鍥炵瓟闂鍒?',1),(85,7,'{{response_score2}}','鍥炵瓟闂鍒?',1),(86,7,'{{total_score}}','鎬绘垚缁?,1),(87,7,'{{signature_judge}}','璇勫绛惧悕',1);
/*!40000 ALTER TABLE `placeholder_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` char(10) NOT NULL,
  `real_name` varchar(20) NOT NULL,
  `tel` char(11) DEFAULT NULL,
  `email` varchar(20) DEFAULT NULL,
  `institute_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_institute_id` (`institute_id`),
  KEY `idx_student_id` (`id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institute` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('2023001','wxy','13800138001','wxy@email.com',1),('2023002','lwx','13800138002','lwx@email.com',1),('2023003','zzh','13800138003','zzh@email.com',1);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tea_group_rel`
--

DROP TABLE IF EXISTS `tea_group_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tea_group_rel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `teacher_id` char(10) NOT NULL,
  `group_id` int NOT NULL,
  `is_defense_leader` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_teacher_group` (`teacher_id`,`group_id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `tea_group_rel_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `user` (`id`),
  CONSTRAINT `tea_group_rel_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `dbgroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tea_group_rel`
--

LOCK TABLES `tea_group_rel` WRITE;
/*!40000 ALTER TABLE `tea_group_rel` DISABLE KEYS */;
INSERT INTO `tea_group_rel` VALUES (1,'100001',1,1),(2,'100002',1,0),(3,'100003',1,0),(4,'100004',1,0);
/*!40000 ALTER TABLE `tea_group_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tea_stu_rel`
--

DROP TABLE IF EXISTS `tea_stu_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tea_stu_rel` (
  `tea_id` char(10) DEFAULT NULL,
  `stu_id` char(10) DEFAULT NULL,
  `year` int DEFAULT NULL,
  UNIQUE KEY `tea_id` (`tea_id`,`stu_id`),
  KEY `fk_stu_id` (`stu_id`),
  CONSTRAINT `tea_stu_rel_ibfk_1` FOREIGN KEY (`tea_id`) REFERENCES `user` (`id`),
  CONSTRAINT `tea_stu_rel_ibfk_2` FOREIGN KEY (`stu_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tea_stu_rel`
--

LOCK TABLES `tea_stu_rel` WRITE;
/*!40000 ALTER TABLE `tea_stu_rel` DISABLE KEYS */;
INSERT INTO `tea_stu_rel` VALUES ('100001','2023001',2026),('100001','2023002',2026),('100001','2023003',2026);
/*!40000 ALTER TABLE `tea_stu_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` int NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_size` bigint DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_template_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template`
--

LOCK TABLES `template` WRITE;
/*!40000 ALTER TABLE `template` DISABLE KEYS */;
INSERT INTO `template` VALUES (1,'鏈姣曚笟璁捐绛旇京鎴愮哗琛?,1,'','',NULL,'2026-01-05 12:36:43',NULL),(2,'鏈姣曚笟璁捐鎴愮哗璇勫畾琛?,2,'','',NULL,'2026-01-05 12:36:43',NULL),(3,'鏈姣曚笟璁烘枃绛旇京鎴愮哗琛?,3,'','',NULL,'2026-01-05 12:36:43',NULL),(4,'鏈姣曚笟璁烘枃鎴愮哗璇勫畾琛?,4,'','',NULL,'2026-01-05 12:36:43',NULL),(5,'姣曚笟璁烘枃(璁捐)绛旇京灏忕粍缁熷垎琛?,5,'','',NULL,'2026-01-05 12:36:43',NULL),(6,'姣曚笟璁烘枃绛旇京鎴愮哗鏃犺瘎璇繃绋嬭〃',6,'','',NULL,'2026-01-05 12:36:43',NULL),(7,'姣曚笟璁捐绛旇京鎴愮哗鏃犺瘎璇繃绋嬭〃',7,'','',NULL,'2026-01-05 12:36:43',NULL);
/*!40000 ALTER TABLE `template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` char(10) NOT NULL,
  `pwd` varchar(30) NOT NULL,
  `role` int NOT NULL,
  `real_name` varchar(20) NOT NULL,
  `phone` char(11) DEFAULT NULL,
  `email` varchar(32) DEFAULT NULL,
  `signaturePath` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('100001','123456',2,'寮犺€佸笀','13800138001','zhang@example.com',NULL),('100002','123456',2,'鏉庤€佸笀','13800138002','li@example.com',NULL),('100003','123456',2,'鐜嬭€佸笀','13800138003','wang@example.com',NULL),('100004','123456',2,'璧佃€佸笀','13800138004','zhao@example.com',NULL),('123123','123456',2,'jj3',NULL,NULL,NULL),('123456','123456',2,'jj4',NULL,NULL,NULL),('aaaa','123456',1,'aaaa',NULL,NULL,NULL),('admin','123456',0,'jj1',NULL,NULL,NULL),('inst','123456',1,'jj2',NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_inst_rel`
--

DROP TABLE IF EXISTS `user_inst_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_inst_rel` (
  `user_id` char(10) DEFAULT NULL,
  `inst_id` int DEFAULT NULL,
  UNIQUE KEY `uk_user_inst` (`user_id`,`inst_id`),
  KEY `uk_inst_id` (`inst_id`),
  CONSTRAINT `user_inst_rel_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_inst_rel_ibfk_2` FOREIGN KEY (`inst_id`) REFERENCES `institute` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_inst_rel`
--

LOCK TABLES `user_inst_rel` WRITE;
/*!40000 ALTER TABLE `user_inst_rel` DISABLE KEYS */;
INSERT INTO `user_inst_rel` VALUES ('100001',1),('100002',1),('100003',1),('100004',1),('aaaa',1),('inst',1);
/*!40000 ALTER TABLE `user_inst_rel` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-25 16:16:47
