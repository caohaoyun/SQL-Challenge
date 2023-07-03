drop table departments
CREATE TABLE departments (
  dept_no character varying(45) NOT NULL primary Key,
  dept_name character varying(45) NOT NULL
);
select *
from departments


drop table dept_emp
CREATE TABLE dept_emp (
  emp_no int NOT NULL primary key,
  dept_no character varying(45) NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
select *
from dept_emp


drop table dept_manager
CREATE TABLE dept_manager (
  dept_no character varying(45) NOT NULL,
  emp_no int NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
select *
from dept_manager


drop table employees
CREATE TABLE employees (
  emp_no int NOT NULL primary key,
  emp_title_id character varying(45) NOT NULL,	
  birth_date date NOT NULL,
  first_name character varying(45) NOT NULL,
  last_name character varying(45) NOT NULL,
  sex character varying(1) NOT NULL,
  hire_date date NOT NULL,
  FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
select *
from employees


ALTER DATABASE "new" SET datestyle TO "ISO,MDY";
show datestyle


drop table salaries
CREATE TABLE salaries (
  emp_no int NOT NULL,
  salary int NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
select *
from salaries


drop table titles
CREATE TABLE titles (
  title_id character varying(45) NOT NULL primary key,
  title character varying(45) NOT NULL
);
select *
from titles








-- List the following details of each employee: employee number, last name, first name, sex, and salary.
select employees.emp_no, last_name, first_name, sex, salary
from employees
join salaries
on employees.emp_no = salaries.emp_no
-- List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date
from employees
where DATE_PART('year',hire_date)=1986
-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
select departments.dept_no, departments.dept_name, employees.emp_no, last_name, first_name
from employees
join dept_manager
on employees.emp_no = dept_manager.emp_no
join departments
on dept_manager.dept_no = departments.dept_no

-- List the department number of each employee along with that employee’s employee number, last name, first name, and department name.
select employees.emp_no, last_name, first_name, dept_name
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
join departments
on dept_emp.dept_no = departments.dept_no
-- List first name, last name, and sex for employees whose first name is Hercules and last names begin with B.
select first_name, last_name, hire_date
from employees
where first_name = 'Hercules' and last_name like 'B%'
-- List each employee in the Sales department, including their employee number, last name, and first name.
select employees.emp_no, last_name, first_name
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
join departments
on dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales'
-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select employees.emp_no, last_name, first_name, dept_name
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
join departments
on dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales' or dept_name = 'Development'
-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) AS "last_name frequency"
FROM employees
GROUP BY last_name
ORDER BY "last_name frequency" DESC


