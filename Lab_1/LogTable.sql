USE Lab_1
GO
CREATE TABLE ACTIONS_LOG(
 ID INTEGER PRIMARY KEY IDENTITY(1,1),
 TABLE_NAME VARCHAR(50) NOT NULL,
 ACTION_NAME VARCHAR(20) NOT NULL,
);
GO