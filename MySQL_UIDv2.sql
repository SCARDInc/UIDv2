/*
 * MySQL Stored Procedure: GenerateUIDv2
 * Part of the SCARDInc/UIDv2 Repository
 * Version 1.0.0
 */

# The following is the SQL code example to call the stored procedure `GenerateUIDv2` and return the UID: AEWEHOBB2B12659941
CALL GenerateUIDv2('HAWKE', 'Bob', '1929-05-16', 1);

# The following is the SQL code to create the stored procedure `GenerateUIDv2`:
DELIMITER $$
CREATE PROCEDURE `GenerateUIDv2`(
    IN `LastName` VARCHAR(64),
    IN `FirstName` VARCHAR(64),
    IN `DateOfBirth` DATE,
    IN `Sex` CHAR(1)
)
BEGIN
    DECLARE strLastName VARCHAR(64);
    DECLARE strFirstName VARCHAR(64);
    DECLARE strDateOfBirth CHAR(7);
    DECLARE intSex CHAR(1);

    SET `strLastName` = REGEXP_REPLACE(LastName, '[^0-9a-zA-Z]', '');
    SET `strFirstName` = REGEXP_REPLACE(FirstName, '[^0-9a-zA-Z]', '');
    SET `strDateOfBirth` =  UCASE(CONV(REGEXP_REPLACE(`DateOfBirth`, '[^0-9]', ''), 10,16));
    SET `intSex` = IF(LENGTH(Sex) = 1, Sex, '9');

    SELECT
        UCASE(
            CONCAT(
                IF(LENGTH(SUBSTRING(`strLastName`, 2, 1)) > 0, SUBSTRING(`strLastName`, 2, 1), '2'),
                SUBSTRING(`strLastName`, -1, 1),
                IF(LENGTH(SUBSTRING(`strLastName`, 3, 1)) > 0, SUBSTRING(`strLastName`, 3, 1), '2'),
                IF(LENGTH(SUBSTRING(`strLastName`, 5, 1)) > 0, SUBSTRING(`strLastName`, 5, 1), '2'),
                SUBSTRING(`strLastName`, 1, 1),
                IF(LENGTH(SUBSTRING(`strFirstName`, 2, 1)) > 0, SUBSTRING(`strFirstName`, 2, 1), '2'),
                SUBSTRING(`strFirstName`, -1, 1),
                IF(LENGTH(SUBSTRING(`strFirstName`, 3, 1)) > 0, SUBSTRING(`strFirstName`, 3, 1), '2'),
                IF(LENGTH(SUBSTRING(`strFirstName`, 5, 1)) > 0, SUBSTRING(`strFirstName`, 5, 1), '2'),
                SUBSTRING(`strFirstName`, 1, 1),
                `strDateOfBirth`,
                `intSex`
                )
            )
        AS `UID`;

END$$
DELIMITER ;

# End of SQL code for stored procedure `GenerateUIDv2`
