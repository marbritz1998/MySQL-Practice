use stackhowto;

-- 1. Get 20% of Bob’s salary, 10% of Alex’s salary, and 15% of other employees’ salaries.


-- this is pretty fried way to do this, I am using a CTE and then using UNION, what is fried is that to name the column for output, I have to name the select on the first option in the Union
WITH bob_sal AS (
SELECT first_name, 0.2 * salary as sal_b
FROM employee
WHERE first_name = 'Bob'
),
alex_sal AS (
SELECT first_name, 0.1 * salary as salary
FROM employee
WHERE first_name = 'Alex'
)
SELECT *
FROM alex_sal
UNION 
SELECT * 
FROM bob_sal
UNION
SELECT first_name, salary * 0.15 
FROM employee;


-- sample solution 1
SELECT first_name, 
CASE first_name
	WHEN 'Bob' THEN salary * 0.2
    WHEN 'Alex' THEN salary * 0.10
    ELSE salary * 0.15
END
as gross_salary
FROM employee;

-- refer to https://www.w3schools.com/sql/func_mysql_case.asp for CASE, it is basically an IF-ELSE statement