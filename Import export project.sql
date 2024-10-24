CREATE DATABASE import_export;
USE import_export;

CREATE TABLE import_export (
    Transaction_ID VARCHAR(255),
    Country VARCHAR(100),
    Product VARCHAR(255),
    Import_Export VARCHAR(50),
    Shipping_Method VARCHAR(50),
    Port VARCHAR(100),
    Category VARCHAR(100),
    Quantity INT,
    Value DECIMAL(10,2),
    Date VARCHAR(50),
    Customs_Code INT,
    Weight DECIMAL(10,2)
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Imports_Exports_Dataset new.csv'
INTO TABLE import_export
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


# converting Date to DATE format
select Date from import_export;
ALTER TABLE import_export ADD Formatted_Date DATE;

UPDATE import_export
SET Formatted_Date = STR_TO_DATE(Date, '%d-%m-%Y');

SELECT Date, Formatted_Date FROM import_export LIMIT 10;

ALTER TABLE import_export DROP COLUMN Date;
ALTER TABLE import_export CHANGE Formatted_Date Date DATE;

SELECT Date FROM import_export;

#checking for missing values
SELECT * FROM import_export WHERE Country IS NULL OR Product IS NULL;

#checking for duplicate if any remove
SELECT Transaction_ID, COUNT(*) AS duplicate_count
FROM import_export
GROUP BY Transaction_ID
HAVING duplicate_count > 1;


#exploring the data 
select * from import_export;

SELECT SUM(Value) AS Total_Trade_Value, AVG(Quantity) AS Avg_Quantity, SUM(Weight) AS Total_Weight
FROM import_export;

SELECT Country, SUM(Value) AS Total_Trade_Value, AVG(Quantity) AS Avg_Quantity
FROM import_export
GROUP BY Country
ORDER BY Total_Trade_Value DESC;

SELECT YEAR(Date) AS Year, MONTH(Date) AS Month, SUM(Value) AS Total_Trade_Value
FROM import_export
GROUP BY Year, Month
ORDER BY Year, Month;


select * from import_export;
SELECT * 
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Cleaned_Imports_Exports_Dataset_new.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
FROM import_export;


