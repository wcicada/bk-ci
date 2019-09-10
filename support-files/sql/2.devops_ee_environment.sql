USE devops_ee_environment;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for T_ENV
-- ----------------------------
DROP TABLE IF EXISTS `T_ENV`;
CREATE TABLE `T_ENV` (
  `ENV_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `PROJECT_ID` varchar(64) NOT NULL COMMENT '项目ID',
  `ENV_NAME` varchar(128) NOT NULL COMMENT '名称',
  `ENV_DESC` varchar(128) NOT NULL COMMENT '描述',
  `ENV_TYPE` varchar(128) NOT NULL COMMENT '环境类型',
  `ENV_VARS` text NOT NULL COMMENT '环境变量',
  `CREATED_USER` varchar(64) NOT NULL,
  `UPDATED_USER` varchar(64) NOT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT NULL,
  `UPDATED_TIME` timestamp NULL DEFAULT NULL,
  `IS_DELETED` bit(1) NOT NULL,
  PRIMARY KEY (`ENV_ID`),
  KEY `PROJECT_ID` (`PROJECT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for T_ENVIRONMENT_AGENT_PIPELINE
-- ----------------------------
DROP TABLE IF EXISTS `T_ENVIRONMENT_AGENT_PIPELINE`;
CREATE TABLE `T_ENVIRONMENT_AGENT_PIPELINE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AGENT_ID` bigint(20) NOT NULL,
  `PROJECT_ID` varchar(32) NOT NULL,
  `USER_ID` varchar(32) NOT NULL,
  `CREATED_TIME` datetime NOT NULL,
  `UPDATED_TIME` datetime NOT NULL,
  `STATUS` int(11) NOT NULL,
  `PIPELINE` varchar(1024) NOT NULL,
  `RESPONSE` text,
  PRIMARY KEY (`ID`),
  KEY `AGENT_ID` (`AGENT_ID`),
  KEY `STATUS` (`STATUS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for T_ENVIRONMENT_SLAVE_GATEWAY
-- ----------------------------
DROP TABLE IF EXISTS `T_ENVIRONMENT_SLAVE_GATEWAY`;
CREATE TABLE `T_ENVIRONMENT_SLAVE_GATEWAY` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(32) NOT NULL,
  `SHOW_NAME` varchar(32) NOT NULL,
  `GATEWAY` varchar(32) DEFAULT '',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for T_ENVIRONMENT_THIRDPARTY_AGENT
-- ----------------------------
DROP TABLE IF EXISTS `T_ENVIRONMENT_THIRDPARTY_AGENT`;
CREATE TABLE `T_ENVIRONMENT_THIRDPARTY_AGENT` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NODE_ID` bigint(20) DEFAULT NULL,
  `PROJECT_ID` varchar(64) NOT NULL,
  `HOSTNAME` varchar(128) DEFAULT '',
  `IP` varchar(64) DEFAULT '',
  `OS` varchar(16) NOT NULL,
  `DETECT_OS` varchar(128) DEFAULT '',
  `STATUS` int(11) NOT NULL,
  `SECRET_KEY` varchar(256) NOT NULL,
  `CREATED_USER` varchar(64) NOT NULL,
  `CREATED_TIME` datetime NOT NULL,
  `START_REMOTE_IP` varchar(64) DEFAULT NULL,
  `GATEWAY` varchar(32) DEFAULT '',
  `VERSION` varchar(128) DEFAULT NULL,
  `MASTER_VERSION` varchar(128) DEFAULT NULL,
  `PARALLEL_TASK_COUNT` int(11) DEFAULT NULL,
  `AGENT_INSTALL_PATH` varchar(512) DEFAULT NULL,
  `STARTED_USER` varchar(64) DEFAULT NULL,
  `AGENT_ENVS` text,
  PRIMARY KEY (`ID`),
  KEY `idx_agent_node` (`NODE_ID`),
  KEY `idx_agent_project` (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for T_ENV_NODE
-- ----------------------------
DROP TABLE IF EXISTS `T_ENV_NODE`;
CREATE TABLE `T_ENV_NODE` (
  `ENV_ID` bigint(20) NOT NULL COMMENT '环境ID',
  `NODE_ID` bigint(20) NOT NULL COMMENT '节点ID',
  `PROJECT_ID` varchar(64) NOT NULL COMMENT '项目ID',
  PRIMARY KEY (`ENV_ID`,`NODE_ID`),
  KEY `PROJECT_ID` (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for T_NODE
-- ----------------------------
DROP TABLE IF EXISTS `T_NODE`;
CREATE TABLE `T_NODE` (
  `NODE_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `NODE_STRING_ID` varchar(32) DEFAULT NULL,
  `PROJECT_ID` varchar(64) NOT NULL COMMENT '项目ID',
  `NODE_IP` varchar(64) NOT NULL COMMENT 'IP',
  `NODE_NAME` varchar(64) NOT NULL COMMENT '名称',
  `NODE_STATUS` varchar(64) NOT NULL COMMENT '名称',
  `NODE_TYPE` varchar(64) NOT NULL COMMENT 'CMDB|BCSVM',
  `NODE_CLUSTER_ID` varchar(128) DEFAULT NULL COMMENT 'bcs集群ID',
  `NODE_NAMESPACE` varchar(128) DEFAULT NULL COMMENT 'bcs namespace',
  `CREATED_USER` varchar(64) NOT NULL,
  `CREATED_TIME` timestamp NULL DEFAULT NULL,
  `EXPIRE_TIME` timestamp NULL DEFAULT NULL,
  `OS_NAME` varchar(128) DEFAULT NULL,
  `OPERATOR` varchar(256) DEFAULT NULL,
  `BAK_OPERATOR` varchar(256) DEFAULT NULL,
  `AGENT_STATUS` bit(1) DEFAULT NULL COMMENT 'Agent״̬',
  `DISPLAY_NAME` varchar(128) NOT NULL DEFAULT '',
  `IMAGE` varchar(512) DEFAULT NULL COMMENT 'é•œåƒ',
  `TASK_ID` bigint(20) DEFAULT NULL COMMENT 'ä»»åŠ¡ID',
  `LAST_MODIFY_TIME` timestamp NULL DEFAULT NULL,
  `LAST_MODIFY_USER` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`NODE_ID`),
  KEY `PROJECT_ID` (`PROJECT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for T_ENVIRONMENT_THIRDPARTY_AGENT_ACTION
-- ----------------------------
DROP TABLE IF EXISTS `T_ENVIRONMENT_THIRDPARTY_AGENT_ACTION`;
CREATE TABLE `T_ENVIRONMENT_THIRDPARTY_AGENT_ACTION` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `AGENT_ID` bigint(20) NOT NULL,
  `PROJECT_ID` varchar(64) NOT NULL,
  `ACTION` varchar(64) NOT NULL,
  `ACTION_TIME` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `AGENT_ID` (`AGENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;
