-- Problems are found here: https://www.techbeamers.com/sql-query-questions-answers-for-practice/#sql-queries

 
 SHOW DATABASES;
 USE ORG;
 SHOW TABLES;
 
 SELECT * FROM worker;
 
USE ORG;


-- Problem 1.) Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
SELECT * FROM worker;

SELECT first_name FROM worker WORKER_NAME;

-- Sample Solution 1.) 
SELECT first_name WORKER_NAME FROM worker;

-- Problem 2.) Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
SELECT UPPER(first_name) FROM worker;

-- Sample Solution 2.)
SELECT UPPER(first_name) FROM worker;

-- Problem 3.) Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT DISTINCT(department) FROM worker;

-- same as sample solution

-- Problem 4.) Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
SELECT LEFT(first_name, 3) FROM worker;

-- Sample Solution 4.) 
SELECT substring(first_name, 1, 3) FROM worker;

-- Problem 5.) Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.
SELECT LOCATE('a', 'Amitabh') FROM worker WHERE first_name = 'Amitabh';

-- Sample Solution 5.)
Select INSTR(FIRST_NAME, BINARY'a') from Worker where FIRST_NAME = 'Amitabh'; -- script runs fine without 'BINARY' it doesn't seem necessary
-- also this gives the same solution as what I have

-- The INSTR method is in case-sensitive by default.
-- Using Binary operator will make INSTR work as the case-sensitive function

-- Problem 6.) Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side
SELECT RTRIM(first_name) FROM worker;

-- sample solution is the same thing

-- Problem 7.) Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
SELECT LTRIM(department) FROM worker;

-- Problem 8.) Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
SELECT department, CHAR_LENGTH(department) FROM worker GROUP BY department;

-- Sample Solution 8.)
SELECT DISTINCT LENGTH(department) FROM worker;

-- Problem 9.) Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’
SELECT REPLACE(first_name, 'a', 'A') FROM worker;

-- Problem 10.) Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into 
-- a single column COMPLETE_NAME. A space char should separate them
SELECT CONCAT(first_name, " ", last_name) COMPLETE_NAME FROM worker;

-- Problem 11.) Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM worker ORDER BY first_name;

-- Problem 12.) Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM worker ORDER BY first_name, department DESC;

-- Problem 13.) Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
SELECT * FROM worker WHERE first_name IN ("Vipul", "Satish");

-- Problem 14.) Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
SELECT * FROM worker WHERE first_name NOT IN ('Vipul', 'Satish');

-- Problem 15.) Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”
SELECT * FROM worker WHERE department = 'Admin';


-- Problem 16.) Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’
SELECT * FROM worker WHERE first_name LIKE '%a%';

-- Problem 17.) Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
SELECT * FROM worker WHERE first_name LIKE '%a';

-- Problem 18.) Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM worker WHERE first_name LIKE '%h' AND CHAR_LENGTH(first_name) >= 6;

-- Sample Solution 18.) 
Select * from Worker where FIRST_NAME like '_____h';

-- I do not agree with the sample solution as it excludes the name 'Amitabh' which indeed DOES contain 6 alphabetical characters

