-- Create a new schema named HR in postgres default database.
CREATE SCHEMA HR;

CREATE TABLE hr.employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(5),
    birth_date DATE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex text CHECK (sex in ('F', 'M')),
    hire_date DATE
);

CREATE TABLE hr.departments (
    dept_no VARCHAR(4) PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE hr.dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    FOREIGN KEY(emp_no) REFERENCES hr.employees(emp_no),
    FOREIGN KEY(dept_no) REFERENCES hr.departments(dept_no),
    CONSTRAINT PK_dept_emp PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE hr.dept_manager (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    FOREIGN KEY(dept_no) REFERENCES hr.departments(dept_no),
    FOREIGN KEY(emp_no) REFERENCES hr.employees(emp_no),
    CONSTRAINT PK_dept_manager PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE hr.titles (
    title_id VARCHAR(5) PRIMARY KEY,
    title VARCHAR(50) NOT NULL
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

-- Import data from CSV files to Postgres table
COPY hr.titles(title_id, title)
FROM 'D:\Monash bootcamp\Git\sql-challenge\data\titles.csv'
DELIMITER ','
CSV HEADER;

SET datestyle TO postgres, mdy;

COPY hr.employees(emp_no, emp_title_id, birth_date,first_name,last_name,sex,hire_date)
FROM 'D:\Monash bootcamp\Git\sql-challenge\data\employees.csv'
DELIMITER ','
CSV HEADER;

COPY hr.salaries(emp_no, salary)
FROM 'D:\Monash bootcamp\Git\sql-challenge\data\salaries.csv'
DELIMITER ','
CSV HEADER;

COPY hr.departments(dept_no, dept_name)
FROM 'D:\Monash bootcamp\Git\sql-challenge\data\departments.csv'
DELIMITER ','
CSV HEADER;

COPY hr.dept_emp(emp_no, dept_no)
FROM 'D:\Monash bootcamp\Git\sql-challenge\data\dept_emp.csv'
DELIMITER ','
CSV HEADER;

COPY hr.dept_manager(dept_no, emp_no)
FROM 'D:\Monash bootcamp\Git\sql-challenge\data\dept_manager.csv'
DELIMITER ','
CSV HEADER;


