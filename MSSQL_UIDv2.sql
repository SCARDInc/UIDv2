/* MS SQL Stored Procedure: GenerateUIDv2
 * Part of the SCARDInc/UIDv2 Project
 * Version 1.0.0
 */

-- The following is the SQL code example to call the stored procedure `GenerateUIDv2` and return the UID: AEWEHOBB2B12659941
EXEC database.GenerateUIDv2 @LastName ='HAWKE', @FirstName = 'Bob', @DateOfBirth = '1929-05-16', @Sex = 1;

-- The following is the SQL code to create the stored procedure `GenerateUIDv2`:
CREATE PROCEDURE database.GenerateUIDv2 @LastName VARCHAR(64), @FirstName VARCHAR (64), @DateOfBirth DATE, @Sex CHAR(1)
AS
    -- Process LastName
    DECLARE @Char1 CHAR (1) = '2';
    DECLARE @Char2 CHAR (1) = RIGHT(@LastName, 1);
    DECLARE @Char3 CHAR (1) = '2';
    DECLARE @Char4 CHAR (1) = '2';
    DECLARE @Char5 CHAR (1) = SUBSTRING(@LastName, 1, 1);

    IF LEN(@LastName) >= 2
        SET @Char1 = SUBSTRING(@LastName, 2, 1);

    IF LEN(@LastName) >= 3
        SET @Char3 = SUBSTRING(@LastName, 3, 1);

    IF LEN(@LastName) >= 5
        SET @Char4 = SUBSTRING(@LastName, 5, 1);

    -- Process FirstName
    DECLARE @Char6 CHAR (1) = '2';
    DECLARE @Char7 CHAR (1) = RIGHT(@FirstName, 1);
    DECLARE @Char8 CHAR (1) = '2';
    DECLARE @Char9 CHAR (1) = '2';
    DECLARE @Char10 CHAR (1) = SUBSTRING(@FirstName, 1, 1);

    IF LEN(@FirstName) >= 2
        SET @Char6 = SUBSTRING(@FirstName, 2, 1);

    IF LEN(@FirstName) >= 3
        SET @Char8 = SUBSTRING(@FirstName, 3, 1);

    IF LEN(@FirstName) >= 5
        SET @Char9 = SUBSTRING(@FirstName, 5, 1);

    -- Process DateOfBirth
    DECLARE @Date1 CHAR (7) = FORMAT(CAST(REPLACE(@DateOfBirth, '-', '') AS INT), 'X');

    -- Return UID
    SELECT UPPER(CONCAT(@Char1, @Char2, @Char3, @Char4, @Char5, @Char6, @Char7, @Char8, @Char9, @Char10, @Date1, @Sex)) AS 'UID';

-- End of SQL code for stored procedure `GenerateUIDv2`