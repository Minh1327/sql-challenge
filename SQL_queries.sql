--1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT emp.emp_no, last_name, first_name, sex, salary
FROM hr.employees AS emp
JOIN hr.salaries AS sal ON emp.emp_no = sal.emp_no;

--2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, to_char(hire_date, 'DD/MM/YYYY') FROM hr.employees
WHERE EXTRACT('year' FROM hire_date) = 1986;

--3. List the manager of each department along with their department number, department name, 
--employee number, last name, and first name.
SELECT dept_mng.dept_no, dept.dept_name, emp.emp_no, last_name, first_name 
FROM hr.dept_manager AS dept_mng
JOIN hr.employees AS emp ON dept_mng.emp_no = emp.emp_no
JOIN hr.departments AS dept ON dept_mng.dept_no = dept.dept_no;

--4. List the department number for each employee along with that employee’s employee number, last name,
--first name, and department name.
SELECT dept.dept_no, emp.emp_no, last_name, first_name, dept_name 
FROM hr.departments AS dept 
JOIN hr.dept_emp ON dept.dept_no = hr.dept_emp.dept_no
JOIN hr.employees AS emp ON hr.dept_emp.emp_no = emp.emp_no
ORDER BY emp_no ASC;

--5. List the first name, last name, and sex of each employee whose first name is Hercules and whose 
--last name begins with the letter B.
SELECT first_name, last_name, sex
FROM hr.employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6. List each employee in the Sales department, including their employee number, last name, 
-- and first name.
SELECT emp.emp_no, last_name, first_name, dept.dept_name 
FROM hr.employees AS emp 
JOIN hr.dept_emp ON emp.emp_no = hr.dept_emp.emp_no
JOIN hr.departments AS dept ON hr.dept_emp.dept_no = dept.dept_no
	WHERE dept.dept_name  = 'Sales';
	
--7. List each employee in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.
SELECT emp.emp_no, last_name, first_name, dept.dept_name 
FROM hr.employees AS emp 
JOIN hr.dept_emp ON emp.emp_no = hr.dept_emp.emp_no
JOIN hr.departments AS dept ON hr.dept_emp.dept_no = dept.dept_no
WHERE emp.emp_no IN
(SELECT emp.emp_no
FROM hr.employees AS emp 
JOIN hr.dept_emp ON emp.emp_no = hr.dept_emp.emp_no
JOIN hr.departments AS dept ON hr.dept_emp.dept_no = dept.dept_no
WHERE dept.dept_name IN ('Sales', 'Marketing')
GROUP BY emp.emp_no
HAVING COUNT(emp.emp_no) = 2)
ORDER BY emp.emp_no, dept.dept_name;
--NOTE: As the output is null for Sales and Development, 
--I have changed Development to Marketing for demonstration purpose.

-- 8. List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) FROM hr.employees as emp
GROUP BY emp.last_name
ORDER BY COUNT(last_name) DESC;


