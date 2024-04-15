-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 


-- CREATE DATABASE tutorial8;
-- USE tutorial8;

-- CREATE TABLE students (
--     student_id INT PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     age INT,
--     city VARCHAR(50)
-- );

-- CREATE TABLE instructors (
--     instructor_id INT PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50)
-- );

-- CREATE TABLE courses (
--     course_id INT PRIMARY KEY,
--     course_name VARCHAR(100),
--     instructor_id INT,
--     FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
-- );

-- CREATE TABLE enrollments (
--     enrollment_id INT PRIMARY KEY,
--     student_id INT,
--     course_id INT,
--     grade VARCHAR(10),
--     FOREIGN KEY (student_id) REFERENCES students(student_id),
--     FOREIGN KEY (course_id) REFERENCES courses(course_id)
-- );
