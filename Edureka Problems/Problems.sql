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


-- 8.) Q8. Write a query to find the names of employees that begin with ‘S’
SELECT empfname FROM employeeinfo WHERE empfname LIKE 'S%';

-- 9.) Q9. Write a query to fetch top N records.
SELECT * FROM employeeposition ORDER BY salary DESC LIMIT 2;


-- 10.) Q10. Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space
SELECT CONCAT(empfname, ' ', emplname) FullName FROM employeeinfo;


-- 11.) Q11. Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1975 and are grouped according to gender
SELECT COUNT(*), Gender FROM EmployeeInfo WHERE DOB BETWEEN '02/05/1970 ' AND '31/12/1975' GROUP BY Gender;


-- 12.) Q12. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.
SELECT * FROM employeeinfo ORDER BY emplname DESC, department;


-- 13.) Q13. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.
SELECT * FROM employeeinfo WHERE emplname LIKE '____a';


-- 14.) Q14. Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.
SELECT * FROM employeeinfo WHERE empfname NOT IN ('Sanjay', 'Sonia');


-- 15.) Q15. Write a query to fetch details of employees with the address as “DELHI(DEL)
SELECT * FROM employeeinfo WHERE address LIKE 'Delhi%';


-- 16.) Q16. Write a query to fetch all employees who also hold the managerial position
SELECT ei.empfname, ei.emplname, ep.empposition
FROM employeeinfo ei
INNER JOIN employeeposition ep ON ei.empid = ep.empid
AND ep.empposition IN ('Manager');


-- 17.) Q17. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order.
SELECT department, COUNT(*) dept_count
FROM employeeinfo
GROUP BY Department
ORDER BY COUNT(*);


-- 19.) Q19. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table.
-- the ones that have a date of joining are the employees with the empid in the employeeposition table
SELECT * 
FROM EmployeeInfo E 
WHERE EXISTS 
(SELECT * FROM EmployeePosition P WHERE E.EmpId = P.EmpId)
ORDER BY emplname;



-- 20.) Q20. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table.

-- so going to do them seperately for now

-- for min
SELECT empid, empposition, salary
FROM employeeposition
ORDER BY salary 
LIMIT 2;

-- for max
SELECT empid, empposition, salary
FROM employeeposition
ORDER BY salary DESC
LIMIT 2;


-- 21.) Q21. Write a query to find the Nth highest salary from the table without using TOP/limit keyword (tough one)

SELECT salary
FROM employeeposition e1
WHERE 1-1 = (
		SELECT COUNT(DISTINCT(e2.salary))
        FROM employeeposition e2
        WHERE e2.salary > e1.salary);










