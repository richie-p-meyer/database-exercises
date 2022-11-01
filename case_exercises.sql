USE employees;

-- Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
SELECT first_name,last_name,dept_no,from_date,to_date,
	IF(to_date = '9999-01-01',True,False) AS is_current_employee
FROM employees e
JOIN dept_emp USING (emp_no);



-- Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT first_name,last_name,
	CASE 
		WHEN last_name BETWEEN 'a%' AND 'i%' THEN 'A-H'
		WHEN last_name BETWEEN 'i%' AND 'r%' THEN 'I-Q'
		ELSE 'R-Z'
		END AS alpha_group
FROM employees e;


-- How many employees (current or previous) were born in each decade?
SELECT decade, COUNT(*) as count
FROM
	(SELECT 
		CASE
		WHEN birth_date LIKE '%195%' THEN '50s'
		ELSE '60s'
		END AS decade
		FROM employees) AS o
GROUP BY decade;
		


-- What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
SELECT 
	CASE
		WHEN dept_name = 'Research' OR dept_name = 'Development' THEN 'R&D'
		WHEN dept_name = 'Sales' OR dept_name = 'Marketing' THEN 'Sales & Marketing'
		WHEN dept_name = 'Production' OR dept_name = 'Quality Management' THEN 'Prod & QM'
		WHEN dept_name = 'Finance' OR dept_name = 'Human Resources' THEN 'Finance & HR'
		ELSE 'Customer Service'
	 END AS dpt_group,
	 AVG(salary)
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
JOIN salaries USING (emp_no)
WHERE salaries.to_date > NOW()
GROUP BY dpt_group
;




