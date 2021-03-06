USE Lab_1
GO
CREATE TABLE BOOKS(
  ID INTEGER PRIMARY KEY IDENTITY(1,1),
  "NAME" VARCHAR(50) NOT NULL,
  AUTHOR_ID INTEGER NOT NULL,
  ID_PUBLICATION_INFO INTEGER NOT NULL,
  ID_TYPOGRAPHY INTEGER NOT NULL,
  PRICE INTEGER NOT NULL,
  CHECK(LEN("NAME") > 3),
  CHECK(PRICE > 0),
  FOREIGN KEY (AUTHOR_ID) REFERENCES AUTHORS(ID),
  FOREIGN KEY (ID_TYPOGRAPHY) REFERENCES TYPOGRAPHY(ID),
  FOREIGN KEY (ID_PUBLICATION_INFO) REFERENCES PUBLISHING_INFO(ID)
);
GO

INSERT INTO BOOKS ("NAME", AUTHOR_ID, ID_PUBLICATION_INFO, ID_TYPOGRAPHY, PRICE) VALUES ('ASDAA', 1,1,2,100)
GO

UPDATE BOOKS SET "NAME" = 'ASDAASDA' WHERE ID = 1
GO

SELECT * FROM ACTIONS_LOG
GO

CREATE INDEX id_author_books ON BOOKS(AUTHOR_ID);
GO

CREATE INDEX id_publication_info_books ON BOOKS(ID_PUBLICATION_INFO);
GO

CREATE INDEX id_typography_books ON BOOKS(ID_TYPOGRAPHY);
GO

CREATE INDEX author_id_price_books ON BOOKS(AUTHOR_ID, PRICE);
GO

CREATE TRIGGER BOOKS_TRIGGER_INSERT
ON BOOKS
AFTER INSERT
AS
INSERT INTO ACTIONS_LOG (TABLE_NAME, ACTION_NAME) VALUES('BOOKS', 'INSERT');
GO


CREATE TRIGGER BOOKS_TRIGGER_UPDATE
ON BOOKS
AFTER UPDATE
AS
INSERT INTO ACTIONS_LOG (TABLE_NAME, ACTION_NAME) VALUES('BOOKS', 'UPDATE');
GO


CREATE TRIGGER BOOKS_TRIGGER_DELETE
ON BOOKS
AFTER DELETE
AS
INSERT INTO ACTIONS_LOG (TABLE_NAME, ACTION_NAME) VALUES('BOOKS', 'DELETE');
GO


CREATE VIEW VW_BOOKS
AS
SELECT ID, "NAME", AUTHOR_ID, ID_PUBLICATION_INFO, ID_TYPOGRAPHY, PRICE
FROM BOOKS;
GO

CREATE PROCEDURE INSERT_BOOK
    @NAME VARCHAR(50),
	@AUTHOR_ID INTEGER,
	@ID_PUBLICATION_INFO INTEGER,
	@ID_TYPOGRAPHY INTEGER,
	@PRICE INTEGER
WITH RECOMPILE    
AS  
    BEGIN TRY
       INSERT INTO BOOKS("NAME", AUTHOR_ID, ID_PUBLICATION_INFO, ID_TYPOGRAPHY,PRICE)
	    VALUES(@NAME, @AUTHOR_ID, @ID_PUBLICATION_INFO, @ID_TYPOGRAPHY, @PRICE)
    END TRY
	BEGIN CATCH
	   SELECT ERROR_MESSAGE() AS ERROR_MESSAGE;
	END CATCH
GO

CREATE PROCEDURE UPDATE_BOOK
    @ID INTEGER,
    @NAME VARCHAR(50),
	@AUTHOR_ID INTEGER,
	@ID_PUBLICATION_INFO INTEGER,
	@ID_TYPOGRAPHY INTEGER,
	@PRICE INTEGER
WITH RECOMPILE    
AS  
    BEGIN TRY
	IF @NAME != '' AND @NAME IS NOT NULL
	BEGIN
       UPDATE BOOKS SET "NAME" = @NAME WHERE ID = @ID
	END
    IF @AUTHOR_ID > 0 AND @AUTHOR_ID IS NOT NULL
	BEGIN
       UPDATE BOOKS SET AUTHOR_ID = @AUTHOR_ID WHERE ID = @ID
	END
	IF @ID_PUBLICATION_INFO > 0 AND @ID_PUBLICATION_INFO IS NOT NULL
	BEGIN
       UPDATE BOOKS SET ID_PUBLICATION_INFO = @ID_PUBLICATION_INFO WHERE ID = @ID
	END
	IF @ID_TYPOGRAPHY > 0 AND @ID_TYPOGRAPHY IS NOT NULL
	BEGIN
       UPDATE BOOKS SET ID_TYPOGRAPHY = @ID_TYPOGRAPHY WHERE ID = @ID
	END
	IF @PRICE > 0 AND @PRICE IS NOT NULL
	BEGIN
       UPDATE BOOKS SET PRICE = @PRICE WHERE ID = @ID
	END
    END TRY
	BEGIN CATCH
	   SELECT ERROR_MESSAGE() AS ERROR_MESSAGE;
	END CATCH
GO

CREATE PROCEDURE SELECT_BOOKS
WITH RECOMPILE    
AS  
    BEGIN TRY
       SELECT * FROM VW_BOOKS;
	   RETURN;
    END TRY
	BEGIN CATCH
	   SELECT ERROR_MESSAGE() AS ERROR_MESSAGE;
	END CATCH
GO

CREATE PROCEDURE DELETE_BOOKS
    @ID INTEGER
WITH RECOMPILE    
AS  
    BEGIN TRY
       DELETE BOOKS WHERE ID = @ID
    END TRY
	BEGIN CATCH
	   SELECT ERROR_MESSAGE() AS ERROR_MESSAGE;
	END CATCH
GO
