IF
    NOT EXISTS (
        SELECT *
        FROM sys.schemas
        WHERE name = N'dba'
    )
    EXEC ('CREATE SCHEMA [dba]');
GO
