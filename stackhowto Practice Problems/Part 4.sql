USE stackhowto;

-- 1. Get all the details on employees whose participation month (Joining_date) is “January”
SELECT * FROM employee WHERE MONTH(joining_date) = 1;

-- 2. Get all the details of the employees who joined before March 1, 2019

-- sample solution.  so My problem was that I needed  to put the date in quotations.
SELECT * FROM employee WHERE joining_date < '2019-03-01';

-- 3. Get all the details on employees who joined after March 31, 2019
SELECT * FROM employee WHERE joining_date > '2019-03-31';

-- 4. Get the date and time of the employee’s enrollment.
SELECT DATE(joining_date), TIME(joining_date) FROM employee;

-- or the sample solution did
SELECT CONVERT(DATE_FORMAT(joining_date, '%Y-%m-%d-%H-%i:00'), DATETIME) FROM employee;

-- 5. Get the date and time, including milliseconds of the employee’s membership.

SELECT MICROSECOND(joining_date) FROM employee;

-- 6. Get the difference between the “Joining_date” and “date_reward” column

-- so this query gives me the number of days between these 2 dates, this is my solution
SELECT e.employee_id, DATEDIFF(r.date_reward, e.joining_date)
FROM employee e
INNER JOIN reward r ON r.employee_ref_id = e.employee_id
ORDER BY e.employee_id;


-- this is the sample solution query, but it treats the dates as numbers and subtracts them, THIS SAMPLE QUERY SOLUTION IS BULLSHIT
SELECT e.employee_id, r.date_reward - e.joining_date
FROM employee e
INNER JOIN reward r ON r.employee_ref_id = e.employee_id
ORDER BY e.employee_id;

-- 7. Get the current date and time.
SELECT CONVERT(DATE_FORMAT(CONCAT(CURDATE(), ' ', CURRENT_TIME()), '%Y-%m-%d-%H-%i:00'), DATETIME) 'current time';

-- or
SELECT now();

-- 8. Get the first names of employees who have the character ‘%’. Example: ‘Jack%’.
SELECT first_name FROM employee WHERE first_name LIKE '%\%%';

-- 9. Get the employee name (Last_name) after replacing the special character with white space.
SELECT REPLACE(last_name, '%', ' ') FROM employee;

-- 10. Get the employee’s department and total salary, grouped by department.
SELECT department, SUM(salary) 'total salary'
FROM employee
GROUP BY department;