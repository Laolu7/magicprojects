CREATE TABLE covid_data (
    entity VARCHAR(255),
    code VARCHAR(3),
    day DATE,
    daily_new_deaths_per_million FLOAT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/covid.csv'
INTO TABLE covid_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(entity, code, day, daily_new_deaths_per_million);

SHOW COLUMNS FROM covid_data;
ALTER TABLE covid_data MODIFY code VARCHAR(255);


SELECT * FROM covid_data;

SELECT * FROM covid_data WHERE daily_new_deaths_per_million IS NULL;

ALTER TABLE covid_data MODIFY day DATE;

SELECT COUNT(*) FROM covid_data;

SELECT * FROM covid_data
WHERE daily_new_deaths_per_million > (SELECT AVG(daily_new_deaths_per_million) + 3 * STD(daily_new_deaths_per_million) FROM covid_data);

SELECT * FROM covid_data
where entity = 'France';

SELECT * FROM covid_data
where entity <> 'Afghanistan';

SELECT entity, code, day, COUNT(*)
FROM covid_data
GROUP BY entity, code, day
HAVING COUNT(*) > 1;


SELECT * FROM covid_data;
SELECT * INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_covid_data.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
FROM covid_data;

