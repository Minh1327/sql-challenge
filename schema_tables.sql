CREATE DATABASE mycompany;

-- NOTE: After create the database named `mycompany`, you must change the active database to `mycompany` by clicking the DB name in the status bar before running the next queries.

CREATE SCHEMA HR;
CREATE TABLE hr.employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR,
    birth_date DATE NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    sex text CHECK (sex in ('F', 'M')),
    hire_date DATE
);

CREATE TABLE hr.departments (
    dept_no VARCHAR PRIMARY KEY,
    dept_name VARCHAR NOT NULL
);

CREATE TABLE hr.dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR (6) NOT NULL,
    FOREIGN KEY(emp_no) REFERENCES hr.employees(emp_no),
    FOREIGN KEY(dept_no) REFERENCES hr.departments(dept_no),
    CONSTRAINT PK_dept_emp PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE hr.dept_manager (
    dept_no VARCHAR NOT NULL,
    emp_no INT NOT NULL,
    FOREIGN KEY(dept_no) REFERENCES hr.departments(dept_no),
    FOREIGN KEY(emp_no) REFERENCES hr.employees(emp_no),
    CONSTRAINT PK_dept_manager PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE hr.titles (
    title_id VARCHAR(6) PRIMARY KEY,
    title VARCHAR NOT NULL
);

-- Update table employees with foreign key title_id
ALTER TABLE hr.employees 
ADD CONSTRAINT emp_title_id 
FOREIGN KEY (emp_title_id) 
REFERENCES hr.titles (title_id);

CREATE TABLE hr.salaries (
    emp_no INT NOT NULL,
    salary INT,
    FOREIGN KEY(emp_no) REFERENCES hr.employees(emp_no),
    CONSTRAINT PK_salaries PRIMARY KEY (emp_no, salary)
);
