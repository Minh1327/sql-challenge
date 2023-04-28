-- import CSV files to postgresql server
COPY hr.employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM '..\data\employess.csv'
DELIMITER ','
CSV HEADER;