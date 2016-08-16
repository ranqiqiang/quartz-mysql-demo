-- ----------------------------
--  Table structure for `qrtz_blob_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度名',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组名',
  `BLOB_DATA` blob COMMENT 'data',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Trigger 作为 Blob 类型存储(用于 Quartz 用户用 JDBC 创建他们自己定制的 Trigger 类型';

-- ----------------------------
--  Table structure for `qrtz_calendars`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'scheduler名称',
  `CALENDAR_NAME` varchar(200) NOT NULL COMMENT 'calendar名称',
  `CALENDAR` blob NOT NULL COMMENT 'calendar信息',
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='以 Blob 类型存储 Quartz 的 Calendar 信息';

-- ----------------------------
--  Table structure for `qrtz_cron_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT 'scheduler名称',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT 'trigger名',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT 'trigger组',
  `CRON_EXPRESSION` varchar(120) NOT NULL COMMENT 'cron表达式',
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储 Cron Trigger，包括 Cron 表达式和时区信息';

-- ----------------------------
--  Table structure for `qrtz_fired_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度名',
  `ENTRY_ID` varchar(95) NOT NULL COMMENT '条目id',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '出触发器名',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组名',
  `INSTANCE_NAME` varchar(200) NOT NULL COMMENT '实例名',
  `FIRED_TIME` bigint(13) NOT NULL COMMENT '执行时间',
  `SCHED_TIME` bigint(13) NOT NULL COMMENT '调度时间',
  `PRIORITY` int(11) NOT NULL COMMENT '优先级',
  `STATE` varchar(16) NOT NULL COMMENT '状态',
  `JOB_NAME` varchar(200) DEFAULT NULL COMMENT 'job名',
  `JOB_GROUP` varchar(200) DEFAULT NULL COMMENT 'job组',
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL COMMENT '是否非并行执行',
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL COMMENT '是否持久化',
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储已触发的 Trigger相关的状态信息，以及关联 Job 的执行信息';

-- ----------------------------
--  Table structure for `qrtz_job_details`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度名',
  `JOB_NAME` varchar(200) NOT NULL COMMENT 'job名',
  `JOB_GROUP` varchar(200) NOT NULL COMMENT 'job组名',
  `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT '描述',
  `JOB_CLASS_NAME` varchar(250) NOT NULL COMMENT 'job类名',
  `IS_DURABLE` varchar(1) NOT NULL COMMENT '是否持久化，0不持久化，1持久化',
  `IS_NONCONCURRENT` varchar(1) NOT NULL COMMENT '是否非并发，0非并发，1并发',
  `IS_UPDATE_DATA` varchar(1) NOT NULL COMMENT '是否更新数据',
  `REQUESTS_RECOVERY` varchar(1) NOT NULL COMMENT '是否可恢复，0不恢复，1恢复',
  `JOB_DATA` blob COMMENT 'job数据',
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储每一个已配置的 Job 的详细信息';

-- ----------------------------
--  Table structure for `qrtz_locks`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度名',
  `LOCK_NAME` varchar(40) NOT NULL COMMENT '锁名',
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储程序的悲观锁的信息(假如使用了悲观锁)';

-- ----------------------------
--  Table structure for `qrtz_paused_trigger_grps`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度名',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储已暂停的 Trigger 组的信息';

-- ----------------------------
--  Table structure for `qrtz_scheduler_state`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度名',
  `INSTANCE_NAME` varchar(200) NOT NULL COMMENT '执行quartz实例的主机名',
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL COMMENT '实例将状态报告给集群中的其它实例的上一次时间',
  `CHECKIN_INTERVAL` bigint(13) NOT NULL COMMENT '实例间状态报告的时间频率',
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储少量的有关 Scheduler 的状态信息';

-- ----------------------------
--  Table structure for `qrtz_simple_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度名',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `REPEAT_COUNT` bigint(7) NOT NULL COMMENT '重复次数',
  `REPEAT_INTERVAL` bigint(12) NOT NULL COMMENT '重复间隔',
  `TIMES_TRIGGERED` bigint(10) NOT NULL COMMENT '已触发次数',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储简单的 Trigger，包括重复次数，间隔，以及已触的次数';

-- ----------------------------
--  Table structure for `qrtz_simprop_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度名',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `STR_PROP_1` varchar(512) DEFAULT NULL COMMENT 'str参数1',
  `STR_PROP_2` varchar(512) DEFAULT NULL COMMENT 'str参数2',
  `STR_PROP_3` varchar(512) DEFAULT NULL COMMENT 'str参数3',
  `INT_PROP_1` int(11) DEFAULT NULL COMMENT 'int参数1',
  `INT_PROP_2` int(11) DEFAULT NULL COMMENT 'int参数2',
  `LONG_PROP_1` bigint(20) DEFAULT NULL COMMENT 'long参数1',
  `LONG_PROP_2` bigint(20) DEFAULT NULL COMMENT 'long参数2',
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL COMMENT 'decimal参数1',
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL COMMENT 'decimal参数2',
  `BOOL_PROP_1` varchar(1) DEFAULT NULL COMMENT 'bool参数1',
  `BOOL_PROP_2` varchar(1) DEFAULT NULL COMMENT 'bool参数2',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `qrtz_triggers`
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '调度名',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `JOB_NAME` varchar(200) NOT NULL COMMENT 'job名',
  `JOB_GROUP` varchar(200) NOT NULL COMMENT 'job组',
  `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT '描述',
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL COMMENT '下次执行时间',
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL COMMENT '上次执行时间',
  `PRIORITY` int(11) DEFAULT NULL COMMENT '优先级',
  `TRIGGER_STATE` varchar(16) NOT NULL COMMENT '触发器状态',
  `TRIGGER_TYPE` varchar(8) NOT NULL COMMENT '触发器类型',
  `START_TIME` bigint(13) NOT NULL COMMENT '开始时间',
  `END_TIME` bigint(13) DEFAULT NULL COMMENT '结束时间',
  `CALENDAR_NAME` varchar(200) DEFAULT NULL COMMENT 'calendar名',
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL COMMENT 'misfire',
  `JOB_DATA` blob COMMENT 'job数据',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储已配置的 Trigger 的信息';
