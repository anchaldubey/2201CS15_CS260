-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 


-- CREATE DATABASE tutorial4;
-- USE tutorial4;

-- CREATE TABLE departments (
--     department_id INT PRIMARY KEY,
--     department_name VARCHAR(255),
--     location VARCHAR(255)
-- );

-- CREATE TABLE employees (
--     emp_id INT PRIMARY KEY,
--     first_name VARCHAR(255),
--     last_name VARCHAR(255),
--     salary DECIMAL(10, 2),
--     department_id INT,
--     FOREIGN KEY (department_id) REFERENCES departments(department_id)
-- );

-- CREATE TABLE projects (
--     project_id INT PRIMARY KEY,
--     project_name VARCHAR(255),
--     budget DECIMAL(12, 2),
--     start_date DATE,
--     end_date DATE
-- );

-- Answers:

-- Ans.1)
select first_name, last_name
from employees;

-- Ans.2)
select department_name, location
from departments;

-- Ans.3)
select project_name, budget
from projects;

-- Ans.4)
select e.first_name, e.last_name, e.salary
from employees e
left join departments ds on ds.department_id=e.department_id
where ds.department_name="Engineering";

-- Ans.5)
select project_name, start_date
from projects;

-- Ans.6)
select e.first_name, e.last_name, d.department_name
from employees e
left join departments d on e.department_id=d.department_id;

-- Ans.7)
select project_name, budget
from projects
where budget>90000;

-- Ans.8)
select sum(budget) as total_budget
from projects;

-- Ans.9)
select first_name, last_name, salary
from employees
where salary>60000;

-- Ans.10)
select project_name, end_date
from projects;

-- Ans.11)
select department_name
from departments
where location="New Delhi";

-- Ans.12)
select avg(salary) as avg_salary
from employees;

-- Ans.13)
select e.first_name, e.last_name, d.department_name
from employees e
join departments d on e.department_id=d.department_id
where d.department_name="Finance";

-- Ans.14)
select project_name
from projects
where budget between 70000 and 100000;

-- Ans.15)
select d.department_name, count(e.emp_id) as employee_count
from employees e
join departments d on e.department_id=d.department_id
group by d.department_id;
