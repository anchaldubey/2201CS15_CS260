-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 

-- CREATE DATABASE tutorial7;
USE tutorial7;
 
-- Ans.1
-- For Question 1
-- CALL GetAvgSalaryByDepartmentName('Finance');

DELIMITER //

CREATE PROCEDURE GetAvgSalaryByDepartmentName
    (IN DepartmentName VARCHAR(50))
BEGIN
    SELECT AVG(e.salary) AS AvgSalary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = DepartmentName;
END//

DELIMITER ;


 -- Ans.2

DELIMITER //
CREATE PROCEDURE UpdateEmployeeSalaryByPercentage
    (IN EmployeeId INT, IN PercentageIncrease DECIMAL(5,2))
BEGIN
    DECLARE NewSalary DECIMAL(10,2);

    SELECT salary * (1 + PercentageIncrease/100.0) INTO NewSalary
    FROM employees
    WHERE emp_id = EmployeeId;

    UPDATE employees
    SET salary = NewSalary
    WHERE emp_id = EmployeeId;
END//
DELIMITER ;


-- Ans.3
-- For Question 3
-- call GetEmployeesByDepartment ('Engineering');

DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartment
    (IN DepartmentName VARCHAR(50))
BEGIN
    SELECT e.emp_id, e.first_name, e.last_name, e.salary, d.department_name, d.location
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = DepartmentName
    ORDER BY e.last_name, e.first_name;
END//
DELIMITER ;


-- Ans.4

DELIMITER //
CREATE PROCEDURE GetProjectTotalBudget
    (IN ProjectName VARCHAR(50))
BEGIN
    SELECT SUM(budget) AS TotalBudget
    FROM projects
    WHERE project_name = ProjectName;
END//
DELIMITER ;


-- Ans.5

DELIMITER //
CREATE PROCEDURE GetHighestSalaryEmployeeInDepartment
    (IN DepartmentName VARCHAR(50))
BEGIN
    SELECT e.emp_id, e.first_name, e.last_name, e.salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = DepartmentName
    ORDER BY e.salary DESC
    LIMIT 1;
END//
DELIMITER ;


-- Ans.6

DELIMITER //
CREATE PROCEDURE GetProjectsDueInDays
    (IN DaysTillDue INT)
BEGIN
    DECLARE CurrentDate DATE;
    SET CurrentDate = CURDATE();

    SELECT project_id, project_name, start_date, end_date, budget
    FROM projects
    WHERE DATEDIFF(end_date, CurrentDate) <= DaysTillDue
    ORDER BY end_date;
END//
DELIMITER ;

-- Ans.7

DELIMITER //
CREATE PROCEDURE GetTotalSalaryExpenditure
    (IN DepartmentName VARCHAR(50))
BEGIN
    SELECT SUM(e.salary) AS TotalSalaryExpenditure
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = DepartmentName;
END//
DELIMITER ;


-- Ans.8

DELIMITER //
CREATE PROCEDURE GetEmployeeReport()
BEGIN
    SELECT 
        e.emp_id,
        e.first_name,
        e.last_name,
        d.department_name,
        d.location,
        e.salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id;
END//
DELIMITER ;


-- Ans.9

DELIMITER //
CREATE PROCEDURE GetProjectWithHighestBudget()
BEGIN
    SELECT 
        project_id,
        project_name,
        budget,
        start_date,
        end_date
    FROM projects
    ORDER BY budget DESC
    LIMIT 1;
END//
DELIMITER ;


-- Ans.10

DELIMITER //
CREATE PROCEDURE GetAvgSalaryAcrossAllDepartments()
BEGIN
    SELECT AVG(salary) AS AvgSalary
    FROM employees;
END//
DELIMITER ;


-- Ans.11

DELIMITER //
CREATE PROCEDURE AssignDepartmentManager
    (IN DepartmentName VARCHAR(50), IN NewManagerId INT)
BEGIN
    UPDATE departments
    SET manager_id = NewManagerId
    WHERE department_name = DepartmentName;
END//
DELIMITER ;


-- Ans.12

DELIMITER //
CREATE PROCEDURE GetRemainingProjectBudget
    (IN ProjectName VARCHAR(50))
BEGIN
    DECLARE TotalBudget DECIMAL(10,2);
    DECLARE SpentBudget DECIMAL(10,2);
    DECLARE RemainingBudget DECIMAL(10,2);

    SELECT budget INTO TotalBudget
    FROM projects
    WHERE project_name = ProjectName;

    SELECT SUM(budget) INTO SpentBudget
    FROM projects
    WHERE project_name = ProjectName
        AND end_date < CURDATE();

    SET RemainingBudget = TotalBudget - IFNULL(SpentBudget, 0);

    SELECT RemainingBudget AS RemainingBudget;
END//
DELIMITER ;


-- Ans.13

DELIMITER //
CREATE PROCEDURE GetEmployeesInYear
    (IN Year INT)
BEGIN
    SELECT 
        e.emp_id,
        e.first_name,
        e.last_name,
        d.department_name,
        e.salary,
        DATE_FORMAT(e.hire_date, '%Y-%m-%d') AS hire_date
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE YEAR(e.hire_date) = Year
    ORDER BY e.hire_date;
END//
DELIMITER ;


-- Ans.14

DELIMITER //
CREATE PROCEDURE UpdateProjectEndDate
    (IN ProjectName VARCHAR(50), IN Duration INT)
BEGIN
    DECLARE StartDate DATE;

    SELECT start_date INTO StartDate
    FROM projects
    WHERE project_name = ProjectName;

    UPDATE projects
    SET end_date = DATE_ADD(StartDate, INTERVAL Duration DAY)
    WHERE project_name = ProjectName;
END//
DELIMITER ;


-- Ans.15

DELIMITER //
CREATE PROCEDURE GetEmployeeCountByDepartment()
BEGIN
    SELECT 
        d.department_name,
        COUNT(e.emp_id) AS EmployeeCount
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    GROUP BY d.department_name;
END//
DELIMITER ;
