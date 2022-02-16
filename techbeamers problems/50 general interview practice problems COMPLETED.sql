-- Problems are found here: https://www.techbeamers.com/sql-query-questions-answers-for-practice/#sql-queries

-- currently on problem 45
 
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


-- Problem 19.) Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000
SELECT * FROM worker WHERE salary BETWEEN 100000 AND 500000;

-- Problem 20.) Write an SQL query to print details of the Workers who have joined in Feb’2014
SELECT * FROM worker WHERE MONTH(joining_date) = 2 AND YEAR(joining_date) = 2014;

-- Problem 21.) Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT COUNT(worker_id) FROM worker WHERE department = 'Admin';

-- or 
SELECT COUNT(*) FROM worker WHERE department = 'Admin';

-- Problem 22.) Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.
SELECT CONCAT(first_name, " ",last_name) 'worker names', salary FROM worker WHERE salary >= 50000 AND salary <= 100000;

-- Sample Solution 22.)
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) As Worker_Name, Salary
FROM worker 
WHERE WORKER_ID IN 
(SELECT WORKER_ID FROM worker 
WHERE Salary BETWEEN 50000 AND 100000);

-- Problem 23.) Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT department, COUNT(*) 'no. of workers' FROM worker GROUP BY department ORDER BY COUNT(*) DESC;

-- also try by referring to alias in order by
SELECT department, COUNT(*) 'no. of workers' FROM worker GROUP BY department ORDER BY 'no. of workers' DESC;


-- Problem 24.) Write an SQL query to print details of the Workers who are also Managers.

-- using join
SELECT * 
FROM worker w
INNER JOIN title t ON t.worker_ref_id = w.worker_id
WHERE worker_title = 'Manager';

-- Sample Solution 24.) 
SELECT DISTINCT W.FIRST_NAME, T.WORKER_TITLE
FROM Worker W
INNER JOIN Title T
ON W.WORKER_ID = T.WORKER_REF_ID
AND T.WORKER_TITLE in ('Manager');

-- Problem 25.) Write an SQL query to fetch duplicate records having matching data in some fields of a table.
-- stuck on this one...

-- Sample Solution 25.) 
SELECT WORKER_TITLE, AFFECTED_FROM, COUNT(*)
FROM Title
GROUP BY WORKER_TITLE, AFFECTED_FROM
HAVING COUNT(*) > 1;

-- Problem 26.) Write an SQL query to show only odd rows from a table.
-- stuck on this one 

-- Sample Solution 26.) 
SELECT * FROM Worker WHERE MOD (WORKER_ID, 2) != 0;

-- Problem 27.) Write an SQL query to show only even rows from a table.
SELECT * FROM worker WHERE MOD (worker_id, 2) = 0;

-- Problem 28.) Write an SQL query to clone a new table from another table.
-- stuck on this one

-- Sample Solution 28.) 

-- The general query to clone a table with data is:
SELECT * INTO WorkerClone FROM Worker;

-- The general way to clone a table without information is:
SELECT * INTO WorkerClone FROM Worker WHERE 1 = 0;

-- An alternate way to clone a table (for MySQL) without is:
CREATE TABLE WorkerClone LIKE Worker;

-- Problem 29.) Write an SQL query to fetch intersecting records of two tables.
SELECT *
FROM worker w, title t
WHERE w.worker_id = t.worker_ref_id;

-- Sample solution 29.)  -- this solution does not work in MySQL, would need to use a join
(SELECT * FROM Worker)
INTERSECT
(SELECT * FROM WorkerClone);

-- Problem 30.) Write an SQL query to show records from one table that another table does not have.
-- don't know

-- Sample Solution 30.) MySQL does not support MINUS operator, would need to use a join
SELECT * FROM Worker
MINUS
SELECT * FROM Title;


-- Problem 31.) Write an SQL query to show the current date and time.
SELECT current_date();
SELECT current_timestamp();
SELECT CURDATE();

-- Problem 32.) Write an SQL query to show the top n (say 10) records of a table.
SELECT * FROM worker LIMIT 4;

-- Problem 33.) Write an SQL query to determine the nth (say n=5) highest salary from a table.
SELECT salary FROM worker ORDER BY salary DESC LIMIT 4,1;  


-- Sample Solution 33.) 
-- MySQL general solution
SELECT Salary FROM Worker ORDER BY Salary DESC LIMIT n-1,1;


-- Problem 34.) Write an SQL query to determine the 5th highest salary without using TOP or limit method.
SELECT * FROM worker ORDER BY salary DESC;  -- the 5th highest salary is worker_id 1

SELECT salary FROM worker WHERE worker_id = 1;

-- Sample Solution 34.) 
SELECT Salary
FROM Worker W1
WHERE 4 = (
 SELECT COUNT( DISTINCT ( W2.Salary ) )
 FROM Worker W2
 WHERE W2.Salary >= W1.Salary
 );
 
 -- Generic method to find the nth highest salary without using TOP or LIMIT
SELECT Salary
FROM Worker W1
WHERE n-1 = (
 SELECT COUNT( DISTINCT ( W2.Salary ) )
 FROM Worker W2
 WHERE W2.Salary >= W1.Salary
 );
 
 -- Problem 35.) Write an SQL query to fetch the list of employees with the same salary.
SELECT * 
FROM worker w1;

-- tried several things for this question, has me stumped, will have to google search 

SELECT first_name, salary
FROM worker
GROUP BY first_name, salary;


-- Sample Solution 35.) 
Select distinct W.WORKER_ID, W.FIRST_NAME, W.Salary 
from Worker W, Worker W1 
where W.Salary = W1.Salary 
and W.WORKER_ID != W1.WORKER_ID;

-- so they are matching all the salaries, then once they have that, they are filtering from those salaries the records that have different worker_id's

-- Problem 36.) Write an SQL query to show the second highest salary from a table.
SELECT * 
FROM worker
ORDER BY salary DESC
LIMIT 1,1;  -- this is wrong, should be choosing the salary = 300000


-- Sample Solution 36.) 
Select max(Salary) from Worker 
where Salary not in (Select max(Salary) from Worker);
-- so they are find the max salary in the subquery, then they are taking the salaries that are not the max salary (single entry). This leaves
-- you with a list of salaries (without the max salary) so then they are taking the max salary of this list, which is the 2nd highest salary

-- gosh sql is a bitch

-- Problem 37.)  Write an SQL query to show one row twice in results from a table
SELECT *
FROM WORKER
WHERE WORKER_ID <= (SELECT count(WORKER_ID)/2 from Worker);  -- this isn't showing one row twice in the results

-- Problem 38.) Write an SQL query to fetch intersecting records of two tables.
-- uses the operator INTERSECT, but MySQL does not support this operator, so would have to use a left join

-- Problem 39.) Write an SQL query to fetch the first 50% records from a table.
-- stuck

-- Sample Solution 39.) 
SELECT *
FROM WORKER
WHERE WORKER_ID <= (SELECT count(WORKER_ID)/2 from Worker);

-- Problem 40.) Write an SQL query to fetch the departments that have less than five people in it.
SELECT dc.department
FROM (SELECT department, COUNT(*) 'count'
	FROM worker
	GROUP BY department) AS dc
WHERE dc.count < 5;

-- Sample Solution 40.)
SELECT department, COUNT(*) 'number of workers'
FROM worker
GROUP BY department
HAVING 'number of workers' < 5;

-- these both give the same result, thought the output is different

-- Problem 41.) Write an SQL query to show all departments along with the number of people in there.
SELECT department, COUNT(*) 'number of workers'
FROM worker
GROUP BY department;

-- Problem 42.) Write an SQL query to show the last record from a table.
-- stumped

-- Sample Solution 42.) 
Select * from Worker where WORKER_ID = (SELECT max(WORKER_ID) from Worker);

-- Problem 43.) Write an SQL query to fetch the first row of a table.
SELECT * FROM worker
WHERE worker_id = (SELECT MIN(worker_id) FROM worker);

-- Problem 44.) Write an SQL query to fetch the last five records from a table.
-- going to do it my roundabout way
SELECT COUNT(*) FROM worker;
SELECT * FROM worker LIMIT 3,8;


-- Sample Solution 44.) 
SELECT * FROM Worker WHERE WORKER_ID <=5
UNION
SELECT * FROM (SELECT * FROM Worker W order by W.WORKER_ID DESC) AS W1 WHERE W1.WORKER_ID <=5; -- this doesn't show the last 5 records, it shows the first 5

-- Problem 45.) Write an SQL query to print the name of employees having the highest salary in each department.
SELECT department, CONCAT(first_name, " ",last_name) 'employee name', MAX(salary)
FROM worker
GROUP BY department; -- so this almost does what the problem wants, I just need the names

SELECT w.department, CONCAT(w.first_name," ",w.last_name) employee_name, w.salary
FROM (SELECT department, MAX(salary) max_salary FROM worker GROUP BY department) as salary_max
INNER JOIN worker w ON salary_max.max_salary = w.salary;
-- so this gives me 4 names, but it makes since as 2 of the names have the same salary in the department

-- Sample Solution 45.)
SELECT t.DEPARTMENT,t.FIRST_NAME,t.Salary from(SELECT max(Salary) as TotalSalary,DEPARTMENT from Worker group by DEPARTMENT) as TempNew 
Inner Join Worker t on TempNew.DEPARTMENT=t.DEPARTMENT 
 and TempNew.TotalSalary=t.Salary;
 
 -- okay, so this is the same result and process that I did
 
 
 -- Problem 46.) Write an SQL query to fetch three max salaries from a table.
 SELECT DISTINCT(salary) FROM worker ORDER BY salary DESC LIMIT 3;
 
SELECT salary FROM worker ORDER BY salary DESC LIMIT 3;

-- not sure if they want distinct max salaries, so did one with distinct max salaries and one without the distinct max salaries

-- sample solution 46.) 
SELECT distinct Salary from worker a WHERE 3 >= (SELECT count(distinct Salary) from worker b WHERE a.Salary <= b.Salary) order by a.Salary desc;

-- same solution as me, they just didn't want to use the LIMIT function

-- Problem 47.) Write an SQL query to fetch three min salaries from a table.
SELECT salary FROM worker ORDER BY salary LIMIT 3;

-- or 
SELECT DISTINCT salary FROM worker ORDER BY salary LIMIT 3;

-- not using limit
SELECT DISTINCT salary from worker w1 WHERE 3 >= (SELECT COUNT(DISTINCT salary) FROM worker w2 WHERE w1.salary >= w2.salary) ORDER BY w1.salary;

-- Sample Solution 47.) 
SELECT distinct Salary from worker a WHERE 3 >= (SELECT count(distinct Salary) from worker b WHERE a.Salary >= b.Salary) order by a.Salary desc;


-- Problem 48.) Write an SQL query to fetch nth max salaries from a table.
-- using limit
SELECT DISTINCT salary FROM worker ORDER BY salary DESC LIMIT n;

-- not using LIMIT
SELECT DISTINCT salary from worker w1 WHERE n >= (SELECT COUNT(DISTINCT salary) FROM worker w2 WHERE w1.salary <= w2.salary) ORDER BY w1.salary DESC;


-- Problem 49.) Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT department, SUM(salary) 'Total Salary Paid' FROM worker GROUP BY department;

-- Problem 50.) Write an SQL query to fetch the names of workers who earn the highest salary.
SELECT CONCAT(first_name, " ",last_name) 'employee name', salary FROM worker WHERE salary = (SELECT MAX(salary) FROM worker);

-- Sample Solution 50.) 
SELECT FIRST_NAME, SALARY from Worker WHERE SALARY=(SELECT max(SALARY) from Worker);