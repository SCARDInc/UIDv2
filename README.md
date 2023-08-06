## SCARD UIDv2

An updated method to generate Unique IDs for people for deidentified data exchange.

### Introduction
The main goal of deidentification is to protect a person's identity from being disclosed while still enabling the grouping of records related to that person.

The initial approach used a formula based on a person's name, which included using the first five letters of the name, date of birth, and sex. This resulted in a 14-character identifier for everyone based on the UID Version 1 Algorithm.

To import records into the SCARD Surgical Audit, this UID was the primary method of matching deidentified records to a person without the need of manual entry.

### UID Collision
As the number of records in SCARD databases increased, UID "collisions" have arisen where multiple people can be assigned the same UID due to the limited characters used when calculating the identifier. Automated record importing involving duplicate UIDs is prevented and is deferred for manual entry.

### SCARD UID Version 2 (UIDv2)
To address the issue of collisions, Version 2 of the SCARD UID formula was introduced. It utilizes 5 characters for both the first and last names and obfuscates the date of birth as hexadecimal, resulting in an 18-character identifier per person.

### Text Format
If you are using a Unicode set with accented characters, these **MUST** be normalised to ASCII/Latin characters before generating a UID.

See [anyascii/anyascii](https://github.com/anyascii/anyascii) for examples on stripping Unicode back to ASCII.

For PHP, we recommend [ausi/slug-generator](https://github.com/ausi/slug-generator) to perform this role and have included an example file in this repository. The reason slug-generator is preferred over regex is that it captures characters accurately and is more robust.

### Coding a persons Sex
[ISO/IEC 5218](https://en.wikipedia.org/wiki/ISO/IEC_5218) is used as a reference for coding a persons sex to an integer, and we have updated our terminology to match (originally we used Unknown and Unspecified in place of Not known and Not applicable respectively).

### Repository Contents

- "Official" UIDv2 Specification (UIDv2.pdf)
- MySQL Stored Procedure (MySQL_UIDv2.sql) 
- MS SQL Stored Procedure (MSSQL_UIDv2.sql)
- PHP Function (PHP_UIDv2.php)
- PHP Function with slug-generator (PHP_UIDv2_slug.php)

### License
This is free and unencumbered software released into the public domain. If you improve on this code (which is not out of the question), please consider sharing your changes with us to pass onto the community. 

See the [LICENSE](LICENSE) file for more information.