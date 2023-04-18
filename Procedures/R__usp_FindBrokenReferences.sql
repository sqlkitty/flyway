CREATE OR ALTER PROCEDURE dba.usp_FindBrokenReferences
AS
WITH cte AS (
    SELECT
        sed.referencing_id,
        COALESCE(sed.referenced_schema_name + '.', '') + sed.referenced_entity_name AS obj_name
    FROM sys.sql_expression_dependencies sed
    WHERE
        sed.is_ambiguous = 0
        AND sed.referenced_id IS NULL
)

SELECT
    cte.referencing_id,
    QUOTENAME(SCHEMA_NAME(objects.schema_id)) + '.' + QUOTENAME(objects.name) AS obj_name,
    'Invalid object name ''' + cte.obj_name + '''' AS msg,
    objects.[type]
FROM cte
JOIN sys.objects ON cte.referencing_id = objects.[object_id];
GO
