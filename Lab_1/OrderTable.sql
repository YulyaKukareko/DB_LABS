USE Lab_1
GO
CREATE TABLE ORDERS(
  ID INTEGER PRIMARY KEY IDENTITY(1,1),
  ID_BOOK INTEGER NOT NULL,
  ID_CUSTOMER INTEGER NOT NULL,
  ORDER_DATE DATE NOT NULL,
  FOREIGN KEY (ID_BOOK) REFERENCES BOOKS(ID),
  FOREIGN KEY (ID_CUSTOMER) REFERENCES CUSTOMER(ID)
);
GO

CREATE INDEX id_book_orders ON ORDERS(ID_BOOK);
GO

CREATE INDEX id_customer_orders ON ORDERS(ID_CUSTOMER);
GO

CREATE INDEX id_customer_order_date ON ORDERS(ID_CUSTOMER, ORDER_DATE);
GO

CREATE TRIGGER ORDERS_TRIGGER_INSERT
ON ORDERS
AFTER INSERT
AS
INSERT INTO ACTIONS_LOG (TABLE_NAME, ACTION_NAME) VALUES('ORDERS', 'INSERT');
GO


CREATE TRIGGER ORDERS_TRIGGER_UPDATE
ON ORDERS
AFTER UPDATE
AS
INSERT INTO ACTIONS_LOG (TABLE_NAME, ACTION_NAME) VALUES('ORDERS', 'UPDATE');
GO


CREATE TRIGGER ORDERS_TRIGGER_DELETE
ON ORDERS
AFTER DELETE
AS
INSERT INTO ACTIONS_LOG (TABLE_NAME, ACTION_NAME) VALUES('ORDERS', 'DELETE');
GO


CREATE VIEW VW_ORDERS
AS
SELECT ID, ID_BOOK, ID_CUSTOMER, ORDER_DATE
FROM ORDERS;

CREATE PROCEDURE INSERT_ORDER
    @ID_BOOK INTEGER,
	@ID_CUSTOMER INTEGER,
	@ORDER_DATE DATE
WITH RECOMPILE    
AS  
    BEGIN TRY
	   BEGIN TRANSACTION;
       INSERT INTO ORDERS(ID_BOOK, ID_CUSTOMER, ORDER_DATE)
	   VALUES(@ID_BOOK, @ID_CUSTOMER, @ORDER_DATE)
	   COMMIT TRANSACTION;
    END TRY
	BEGIN CATCH
	   ROLLBACK TRANSACTION;
	   SELECT ERROR_MESSAGE() AS ERROR_MESSAGE;
	END CATCH
GO

CREATE PROCEDURE UPDATE_ORDER
    @ID INTEGER,
    @ID_BOOK INTEGER,
	@ID_CUSTOMER INTEGER,
	@ORDER_DATE DATE
WITH RECOMPILE    
AS  
    BEGIN TRY
	IF @ID_BOOK > 0 AND @ID_BOOK IS NOT NULL
	BEGIN
       UPDATE ORDERS SET ID_BOOK = @ID_BOOK WHERE ID = @ID
	END
    IF @ID_CUSTOMER > 0 AND @ID_CUSTOMER IS NOT NULL
	BEGIN
       UPDATE ORDERS SET ID_CUSTOMER = @ID_CUSTOMER WHERE ID = @ID
	END
	IF @ORDER_DATE != '' AND @ORDER_DATE IS NOT NULL
	BEGIN
       UPDATE ORDERS SET ORDER_DATE = @ORDER_DATE WHERE ID = @ID
	END
    END TRY
	BEGIN CATCH
	   SELECT ERROR_MESSAGE() AS ERROR_MESSAGE;
	END CATCH
GO

CREATE PROCEDURE SELECT_ORDERS
WITH RECOMPILE    
AS  
    BEGIN TRY
       SELECT * FROM VW_ORDERS;
	   RETURN;
    END TRY
	BEGIN CATCH
	   SELECT ERROR_MESSAGE() AS ERROR_MESSAGE;
	END CATCH
GO

CREATE PROCEDURE DELETE_ORDERS
    @ID INTEGER
WITH RECOMPILE    
AS  
    BEGIN TRY
       DELETE ORDERS WHERE ID = @ID
    END TRY
	BEGIN CATCH
	   SELECT ERROR_MESSAGE() AS ERROR_MESSAGE;
	END CATCH
GO