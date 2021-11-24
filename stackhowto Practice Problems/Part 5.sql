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