-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 


-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 


 -- USE tutorial8;

-- Ans.1

DELIMITER //
CREATE TRIGGER increase_salary_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 60000 THEN
        SET NEW.salary = NEW.salary * 1.1;
    END IF;
END;
//
DELIMITER ;

-- Ans.2

DELIMITER //
CREATE TRIGGER prevent_delete_department_trigger
BEFORE DELETE ON departments
FOR EACH ROW
BEGIN
    DECLARE employee_count INT;
    SELECT COUNT(*) INTO employee_count FROM employees WHERE department_id = OLD.department_id;
    IF employee_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete department with assigned employees';
    END IF;
END;
//
DELIMITER ;


-- Ans.3

DELIMITER //
CREATE TRIGGER log_salary_update_trigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_audit (old_salary, new_salary, employee_name, date)
    VALUES (OLD.salary, NEW.salary, CONCAT(NEW.first_name, ' ', NEW.last_name), NOW());
END;
//
DELIMITER ;


-- Ans.4

DELIMITER //
CREATE TRIGGER assign_department_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary <= 60000 THEN
        SET NEW.department_id = 3;
    -- Add more conditions and assignments as needed
    END IF;
END;
//
DELIMITER ;


-- Ans.5

DELIMITER //
CREATE TRIGGER update_manager_salary_trigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    UPDATE employees
    SET salary = NEW.salary
    WHERE emp_id = (SELECT manager_id FROM departments WHERE department_id = NEW.department_id);
END;
//
DELIMITER ;


-- Ans.6

DELIMITER //
CREATE TRIGGER prevent_update_department_trigger
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    DECLARE project_count INT;
    SELECT COUNT(*) INTO project_count FROM works_on WHERE emp_id = NEW.emp_id;
    IF project_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update department for employees who have worked on projects';
    END IF;
END;
//
DELIMITER ;


-- Ans.7

DELIMITER //
CREATE TRIGGER update_avg_salary_trigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    UPDATE departments d
    SET avg_salary = (SELECT AVG(salary) FROM employees WHERE department_id = d.department_id);
END;
//
DELIMITER ;


-- Ans.8

DELIMITER //
CREATE TRIGGER delete_works_on_trigger
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    DELETE FROM works_on WHERE emp_id = OLD.emp_id;
END;
//
DELIMITER ;


-- Ans.9

DELIMITER //
CREATE TRIGGER prevent_insert_employee_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE min_salary DECIMAL;
    SELECT MIN_salary INTO min_salary FROM departments WHERE department_id = NEW.department_id;
    IF NEW.salary < min_salary THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee salary cannot be less than department minimum salary';
    END IF;
END;
//
DELIMITER ;


-- Ans.10

DELIMITER //
CREATE TRIGGER update_total_salary_budget_trigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    UPDATE departments d
    SET total_salary_budget = (SELECT SUM(salary) FROM employees WHERE department_id = d.department_id);
END;
//
DELIMITER ;


-- Ans.11

DELIMITER //
CREATE TRIGGER email_notification_trigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    -- Code to send email notification to HR
END;
//
DELIMITER ;


-- Ans.12

DELIMITER //
CREATE TRIGGER prevent_insert_department_trigger
BEFORE INSERT ON departments
FOR EACH ROW
BEGIN
    IF NEW.location IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Location must be specified for new department';
    END IF;
END;
//
DELIMITER ;


-- Ans.13

DELIMITER //
CREATE TRIGGER update_department_name_trigger
AFTER UPDATE ON departments
FOR EACH ROW
BEGIN
    UPDATE employees
    SET department_name = NEW.department_name
    WHERE department_id = NEW.department_id;
END;
//
DELIMITER ;


-- Ans.14

DELIMITER //
CREATE TRIGGER audit_operations_trigger
AFTER INSERT, UPDATE, DELETE ON employees
FOR EACH ROW
BEGIN
    -- Code to log operations into audit table
END;
//
DELIMITER ;


-- Ans.15

DELIMITER //
CREATE TRIGGER generate_employee_id_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    SET NEW.emp_id = (SELECT MAX(emp_id) + 1 FROM employees);
END;
//
DELIMITER ;
