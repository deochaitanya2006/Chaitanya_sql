CREATE DATABASE COMPANY_INFO;
USE COMPANY_INFO;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    email VARCHAR(100),
    job_role VARCHAR(50),
    salary DECIMAL(10,2),
    department_id INT,
    joining_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
   CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    client_name VARCHAR(100),
    budget DECIMAL(12,2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    hours_worked INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);
INSERT INTO departments VALUES
(1, 'Technology', 'Bangalore'),
(2, 'Audit', 'Mumbai'),
(3, 'Consulting', 'Pune'),
(4, 'Finance', 'Delhi'),
(5, 'Human Resources', 'Hyderabad');
INSERT INTO employees VALUES
(101, 'Rahul Sharma', 'rahul@example.com', 'Software Engineer', 65000, 1, '2023-06-15'),
(102, 'Priya Patil', 'priya@example.com', 'Data Analyst', 72000, 1, '2022-08-20'),
(103, 'Amit Verma', 'amit@example.com', 'Senior Consultant', 95000, 3, '2021-03-10'),
(104, 'Sneha Joshi', 'sneha@example.com', 'Business Analyst', 68000, 3, '2024-01-15'),
(105, 'Rohan Mehta', 'rohan@example.com', 'Auditor', 60000, 2, '2023-09-12'),
(106, 'Neha Singh', 'neha@example.com', 'Senior Auditor', 85000, 2, '2020-07-18'),
(107, 'Karan Gupta', 'karan@example.com', 'Financial Analyst', 70000, 4, '2022-11-25'),
(108, 'Anjali Rao', 'anjali@example.com', 'HR Executive', 55000, 5, '2024-04-10'),
(109, 'Vikas Jain', 'vikas@example.com', 'Software Engineer', 78000, 1, '2021-12-01'),
(110, 'Pooja Shah', 'pooja@example.com', 'Consultant', 82000, 3, '2022-05-16');

INSERT INTO projects VALUES
(201, 'Banking Transformation', 'ABC Bank', 5000000, 3),
(202, 'E-Commerce Platform', 'XYZ Retail', 3500000, 1),
(203, 'Financial Audit 2026', 'Global Finance Ltd', 1800000, 2),
(204, 'Data Analytics Dashboard', 'Tech Solutions', 2500000, 1),
(205, 'HR Management System', 'People Corp', 1500000, 5),
(206, 'Risk Management', 'Secure Ltd', 2200000, 4);

INSERT INTO employee_projects VALUES
(101, 202, 120),
(101, 204, 80),
(102, 204, 150),
(103, 201, 180),
(103, 206, 60),
(104, 201, 130),
(105, 203, 160),
(106, 203, 200),
(107, 206, 140),
(108, 205, 170),
(109, 202, 190),
(110, 201, 150),
(110, 206, 50);

SELECT * FROM employees;
SELECT employee_name, salary
FROM employees;
SELECT *
FROM employees
WHERE salary > 70000;
SELECT *
FROM employees
WHERE department_id = 1;
SELECT employee_name, salary
FROM employees
ORDER BY salary DESC;
SELECT employee_name, salary
FROM employees
ORDER BY salary ASC;
SELECT AVG(salary) AS average_salary
FROM employees;
SELECT MAX(salary) AS highest_salary
FROM employees;
SELECT MIN(salary) AS lowest_salary
FROM employees;
SELECT COUNT(*) AS total_employees
FROM employees;
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2;

SELECT 
    e.employee_name,
    d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

SELECT 
    e.employee_name,
    e.job_role,
    d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

SELECT
    p.project_name,
    p.client_name,
    d.department_name
FROM projects p
JOIN departments d
ON p.department_id = d.department_id;

SELECT
    e.employee_name,
    p.project_name,
    ep.hours_worked
FROM employee_projects ep
JOIN employees e
ON ep.employee_id = e.employee_id
JOIN projects p
ON ep.project_id = p.project_id;