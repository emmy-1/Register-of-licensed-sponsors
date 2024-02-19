/* CREATE A DATABASE LicensedSponsors */
CREATE DATABASE LicensedSponsors
 COLLATE Latin1_General_100_BIN2_UTF8;
GO

USE LicensedSponsors;
GO

/* Create a password for credential */
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'uNKNOWN'; -- Added semicolon

CREATE DATABASE SCOPED CREDENTIAL Manageid
WITH
    IDENTITY='Managed Identity'; -- Added semicolon
GO

/* CREATE EXTERNAL DATASOURCE */
CREATE EXTERNAL DATA SOURCE sponsor_Data 
WITH (
    LOCATION = 'abfss://ffs@datagen2db.dfs.core.windows.net',
    CREDENTIAL = Manageid
);
GO

/* CREATE AN EXTERNAL FILE FORMAT */
CREATE EXTERNAL FILE FORMAT CsvFormat
    WITH (
        FORMAT_TYPE = DELIMITEDTEXT,
        FORMAT_OPTIONS (
            FIELD_TERMINATOR = ',',
            STRING_DELIMITER = '"'
        )
    );
GO

/* CREATE A SCHEMA */
CREATE SCHEMA Uksponsor; -- Added semicolon

/* CREATE AN EXTERNAL TABLE */

CREATE  EXTERNAL  TABLE [Uksponsor].[sponsors] (
[Organisation Name] varchar(max),
[Town/City] varchar(max),
[County] varchar(max),
[Type & Rating] varchar(max),
[Route] varchar(max)
)
WITH (
LOCATION = 'Register of licensedsponsors/**',
DATA_SOURCE = sponsor_Data,
FILE_FORMAT = CsvFormat
)
GO
