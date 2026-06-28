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
                               `config_key` varchar(50) NOT NULL COMMENT '配置键：defense_date/evaluation_date',
                               `config_value` date NOT NULL COMMENT '日期值',
                               `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                               PRIMARY KEY (`id`),
                               UNIQUE KEY `uk_config_key` (`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日期配置表';
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
                           `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
                           `year` int DEFAULT NULL COMMENT '答辩年份',
                           `admin_id` char(10) DEFAULT NULL COMMENT '答辩组长',
                           `max_student_count` int DEFAULT NULL COMMENT '最大学生数量',
                           `adjustmentCoefficient` double DEFAULT NULL COMMENT '调节系数',
                           PRIMARY KEY (`id`),
                           KEY `fk_user_id` (`admin_id`),
                           CONSTRAINT `dbgroup_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='答辩组';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbgroup`
--

LOCK TABLES `dbgroup` WRITE;
/*!40000 ALTER TABLE `dbgroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `dbgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbinfo`
--

DROP TABLE IF EXISTS `dbinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dbinfo` (
                          `gid` int DEFAULT NULL COMMENT '答辩组号',
                          `stu_id` char(10) DEFAULT NULL COMMENT '学生编号',
                          `type` int DEFAULT NULL COMMENT '毕业考核类型',
                          `title` varchar(128) DEFAULT NULL COMMENT '毕业考核题目',
                          `time` date DEFAULT NULL COMMENT '答辩日期',
                          `summary` varchar(255) DEFAULT NULL COMMENT '毕业考核摘要',
                          `reviewer_id` char(10) DEFAULT NULL COMMENT '评阅人id',
                          `total_score` int DEFAULT '0' COMMENT '总分',
                          `comment` text COMMENT '答辩小组评语',
                          `graded_by` varchar(10) DEFAULT NULL COMMENT '评分人id',
                          `teacher_scores` json DEFAULT NULL COMMENT '其他教师评分(json格式存储)',
                          UNIQUE KEY `uk_stu_gid` (`stu_id`,`gid`),
                          KEY `reviewer_id` (`reviewer_id`),
                          KEY `gid` (`gid`),
                          CONSTRAINT `dbinfo_ibfk_1` FOREIGN KEY (`reviewer_id`) REFERENCES `user` (`id`),
                          CONSTRAINT `dbinfo_ibfk_2` FOREIGN KEY (`gid`) REFERENCES `dbgroup` (`id`),
                          CONSTRAINT `dbinfo_ibfk_3` FOREIGN KEY (`stu_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生答辩信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbinfo`
--

LOCK TABLES `dbinfo` WRITE;
/*!40000 ALTER TABLE `dbinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `dbinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_defense`
--

DROP TABLE IF EXISTS `group_defense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_defense` (
                                 `group_id` int NOT NULL COMMENT '答辩组号',
                                 `stu_id` char(10) NOT NULL COMMENT '学生编号',
                                 `major_score` int DEFAULT NULL COMMENT '大组答辩成绩',
                                 PRIMARY KEY (`group_id`,`stu_id`),
                                 KEY `stu_id` (`stu_id`),
                                 CONSTRAINT `group_defense_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `dbgroup` (`id`),
                                 CONSTRAINT `group_defense_ibfk_2` FOREIGN KEY (`stu_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='大组答辩表';
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
                             `id` int NOT NULL AUTO_INCREMENT COMMENT '院系id',
                             `name` varchar(20) NOT NULL COMMENT '院系名称',
                             `user_id` char(10) DEFAULT NULL COMMENT '管理员id',
                             PRIMARY KEY (`id`),
                             UNIQUE KEY `uk_institute` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='院系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institute`
--

LOCK TABLES `institute` WRITE;
/*!40000 ALTER TABLE `institute` DISABLE KEYS */;
INSERT INTO `institute` VALUES (1,'计算机与信息学院','inst'),(2,'土木',NULL);
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
                                      `template_type` int NOT NULL COMMENT '模板类型',
                                      `placeholder_key` varchar(100) NOT NULL COMMENT '占位符键名',
                                      `placeholder_name` varchar(100) NOT NULL COMMENT '占位符显示名称',
                                      `is_required` tinyint(1) DEFAULT '1' COMMENT '是否必需',
                                      PRIMARY KEY (`id`),
                                      UNIQUE KEY `uk_type_placeholder` (`template_type`,`placeholder_key`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='模板占位符配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `placeholder_config`
--

LOCK TABLES `placeholder_config` WRITE;
/*!40000 ALTER TABLE `placeholder_config` DISABLE KEYS */;
INSERT INTO `placeholder_config` VALUES (1,1,'{{student_name}}','学生姓名',1),(2,1,'{{student_id}}','学号',1),(3,1,'{{date_year}}','年份',1),(4,1,'{{date_month}}','月份',1),(5,1,'{{date_day}}','日期',1),(6,1,'{{thesis_title}}','题目',1),(7,1,'{{design_quality_score1}}','设计质量分1',1),(8,1,'{{design_quality_score2}}','设计质量分2',1),(9,1,'{{design_quality_score3}}','设计质量分3',1),(10,1,'{{defense_report_score}}','答辩报告分',1),(11,1,'{{response_score1}}','回答问题分1',1),(12,1,'{{response_score2}}','回答问题分2',1),(13,1,'{{total_score}}','总成绩',1),(14,1,'{{signature_judge}}','评委签名',1),(15,2,'{{student_name}}','学生姓名',1),(16,2,'{{student_id}}','学号',1),(17,2,'{{date_year}}','年份',1),(18,2,'{{date_month}}','月份',1),(19,2,'{{date_day}}','日期',1),(20,2,'{{thesis_title}}','题目',1),(21,2,'{{advisor_score}}','指导老师成绩',1),(22,2,'{{reviewer_score}}','评阅人成绩',1),(23,2,'{{defense_score}}','答辩成绩',1),(24,2,'{{advisor_calculated}}','指导老师成绩×0.3',1),(25,2,'{{reviewer_calculated}}','评阅人成绩×0.3',1),(26,2,'{{defense_calculated}}','答辩成绩×0.4',1),(27,2,'{{final_score}}','最终成绩',1),(28,2,'{{signature_department_head}}','系主任签名',1),(29,3,'{{student_name}}','学生姓名',1),(30,3,'{{student_id}}','学号',1),(31,3,'{{date_year}}','年份',1),(32,3,'{{date_month}}','月份',1),(33,3,'{{date_day}}','日期',1),(34,3,'{{thesis_title}}','题目',1),(35,3,'{{paper_quality_score}}','论文质量分',1),(36,3,'{{defense_report_score}}','答辩报告分',1),(37,3,'{{response_score}}','回答问题分',1),(38,3,'{{total_score}}','总成绩',1),(39,3,'{{defense_comment}}','答辩评语',1),(40,3,'{{signature_group_leader}}','组长签名',1),(41,4,'{{student_name}}','学生姓名',1),(42,4,'{{student_id}}','学号',1),(43,4,'{{date_year}}','年份',1),(44,4,'{{date_month}}','月份',1),(45,4,'{{date_day}}','日期',1),(46,4,'{{thesis_title}}','题目',1),(47,4,'{{advisor_score}}','指导老师成绩',1),(48,4,'{{reviewer_score}}','评阅人成绩',1),(49,4,'{{defense_score}}','答辩成绩',1),(50,4,'{{advisor_calculated}}','指导老师成绩×0.3',1),(51,4,'{{reviewer_calculated}}','评阅人成绩×0.3',1),(52,4,'{{defense_calculated}}','答辩成绩×0.4',1),(53,4,'{{final_score}}','最终成绩',1),(54,4,'{{signature_department_head}}','系主任签名',1),(55,5,'{{student_name}}','学生姓名',1),(56,5,'{{student_id}}','学号',1),(57,5,'{{date_year}}','年份',1),(58,5,'{{date_month}}','月份',1),(59,5,'{{date_day}}','日期',1),(60,5,'{{thesis_title}}','题目',1),(61,5,'{{total_score}}','总成绩',1),(62,5,'{{signature_judge}}','评委签名',1),(63,6,'{{student_name}}','学生姓名',1),(64,6,'{{student_id}}','学号',1),(65,6,'{{date_year}}','年份',1),(66,6,'{{date_month}}','月份',1),(67,6,'{{date_day}}','日期',1),(68,6,'{{thesis_title}}','题目',1),(69,6,'{{paper_quality_score}}','论文质量分',1),(70,6,'{{defense_report_score}}','答辩报告分',1),(71,6,'{{response_score}}','回答问题分',1),(72,6,'{{total_score}}','总成绩',1),(73,6,'{{signature_judge}}','评委签名',1),(74,7,'{{student_name}}','学生姓名',1),(75,7,'{{student_id}}','学号',1),(76,7,'{{date_year}}','年份',1),(77,7,'{{date_month}}','月份',1),(78,7,'{{date_day}}','日期',1),(79,7,'{{thesis_title}}','题目',1),(80,7,'{{design_quality_score1}}','设计质量分1',1),(81,7,'{{design_quality_score2}}','设计质量分2',1),(82,7,'{{design_quality_score3}}','设计质量分3',1),(83,7,'{{defense_report_score}}','答辩报告分',1),(84,7,'{{response_score1}}','回答问题分1',1),(85,7,'{{response_score2}}','回答问题分2',1),(86,7,'{{total_score}}','总成绩',1),(87,7,'{{signature_judge}}','评委签名',1);
/*!40000 ALTER TABLE `placeholder_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
                           `id` char(10) NOT NULL COMMENT '学号',
                           `real_name` varchar(20) NOT NULL COMMENT '姓名',
                           `tel` char(11) DEFAULT NULL COMMENT '电话号码',
                           `email` varchar(32) DEFAULT NULL COMMENT '邮箱',
                           `institute_id` int NOT NULL COMMENT '所属院系id',
                           PRIMARY KEY (`id`),
                           KEY `fk_institute_id` (`institute_id`),
                           KEY `idx_student_id` (`id`),
                           CONSTRAINT `student_ibfk_1` FOREIGN KEY (`institute_id`) REFERENCES `institute` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生基本信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('2023002','lwx','13800138002','lwx@email.com',1),('2023003','zzh','13800138003','zzh@email.com',1);
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
                                 `teacher_id` char(10) NOT NULL COMMENT '教师ID',
                                 `group_id` int NOT NULL COMMENT '小组ID',
                                 `is_defense_leader` tinyint(1) DEFAULT '0' COMMENT '是否为组长',
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `uk_teacher_group` (`teacher_id`,`group_id`),
                                 KEY `group_id` (`group_id`),
                                 CONSTRAINT `tea_group_rel_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `user` (`id`),
                                 CONSTRAINT `tea_group_rel_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `dbgroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='教师与答辩小组关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tea_group_rel`
--

LOCK TABLES `tea_group_rel` WRITE;
/*!40000 ALTER TABLE `tea_group_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `tea_group_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tea_stu_rel`
--

DROP TABLE IF EXISTS `tea_stu_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tea_stu_rel` (
                               `tea_id` char(10) DEFAULT NULL COMMENT '老师id',
                               `stu_id` char(10) DEFAULT NULL COMMENT '学生id',
                               `year` int DEFAULT NULL COMMENT '指导年份',
                               UNIQUE KEY `tea_id` (`tea_id`,`stu_id`),
                               KEY `fk_stu_id` (`stu_id`),
                               CONSTRAINT `tea_stu_rel_ibfk_1` FOREIGN KEY (`tea_id`) REFERENCES `user` (`id`),
                               CONSTRAINT `tea_stu_rel_ibfk_2` FOREIGN KEY (`stu_id`) REFERENCES `student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='老师指导学生信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tea_stu_rel`
--

LOCK TABLES `tea_stu_rel` WRITE;
/*!40000 ALTER TABLE `tea_stu_rel` DISABLE KEYS */;
INSERT INTO `tea_stu_rel` VALUES ('100001','2023002',2026),('100001','2023003',2026);
/*!40000 ALTER TABLE `tea_stu_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `template` (
                            `id` int NOT NULL AUTO_INCREMENT COMMENT '模板id',
                            `name` varchar(100) NOT NULL COMMENT '模板名称',
                            `type` int NOT NULL COMMENT '模板类型：1-本科毕业设计答辩成绩表, 2-本科毕业设计成绩评定表, 3-本科毕业论文答辩成绩表, 4-本科毕业论文成绩评定表, 5-毕业论文(设计)答辩小组统分表, 6-毕业论文答辩成绩无评语过程表, 7-毕业设计答辩成绩无评语过程表',
                            `file_path` varchar(500) NOT NULL COMMENT '文件存储路径',
                            `file_name` varchar(255) NOT NULL COMMENT '原始文件名',
                            `file_size` bigint DEFAULT NULL COMMENT '文件大小',
                            `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                            `updated_by` varchar(50) DEFAULT NULL COMMENT '最后更新人',
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `uk_template_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文档模板表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template`
--

LOCK TABLES `template` WRITE;
/*!40000 ALTER TABLE `template` DISABLE KEYS */;
INSERT INTO `template` VALUES (1,'本科毕业设计答辩成绩表',1,'','',NULL,'2026-01-05 12:36:43',NULL),(2,'本科毕业设计成绩评定表',2,'','',NULL,'2026-01-05 12:36:43',NULL),(3,'本科毕业论文答辩成绩表',3,'','',NULL,'2026-01-05 12:36:43',NULL),(4,'本科毕业论文成绩评定表',4,'','',NULL,'2026-01-05 12:36:43',NULL),(5,'毕业论文(设计)答辩小组统分表',5,'','',NULL,'2026-01-05 12:36:43',NULL),(6,'毕业论文答辩成绩无评语过程表',6,'','',NULL,'2026-01-05 12:36:43',NULL),(7,'毕业设计答辩成绩无评语过程表',7,'','',NULL,'2026-01-05 12:36:43',NULL);
/*!40000 ALTER TABLE `template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
                        `id` char(10) NOT NULL COMMENT '用户id',
                        `pwd` varchar(30) NOT NULL COMMENT '密码',
                        `role` int NOT NULL COMMENT '角色标识',
                        `real_name` varchar(20) NOT NULL COMMENT '真实姓名',
                        `phone` char(11) DEFAULT NULL COMMENT '联系电话',
                        `email` varchar(32) DEFAULT NULL COMMENT '邮箱',
                        `signaturePath` varchar(100) DEFAULT NULL COMMENT '签名路径',
                        PRIMARY KEY (`id`),
                        KEY `idx_user_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('100001','123456',2,'张老师','13800138001','zhang@example.com',NULL),('100002','123456',2,'李老师','13800138002','li@example.com',NULL),('100003','123456',2,'王老师','13800138003','wang@example.com',NULL),('100004','123456',2,'赵老师','13800138004','zhao@example.com',NULL),('123123','123456',2,'jj3',NULL,NULL,NULL),('123456','123456',2,'jj4',NULL,NULL,NULL),('aaaa','123456',1,'aaaa',NULL,NULL,NULL),('admin','123456',0,'jj1',NULL,NULL,NULL),('inst','123456',1,'jj2',NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_inst_rel`
--

DROP TABLE IF EXISTS `user_inst_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_inst_rel` (
                                 `user_id` char(10) DEFAULT NULL COMMENT '用户id',
                                 `inst_id` int DEFAULT NULL COMMENT '院系id',
                                 UNIQUE KEY `uk_user_inst` (`user_id`,`inst_id`),
                                 KEY `uk_inst_id` (`inst_id`),
                                 CONSTRAINT `user_inst_rel_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
                                 CONSTRAINT `user_inst_rel_ibfk_2` FOREIGN KEY (`inst_id`) REFERENCES `institute` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户所属院系';
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

-- Dump completed on 2026-06-28 15:01:20
