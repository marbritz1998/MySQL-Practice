-- Practice Problems can be found at https://www.edureka.co/blog/interview-questions/sql-query-interview-questions

-- selecting the database I created for these exercises

USE edureka;

SHOW TABLES;

-- 1.) Write a query to fetch the EmpFname from the EmployeeInfo table in upper case and use the ALIAS name as EmpName.
SELECT UPPER(empfname) Empname FROM employeeinfo;

-- or

SELECT UPPER(empfname) AS 'Empname'
FROM employeeinfo;

-- or

SELECT UPPER(empfname) AS Empname
FROM employeeinfo;



-- 2.) Q2. Write a query to fetch the number of employees working in the department ‘HR’.
SELECT * FROM employeeinfo LIMIT 20;
SELECT COUNT(*) FROM employeeinfo WHERE Department = 'HR';

-- 3.) Q3. Write a query to get the current date.
SELECT CURDATE() as today;

-- 4.) Q4. Write a query to retrieve the first four characters of EmpLname from the EmployeeInfo table.
SELECT LEFT(emplname, 4) last_name_4 FROM employeeinfo;

-- or
SELECT SUBSTRING(emplname, 1, 4) last_name_4 FROM employeeinfo;



-- 5.) Q5. Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.
SELECT SUBSTRING_INDEX(address, '(', 1) FROM employeeinfo;


-- 6.) Q6. Write a query to create a new table which consists of data and structure copied from the other table.
CREATE TABLE NewTable AS SELECT * FROM EmployeeInfo;

-- 7.) Q7. Write q query to find all the employees whose salary is between 50000 to 100000.
SELECT * FROM employeeposition WHERE salary BETWEEN 50000 AND 100000;