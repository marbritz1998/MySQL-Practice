USE stackhowto;

-- 1. Get the department and total salary, grouped by department, and sorted by total salary in descending order.

-- this sorts correctly
SELECT department, SUM(salary) 'total salary'
FROM employee
GROUP BY department
ORDER BY SUM(salary) DESC;


-- this sorts correctly
SELECT department, SUM(salary) total
FROM employee
GROUP BY department
ORDER BY total DESC;

-- this does not sort correctly
SELECT department, SUM(salary) 'total salary'
FROM employee
GROUP BY department
ORDER BY 'total salary' DESC;

-- WHY!!?!?!

-- 2. Get the department, the number of employees in that department, and the total salary grouped by department, and sorted by total salary in descending order
SELECT department, COUNT(*) 'number of employees', SUM(salary) total
FROM employee
GROUP BY department
ORDER BY total DESC;

-- 3. Get the average salary by department in ascending order of salary.
SELECT department, AVG(salary)
FROM employee
GROUP BY department
ORDER BY AVG(salary);

-- 4. Get the maximum salary by department in ascending order of salary.
SELECT department, MAX(salary)
FROM employee
GROUP BY department
ORDER BY MAX(salary);

-- 5. Get the minimum salary by department in ascending order of salary
SELECT department, MIN(salary)
FROM employee
GROUP BY department
ORDER BY MIN(salary);

-- 6. Get the number of employees grouped by year and month of membership.
SELECT YEAR(joining_date) as year, MONTH(joining_date) as month, count(*) number_of_employees
FROM employee
GROUP BY YEAR(joining_date), MONTH(joining_date);

-- 7. Get the department and total salary grouped by the department, where the total salary is greater than 1,000,000, 
-- and sorted in descending order of the total salary.
SELECT department, SUM(salary) total_salary
FROM employee
GROUP BY department HAVING total_salary > 1000000
ORDER BY total_salary DESC;

-- 8. Get all the details of an employee if the employee exists in the Reward table? Or in other words, find employees with bonuses.
SELECT  *
FROM employee e
INNER JOIN reward r ON e.employee_id = r.employee_ref_id;

-- the sample solution
SELECT e.* 
FROM employee e
WHERE EXISTS(
		SELECT r.Employee_ref_id FROM reward r WHERE e.employee_id = r.employee_ref_id
);

-- 9. How to get common data in two query results?
-- i am not sure what this question is asking, 

-- in base SQL you can use INTERSECT, but in mysql, you have to use either an inner join or WHERE with insert

-- 10. Get the IDs of employees who did not receive rewards without using subqueries?

-- using subquery
SELECT e.employee_id
FROM employee e
WHERE NOT EXISTS(
			SELECT r.employee_ref_id FROM reward r WHERE e.employee_id = r.employee_ref_id
);


-- not using subquery
SELECT e.employee_id
FROM employee e
LEFT JOIN reward r ON e.employee_id = r.employee_ref_id
WHERE r.employee_ref_id is NULL;

-- in standard SQL, you could use the operation MINUS
