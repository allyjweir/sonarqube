CREATE TABLE "GROUPS_USERS" (
  "USER_ID" INTEGER,
  "GROUP_ID" INTEGER
);

CREATE TABLE "RULES_PARAMETERS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "RULE_ID" INTEGER NOT NULL,
  "NAME" VARCHAR(128) NOT NULL,
  "PARAM_TYPE" VARCHAR(512) NOT NULL,
  "DEFAULT_VALUE" VARCHAR(4000),
  "DESCRIPTION" VARCHAR(4000)
);

CREATE TABLE "RULES_PROFILES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "NAME" VARCHAR(100) NOT NULL,
  "LANGUAGE" VARCHAR(20),
  "KEE" VARCHAR(255) NOT NULL,
  "PARENT_KEE" VARCHAR(255),
  "RULES_UPDATED_AT" VARCHAR(100),
  "IS_DEFAULT" BOOLEAN NOT NULL DEFAULT FALSE,
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);

CREATE TABLE "PROJECT_QPROFILES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PROJECT_UUID" VARCHAR(50) NOT NULL,
  "PROFILE_KEY" VARCHAR(255) NOT NULL
);

CREATE TABLE "WIDGETS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "DASHBOARD_ID" INTEGER NOT NULL,
  "WIDGET_KEY" VARCHAR(256) NOT NULL,
  "NAME" VARCHAR(256),
  "DESCRIPTION" VARCHAR(1000),
  "COLUMN_INDEX" INTEGER,
  "ROW_INDEX" INTEGER,
  "CONFIGURED" BOOLEAN,
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP,
  "RESOURCE_ID" INTEGER
);

CREATE TABLE "GROUPS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "NAME" VARCHAR(500),
  "DESCRIPTION" VARCHAR(200),
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);

CREATE TABLE "SNAPSHOTS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "CREATED_AT" BIGINT,
  "BUILD_DATE" BIGINT,
  "PROJECT_ID" INTEGER NOT NULL,
  "PARENT_SNAPSHOT_ID" INTEGER,
  "STATUS" VARCHAR(4) NOT NULL DEFAULT 'U',
  "PURGE_STATUS" INTEGER,
  "ISLAST" BOOLEAN NOT NULL DEFAULT FALSE,
  "SCOPE" VARCHAR(3),
  "QUALIFIER" VARCHAR(10),
  "ROOT_SNAPSHOT_ID" INTEGER,
  "VERSION" VARCHAR(500),
  "PATH" VARCHAR(500),
  "DEPTH" INTEGER,
  "ROOT_PROJECT_ID" INTEGER,
  "PERIOD1_MODE" VARCHAR(100),
  "PERIOD1_PARAM" VARCHAR(100),
  "PERIOD1_DATE" BIGINT,
  "PERIOD2_MODE" VARCHAR(100),
  "PERIOD2_PARAM" VARCHAR(100),
  "PERIOD2_DATE" BIGINT,
  "PERIOD3_MODE" VARCHAR(100),
  "PERIOD3_PARAM" VARCHAR(100),
  "PERIOD3_DATE" BIGINT,
  "PERIOD4_MODE" VARCHAR(100),
  "PERIOD4_PARAM" VARCHAR(100),
  "PERIOD4_DATE" BIGINT,
  "PERIOD5_MODE" VARCHAR(100),
  "PERIOD5_PARAM" VARCHAR(100),
  "PERIOD5_DATE" BIGINT
);

CREATE TABLE "SCHEMA_MIGRATIONS" (
"VERSION" VARCHAR(256) NOT NULL
);

CREATE TABLE "GROUP_ROLES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "GROUP_ID" INTEGER,
  "RESOURCE_ID" INTEGER,
  "ROLE" VARCHAR(64) NOT NULL
);

CREATE TABLE "RULES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PLUGIN_RULE_KEY" VARCHAR(200) NOT NULL,
  "PLUGIN_NAME" VARCHAR(255) NOT NULL,
  "DESCRIPTION" VARCHAR(16777215),
  "DESCRIPTION_FORMAT" VARCHAR(20),
  "PRIORITY" INTEGER,
  "IS_TEMPLATE" BOOLEAN DEFAULT FALSE,
  "TEMPLATE_ID" INTEGER,
  "PLUGIN_CONFIG_KEY" VARCHAR(500),
  "NAME" VARCHAR(200),
  "STATUS" VARCHAR(40),
  "LANGUAGE" VARCHAR(20),
  "NOTE_DATA" CLOB(2147483647),
  "NOTE_USER_LOGIN" VARCHAR(255),
  "NOTE_CREATED_AT" TIMESTAMP,
  "NOTE_UPDATED_AT" TIMESTAMP,
  "CHARACTERISTIC_ID" INTEGER,
  "DEFAULT_CHARACTERISTIC_ID" INTEGER,
  "REMEDIATION_FUNCTION" VARCHAR(20),
  "DEFAULT_REMEDIATION_FUNCTION" VARCHAR(20),
  "REMEDIATION_COEFF" VARCHAR(20),
  "DEFAULT_REMEDIATION_COEFF" VARCHAR(20),
  "REMEDIATION_OFFSET" VARCHAR(20),
  "DEFAULT_REMEDIATION_OFFSET" VARCHAR(20),
  "EFFORT_TO_FIX_DESCRIPTION" VARCHAR(4000),
  "TAGS" VARCHAR(4000),
  "SYSTEM_TAGS" VARCHAR(4000),
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP,
  "CREATED_AT_MS" BIGINT,
  "UPDATED_AT_MS" BIGINT
);


CREATE TABLE "WIDGET_PROPERTIES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "WIDGET_ID" INTEGER NOT NULL,
  "KEE" VARCHAR(100),
  "TEXT_VALUE" VARCHAR(4000)
);

CREATE TABLE "EVENTS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "NAME" VARCHAR(400),
  "COMPONENT_UUID" VARCHAR(50),
  "SNAPSHOT_ID" INTEGER,
  "CATEGORY" VARCHAR(50),
  "EVENT_DATE" BIGINT NOT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "DESCRIPTION" VARCHAR(4000),
  "EVENT_DATA"  VARCHAR(4000)
);

CREATE TABLE "QUALITY_GATES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "NAME" VARCHAR(100) NOT NULL,
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP,
);

CREATE TABLE "QUALITY_GATE_CONDITIONS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "QGATE_ID" INTEGER,
  "METRIC_ID" INTEGER,
  "OPERATOR" VARCHAR(3),
  "VALUE_ERROR" VARCHAR(64),
  "VALUE_WARNING" VARCHAR(64),
  "PERIOD" INTEGER,
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP,
);

CREATE TABLE "PROPERTIES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PROP_KEY" VARCHAR(512),
  "RESOURCE_ID" INTEGER,
  "TEXT_VALUE" CLOB(2147483647),
  "USER_ID" INTEGER
);

CREATE TABLE "PROJECT_LINKS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "COMPONENT_UUID" VARCHAR(50),
  "LINK_TYPE" VARCHAR(20),
  "NAME" VARCHAR(128),
  "HREF" VARCHAR(2048) NOT NULL
);

CREATE TABLE "DUPLICATIONS_INDEX" (
  "ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PROJECT_SNAPSHOT_ID" INTEGER NOT NULL,
  "SNAPSHOT_ID" INTEGER NOT NULL,
  "HASH" VARCHAR(50) NOT NULL,
  "INDEX_IN_FILE" INTEGER NOT NULL,
  "START_LINE" INTEGER NOT NULL,
  "END_LINE" INTEGER NOT NULL
);

CREATE TABLE "PROJECT_MEASURES" (
  "ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "VALUE" DOUBLE,
  "METRIC_ID" INTEGER NOT NULL,
  "SNAPSHOT_ID" INTEGER,
  "RULE_ID" INTEGER,
  "RULES_CATEGORY_ID" INTEGER,
  "TEXT_VALUE" VARCHAR(4000),
  "TENDENCY" INTEGER,
  "MEASURE_DATE" TIMESTAMP,
  "PROJECT_ID" INTEGER,
  "ALERT_STATUS" VARCHAR(5),
  "ALERT_TEXT" VARCHAR(4000),
  "URL" VARCHAR(2000),
  "DESCRIPTION" VARCHAR(4000),
  "RULE_PRIORITY" INTEGER,
  "CHARACTERISTIC_ID" INTEGER,
  "PERSON_ID" INTEGER,
  "VARIATION_VALUE_1" DOUBLE,
  "VARIATION_VALUE_2" DOUBLE,
  "VARIATION_VALUE_3" DOUBLE,
  "VARIATION_VALUE_4" DOUBLE,
  "VARIATION_VALUE_5" DOUBLE,
  "MEASURE_DATA" BINARY(167772150)
);

CREATE TABLE "PROJECTS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "KEE" VARCHAR(400),
  "ROOT_ID" INTEGER,
  "UUID" VARCHAR(50),
  "PROJECT_UUID" VARCHAR(50),
  "MODULE_UUID" VARCHAR(50),
  "MODULE_UUID_PATH" VARCHAR(4000),
  "NAME" VARCHAR(2000),
  "DESCRIPTION" VARCHAR(2000),
  "ENABLED" BOOLEAN NOT NULL DEFAULT TRUE,
  "SCOPE" VARCHAR(3),
  "QUALIFIER" VARCHAR(10),
  "DEPRECATED_KEE" VARCHAR(400),
  "PATH" VARCHAR(2000),
  "LANGUAGE" VARCHAR(20),
  "COPY_RESOURCE_ID" INTEGER,
  "LONG_NAME" VARCHAR(2000),
  "PERSON_ID" INTEGER,
  "CREATED_AT" TIMESTAMP,
  "AUTHORIZATION_UPDATED_AT" BIGINT
);

CREATE TABLE "MANUAL_MEASURES" (
  "ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "METRIC_ID" INTEGER NOT NULL,
  "COMPONENT_UUID" VARCHAR(50),
  "VALUE" DOUBLE,
  "TEXT_VALUE" VARCHAR(4000),
  "USER_LOGIN" VARCHAR(255),
  "DESCRIPTION" VARCHAR(4000),
  "CREATED_AT" BIGINT,
  "UPDATED_AT" BIGINT
);

CREATE TABLE "ACTIVE_RULES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PROFILE_ID" INTEGER NOT NULL,
  "RULE_ID" INTEGER NOT NULL,
  "FAILURE_LEVEL" INTEGER NOT NULL,
  "INHERITANCE" VARCHAR(10),
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);

CREATE TABLE "NOTIFICATIONS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "DATA" BLOB(167772150)
);

CREATE TABLE "USER_ROLES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "USER_ID" INTEGER,
  "RESOURCE_ID" INTEGER,
  "ROLE" VARCHAR(64) NOT NULL
);

CREATE TABLE "ACTIVE_DASHBOARDS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "DASHBOARD_ID" INTEGER NOT NULL,
  "USER_ID" INTEGER,
  "ORDER_INDEX" INTEGER
);

CREATE TABLE "ACTIVE_RULE_PARAMETERS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "ACTIVE_RULE_ID" INTEGER NOT NULL,
  "RULES_PARAMETER_ID" INTEGER NOT NULL,
  "RULES_PARAMETER_KEY" VARCHAR(128),
  "VALUE" VARCHAR(4000)
);

CREATE TABLE "USERS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "LOGIN" VARCHAR(255),
  "NAME" VARCHAR(200),
  "EMAIL" VARCHAR(100),
  "CRYPTED_PASSWORD" VARCHAR(40),
  "SALT" VARCHAR(40),
  "REMEMBER_TOKEN" VARCHAR(500),
  "REMEMBER_TOKEN_EXPIRES_AT" TIMESTAMP,
  "ACTIVE" BOOLEAN DEFAULT TRUE,
  "SCM_ACCOUNTS" VARCHAR(4000),
  "EXTERNAL_IDENTITY" VARCHAR(255),
  "EXTERNAL_IDENTITY_PROVIDER" VARCHAR(100),
  "CREATED_AT" BIGINT,
  "UPDATED_AT" BIGINT
);

CREATE TABLE "DASHBOARDS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "USER_ID" INTEGER,
  "NAME" VARCHAR(256),
  "DESCRIPTION" VARCHAR(1000),
  "COLUMN_LAYOUT" VARCHAR(20),
  "SHARED" BOOLEAN,
  "IS_GLOBAL" BOOLEAN,
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);

CREATE TABLE "METRICS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "NAME" VARCHAR(64) NOT NULL,
  "DESCRIPTION" VARCHAR(255),
  "DIRECTION" INTEGER NOT NULL DEFAULT 0,
  "DOMAIN" VARCHAR(64),
  "SHORT_NAME" VARCHAR(64),
  "QUALITATIVE" BOOLEAN NOT NULL DEFAULT FALSE,
  "VAL_TYPE" VARCHAR(8),
  "USER_MANAGED" BOOLEAN DEFAULT FALSE,
  "ENABLED" BOOLEAN DEFAULT TRUE,
  "WORST_VALUE" DOUBLE,
  "BEST_VALUE" DOUBLE,
  "OPTIMIZED_BEST_VALUE" BOOLEAN,
  "HIDDEN" BOOLEAN,
  "DELETE_HISTORICAL_DATA" BOOLEAN,
  "DECIMAL_SCALE" INTEGER
);

CREATE TABLE "LOADED_TEMPLATES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "KEE" VARCHAR(200),
  "TEMPLATE_TYPE" VARCHAR(15)
);

CREATE TABLE "RESOURCE_INDEX" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "KEE" VARCHAR(400) NOT NULL,
  "POSITION" INTEGER NOT NULL,
  "NAME_SIZE" INTEGER NOT NULL,
  "RESOURCE_ID" INTEGER NOT NULL,
  "ROOT_PROJECT_ID" INTEGER NOT NULL,
  "QUALIFIER" VARCHAR(10) NOT NULL
);

CREATE TABLE "ACTION_PLANS" (
  "ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "KEE" VARCHAR(100),
  "NAME" VARCHAR(200),
  "DESCRIPTION" VARCHAR(1000),
  "DEADLINE" TIMESTAMP,
  "USER_LOGIN" VARCHAR(255),
  "PROJECT_ID" INTEGER,
  "STATUS" VARCHAR(10),
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);

CREATE TABLE "AUTHORS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PERSON_ID" INTEGER,
  "LOGIN" VARCHAR(100),
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);

CREATE TABLE "MEASURE_FILTERS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "NAME" VARCHAR(100) NOT NULL,
  "SHARED" BOOLEAN NOT NULL DEFAULT FALSE,
  "USER_ID" INTEGER,
  "DESCRIPTION" VARCHAR(4000),
  "DATA" CLOB(2147483647),
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);

CREATE TABLE "MEASURE_FILTER_FAVOURITES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "USER_ID" INTEGER NOT NULL,
  "MEASURE_FILTER_ID" INTEGER NOT NULL,
  "CREATED_AT" TIMESTAMP
);

CREATE TABLE "ISSUES" (
  "ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "KEE" VARCHAR(50) UNIQUE NOT NULL,
  "COMPONENT_UUID" VARCHAR(50),
  "PROJECT_UUID" VARCHAR(50),
  "RULE_ID" INTEGER,
  "SEVERITY" VARCHAR(10),
  "MANUAL_SEVERITY" BOOLEAN NOT NULL,
  "MESSAGE" VARCHAR(4000),
  "LINE" INTEGER,
  "EFFORT_TO_FIX" DOUBLE,
  "TECHNICAL_DEBT" INTEGER,
  "STATUS" VARCHAR(20),
  "RESOLUTION" VARCHAR(20),
  "CHECKSUM" VARCHAR(1000),
  "REPORTER" VARCHAR(255),
  "ASSIGNEE" VARCHAR(255),
  "AUTHOR_LOGIN" VARCHAR(255),
  "ACTION_PLAN_KEY" VARCHAR(50) NULL,
  "ISSUE_ATTRIBUTES" VARCHAR(4000),
  "TAGS" VARCHAR(4000),
  "ISSUE_CREATION_DATE" BIGINT,
  "ISSUE_CLOSE_DATE" BIGINT,
  "ISSUE_UPDATE_DATE" BIGINT,
  "CREATED_AT" BIGINT,
  "UPDATED_AT" BIGINT,
  "LOCATIONS" BLOB(167772150),
);

CREATE TABLE "ISSUE_CHANGES" (
  "ID" BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "KEE" VARCHAR(50),
  "ISSUE_KEY" VARCHAR(50) NOT NULL,
  "USER_LOGIN" VARCHAR(255),
  "CHANGE_TYPE" VARCHAR(40),
  "CHANGE_DATA"  VARCHAR(16777215),
  "CREATED_AT" BIGINT,
  "UPDATED_AT" BIGINT,
  "ISSUE_CHANGE_CREATION_DATE" BIGINT
);

CREATE TABLE "ISSUE_FILTERS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "NAME" VARCHAR(100) NOT NULL,
  "SHARED" BOOLEAN NOT NULL DEFAULT FALSE,
  "USER_LOGIN" VARCHAR(255),
  "DESCRIPTION" VARCHAR(4000),
  "DATA" CLOB(2147483647),
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);

CREATE TABLE "ISSUE_FILTER_FAVOURITES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "USER_LOGIN" VARCHAR(255)  NOT NULL,
  "ISSUE_FILTER_ID" INTEGER NOT NULL,
  "CREATED_AT" TIMESTAMP
);

CREATE TABLE "PERMISSION_TEMPLATES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "NAME" VARCHAR(100) NOT NULL,
  "KEE" VARCHAR(100) NOT NULL,
  "DESCRIPTION" VARCHAR(4000),
  "KEY_PATTERN" VARCHAR(500),
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);

CREATE TABLE "PERM_TEMPLATES_USERS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "USER_ID" INTEGER NOT NULL,
  "TEMPLATE_ID" INTEGER NOT NULL,
  "PERMISSION_REFERENCE" VARCHAR(64) NOT NULL,
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);

CREATE TABLE "PERM_TEMPLATES_GROUPS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "GROUP_ID" INTEGER,
  "TEMPLATE_ID" INTEGER NOT NULL,
  "PERMISSION_REFERENCE" VARCHAR(64) NOT NULL,
  "CREATED_AT" TIMESTAMP,
  "UPDATED_AT" TIMESTAMP
);


CREATE TABLE "ACTIVITIES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "LOG_KEY" VARCHAR(250),
  "CREATED_AT" TIMESTAMP,
  "USER_LOGIN" VARCHAR(30),
  "LOG_TYPE" VARCHAR(250),
  "LOG_ACTION" VARCHAR(250),
  "LOG_MESSAGE" VARCHAR(250),
  "DATA_FIELD" CLOB(2147483647)
);

CREATE TABLE "FILE_SOURCES" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "PROJECT_UUID" VARCHAR(50) NOT NULL,
  "FILE_UUID" VARCHAR(50) NOT NULL,
  "LINE_HASHES" CLOB(2147483647),
  "BINARY_DATA" BLOB(167772150),
  "DATA_TYPE" VARCHAR(20),
  "DATA_HASH" VARCHAR(50),
  "SRC_HASH" VARCHAR(50),
  "REVISION" VARCHAR(100),
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);

CREATE TABLE "CE_QUEUE" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "UUID" VARCHAR(40) NOT NULL,
  "TASK_TYPE" VARCHAR(15) NOT NULL,
  "COMPONENT_UUID" VARCHAR(40) NULL,
  "STATUS" VARCHAR(15) NOT NULL,
  "SUBMITTER_LOGIN" VARCHAR(255) NULL,
  "STARTED_AT" BIGINT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL
);

CREATE TABLE "CE_ACTIVITY" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "UUID" VARCHAR(40) NOT NULL,
  "TASK_TYPE" VARCHAR(15) NOT NULL,
  "COMPONENT_UUID" VARCHAR(40) NULL,
  "SNAPSHOT_ID" INTEGER NULL,
  "STATUS" VARCHAR(15) NOT NULL,
  "IS_LAST" BOOLEAN NOT NULL,
  "IS_LAST_KEY" VARCHAR(55) NOT NULL,
  "SUBMITTER_LOGIN" VARCHAR(255) NULL,
  "SUBMITTED_AT" BIGINT NOT NULL,
  "STARTED_AT" BIGINT NULL,
  "EXECUTED_AT" BIGINT NULL,
  "CREATED_AT" BIGINT NOT NULL,
  "UPDATED_AT" BIGINT NOT NULL,
  "EXECUTION_TIME_MS" BIGINT NULL
);

CREATE TABLE "USER_TOKENS" (
  "ID" INTEGER NOT NULL GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
  "LOGIN" VARCHAR(255) NOT NULL,
  "NAME" VARCHAR(100) NOT NULL,
  "TOKEN_HASH" VARCHAR(255) NOT NULL,
  "CREATED_AT" BIGINT NOT NULL
);

-- ----------------------------------------------
-- DDL Statements for indexes
-- ----------------------------------------------

CREATE UNIQUE INDEX "ACTIVITIES_LOG_KEY" ON "ACTIVITIES" ("LOG_KEY");

CREATE INDEX "GROUP_ROLES_RESOURCE" ON "GROUP_ROLES" ("RESOURCE_ID");

CREATE INDEX "GROUP_ROLES_GROUP" ON "GROUP_ROLES" ("GROUP_ID");

CREATE INDEX "USER_ROLES_RESOURCE" ON "USER_ROLES" ("RESOURCE_ID");

CREATE INDEX "USER_ROLES_USER" ON "USER_ROLES" ("USER_ID");

CREATE INDEX "DUPLICATIONS_INDEX_HASH" ON "DUPLICATIONS_INDEX" ("HASH");

CREATE INDEX "DUPLICATIONS_INDEX_SID" ON "DUPLICATIONS_INDEX" ("SNAPSHOT_ID");

CREATE INDEX "DUPLICATIONS_INDEX_PSID" ON "DUPLICATIONS_INDEX" ("PROJECT_SNAPSHOT_ID");

CREATE INDEX "INDEX_GROUPS_USERS_ON_GROUP_ID" ON "GROUPS_USERS" ("GROUP_ID");

CREATE INDEX "INDEX_GROUPS_USERS_ON_USER_ID" ON "GROUPS_USERS" ("USER_ID");

CREATE UNIQUE INDEX "GROUPS_USERS_UNIQUE" ON "GROUPS_USERS" ("GROUP_ID", "USER_ID");

CREATE INDEX "MEASURES_SID_METRIC" ON "PROJECT_MEASURES" ("SNAPSHOT_ID", "METRIC_ID");

CREATE INDEX "MEASURES_PERSON" ON "PROJECT_MEASURES" ("PERSON_ID");

CREATE UNIQUE INDEX "METRICS_UNIQUE_NAME" ON "METRICS" ("NAME");

CREATE INDEX "EVENTS_SNAPSHOT_ID" ON "EVENTS" ("SNAPSHOT_ID");

CREATE INDEX "EVENTS_COMPONENT_UUID" ON "EVENTS" ("COMPONENT_UUID");

CREATE INDEX "WIDGETS_WIDGETKEY" ON "WIDGETS" ("WIDGET_KEY");

CREATE INDEX "WIDGETS_DASHBOARDS" ON "WIDGETS" ("DASHBOARD_ID");

CREATE INDEX "SNAPSHOTS_QUALIFIER" ON "SNAPSHOTS" ("QUALIFIER");

CREATE INDEX "SNAPSHOTS_ROOT" ON "SNAPSHOTS" ("ROOT_SNAPSHOT_ID");

CREATE INDEX "SNAPSHOTS_PARENT" ON "SNAPSHOTS" ("PARENT_SNAPSHOT_ID");

CREATE INDEX "SNAPSHOT_PROJECT_ID" ON "SNAPSHOTS" ("PROJECT_ID");

CREATE INDEX "RULES_PARAMETERS_RULE_ID" ON "RULES_PARAMETERS" ("RULE_ID");

CREATE INDEX "ACTIVE_DASHBOARDS_DASHBOARDID" ON "ACTIVE_DASHBOARDS" ("DASHBOARD_ID");

CREATE INDEX "ACTIVE_DASHBOARDS_USERID" ON "ACTIVE_DASHBOARDS" ("USER_ID");

CREATE INDEX "UNIQUE_SCHEMA_MIGRATIONS" ON "SCHEMA_MIGRATIONS" ("VERSION");

CREATE INDEX "WIDGET_PROPERTIES_WIDGETS" ON "WIDGET_PROPERTIES" ("WIDGET_ID");

CREATE INDEX "PROPERTIES_KEY" ON "PROPERTIES" ("PROP_KEY");

CREATE INDEX "MANUAL_MEASURES_COMPONENT_UUID" ON "MANUAL_MEASURES" ("COMPONENT_UUID");

CREATE UNIQUE INDEX "PROJECTS_KEE" ON "PROJECTS" ("KEE");

CREATE INDEX "PROJECTS_ROOT_ID" ON "PROJECTS" ("ROOT_ID");

CREATE UNIQUE INDEX "PROJECTS_UUID" ON "PROJECTS" ("UUID");

CREATE INDEX "PROJECTS_PROJECT_UUID" ON "PROJECTS" ("PROJECT_UUID");

CREATE INDEX "PROJECTS_MODULE_UUID" ON "PROJECTS" ("MODULE_UUID");

CREATE INDEX "PROJECTS_QUALIFIER" ON "PROJECTS" ("QUALIFIER");

CREATE INDEX "RESOURCE_INDEX_KEY" ON "RESOURCE_INDEX" ("KEE");

CREATE INDEX "RESOURCE_INDEX_RID" ON "RESOURCE_INDEX" ("RESOURCE_ID");

CREATE INDEX "INDEX_ACTION_PLANS_ON_PROJET_ID" ON "ACTION_PLANS" ("PROJECT_ID");

CREATE UNIQUE INDEX "UNIQ_AUTHOR_LOGINS" ON "AUTHORS" ("LOGIN");

CREATE INDEX "MEASURE_FILTERS_NAME" ON "MEASURE_FILTERS" ("NAME");

CREATE INDEX "MEASURE_FILTER_FAVS_USERID" ON "MEASURE_FILTER_FAVOURITES" ("USER_ID");

CREATE UNIQUE INDEX "ISSUES_KEE" ON "ISSUES" ("KEE");

CREATE INDEX "ISSUES_COMPONENT_UUID" ON "ISSUES" ("COMPONENT_UUID");

CREATE INDEX "ISSUES_PROJECT_UUID" ON "ISSUES" ("PROJECT_UUID");

CREATE INDEX "ISSUES_RULE_ID" ON "ISSUES" ("RULE_ID");

CREATE INDEX "ISSUES_SEVERITY" ON "ISSUES" ("SEVERITY");

CREATE INDEX "ISSUES_STATUS" ON "ISSUES" ("STATUS");

CREATE INDEX "ISSUES_RESOLUTION" ON "ISSUES" ("RESOLUTION");

CREATE INDEX "ISSUES_ASSIGNEE" ON "ISSUES" ("ASSIGNEE");

CREATE INDEX "ISSUES_ACTION_PLAN_KEY" ON "ISSUES" ("ACTION_PLAN_KEY");

CREATE INDEX "ISSUES_CREATION_DATE" ON "ISSUES" ("ISSUE_CREATION_DATE");

CREATE INDEX "ISSUES_UPDATED_AT" ON "ISSUES" ("UPDATED_AT");

CREATE INDEX "ISSUE_CHANGES_KEE" ON "ISSUE_CHANGES" ("KEE");

CREATE INDEX "ISSUE_CHANGES_ISSUE_KEY" ON "ISSUE_CHANGES" ("ISSUE_KEY");

CREATE INDEX "ISSUE_FILTERS_NAME" ON "ISSUE_FILTERS" ("NAME");

CREATE INDEX "ISSUE_FILTER_FAVS_USER" ON "ISSUE_FILTER_FAVOURITES" ("USER_LOGIN");

CREATE UNIQUE INDEX "USERS_LOGIN" ON "USERS" ("LOGIN");

CREATE INDEX "USERS_UPDATED_AT" ON "USERS" ("UPDATED_AT");

CREATE INDEX "SNAPSHOTS_ROOT_PROJECT_ID" ON "SNAPSHOTS" ("ROOT_PROJECT_ID");

CREATE INDEX "GROUP_ROLES_ROLE" ON "GROUP_ROLES" ("ROLE");

CREATE UNIQUE INDEX "UNIQ_GROUP_ROLES" ON "GROUP_ROLES" ("GROUP_ID", "RESOURCE_ID", "ROLE");

CREATE UNIQUE INDEX "RULES_REPO_KEY" ON "RULES" ("PLUGIN_NAME", "PLUGIN_RULE_KEY");

CREATE UNIQUE INDEX "UNIQ_QUALITY_GATES" ON "QUALITY_GATES" ("NAME");

CREATE UNIQUE INDEX "ACTIVE_RULES_UNIQUE" ON "ACTIVE_RULES" ("PROFILE_ID","RULE_ID");

CREATE UNIQUE INDEX "UNIQ_QPROF_KEY" ON "RULES_PROFILES" ("KEE");

CREATE INDEX "FILE_SOURCES_PROJECT_UUID" ON "FILE_SOURCES" ("PROJECT_UUID");

CREATE UNIQUE INDEX "FILE_SOURCES_UUID_TYPE" ON "FILE_SOURCES" ("FILE_UUID", "DATA_TYPE");

CREATE INDEX "FILE_SOURCES_UPDATED_AT" ON "FILE_SOURCES" ("UPDATED_AT");

CREATE UNIQUE INDEX "UNIQ_PROJECT_QPROFILES" ON "PROJECT_QPROFILES" ("PROJECT_UUID", "PROFILE_KEY");

CREATE UNIQUE INDEX "CE_QUEUE_UUID" ON "CE_QUEUE" ("UUID");

CREATE INDEX "CE_QUEUE_COMPONENT_UUID" ON "CE_QUEUE" ("COMPONENT_UUID");

CREATE UNIQUE INDEX "CE_ACTIVITY_UUID" ON "CE_ACTIVITY" ("UUID");

CREATE INDEX "CE_ACTIVITY_COMPONENT_UUID" ON "CE_ACTIVITY" ("COMPONENT_UUID");

CREATE UNIQUE INDEX "USER_TOKENS_TOKEN_HASH" ON "USER_TOKENS" ("TOKEN_HASH");

CREATE UNIQUE INDEX "USER_TOKENS_LOGIN_NAME" ON "USER_TOKENS" ("LOGIN", "NAME");

CREATE INDEX "CE_ACTIVITY_ISLASTKEY" ON "CE_ACTIVITY" ("IS_LAST_KEY");
