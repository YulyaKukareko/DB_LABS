EXEC GetAddress @DATE_PARAM = '2019-02-02';

EXEC sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO

CREATE ASSEMBLY Lab_3 FROM 'D:\Univer\Lab_3.dll';
GO
CREATE PROCEDURE GetAddress @DATE_PARAM datetime
as
external name Lab_3.StoredProcedures.GetAddress;
go