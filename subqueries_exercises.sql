-- Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT *
FROM employees
WHERE hire_date = (SELECT hire_date
				FROM employees
				WHERE emp_no = 101010);




-- Find all the titles ever held by all current employees with the first name Aamod.

-- Selects all employees with first name Aamod with title
SELECT emp_no, first_name, title, titles.to_date
FROM employees
JOIN titles USING (emp_no)
WHERE first_name = 'Aamod' AND titles.to_date > CURDATE()
ORDER BY emp_no;



-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT DISTINCT(employees.emp_no)
FROM employees
JOIN salaries USING (emp_no)
JOIN titles USING (emp_no)
JOIN dept_emp USING (emp_no)
WHERE salaries.to_date < CURDATE() AND titles.to_date < CURDATE() AND dept_emp.to_date < CURDATE();
-- 73,363 no longer work for the company


-- Find all the current department managers that are female. List their names in a comment in your code.
SELECT first_name, last_name
FROM dept_manager
JOIN employees USING (emp_no)
WHERE gender = 'F' AND to_date LIKE '9999%';
/* 
Isamu	Legleitner
Karsten	Sigstam
Leon	DasSarma
Hilary	Kambil
*/


-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.

-- Find historical average salary
SELECT AVG(salary)
FROM salaries;

-- All employees with higher salary than avg
SELECT *
FROM employees
JOIN salaries USING (emp_no)
WHERE salaries.to_date LIKE '9%' 
								AND salary > (SELECT AVG(salary)
											FROM salaries)
ORDER BY salary;


-- How many current salaries are within 1 standard deviation of the current highest salary? What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.

-- Find highest salary
SELECT MAX(salary) 
FROM salaries;

-- FIND STD of salary
SELECT STD(salary) 
FROM salaries;

-- FIND quantity of salaries
SELECT COUNT(*)
FROM salaries
WHERE to_date LIKE '9%';

-- Within 1 STD
SELECT COUNT(*) AS within_1std, COUNT(*)/(SELECT COUNT(*) FROM salaries WHERE to_date LIKE '9%') * 100 AS percent_within_1std 
FROM salaries 
WHERE salary >= (SELECT MAX(salary) FROM salaries WHERE to_date LIKE '9%') - 
				(SELECT STD(salary) FROM salaries WHERE to_date LIKE '9%')
					AND to_date LIKE '9%';
-- 83 current salaries with 1 STD of highest salary, .0003% of salaries within 1 STD




-- BONUS: Find all the department names that currently have female managers.
-- Find the first and last name of the employee with the highest salary.
-- Find the department name that the employee with the highest salary works in.