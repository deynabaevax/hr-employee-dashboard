CREATE DATABASE hrproject;

USE hrproject;

SELECT * FROM hr;

-- CHANGE THE NAME OF THE COLUMN TO REMOVE THE SPECIAL CHARACTERS 
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SET sql_safe_updates=0;

-- Convert the birthdates to streamlined format 
UPDATE hr
SET birthdate = CASE
  WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
  WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%y'), '%Y-%m-%d')
  ELSE NULL
END;

-- Convert the birthdate to date format
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;


-- Convert the hire_dates to streamlined format 
UPDATE hr
SET hire_date = CASE
  WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
  WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%y'), '%Y-%m-%d')
  ELSE NULL
END;


ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- Remove the time stamp from the termdate
UPDATE hr
SET termdate = date(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != ''; 

-- Set blank values to NULL
UPDATE hr
SET termdate = '0000-00-00'
WHERE termdate = '';

SELECT termdate
FROM hr;

--  Change the termdate to date format instead of text
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- Add a column age
ALTER TABLE hr
ADD COLUMN age INT; 


SELECT * 
FROM hr;

UPDATE hr 
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

SELECT birthdate, age 
FROM hr;

SELECT MIN(age) youngest, MAX(age) oldest
FROM hr;

-- How many to be excluded when doing the analysis 
SELECT COUNT(*)
FROM hr
WHERE age < 18;