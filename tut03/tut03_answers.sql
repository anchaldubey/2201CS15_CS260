-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 


create database tutorial3;
use tutorial3;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    city VARCHAR(50),
    state VARCHAR(50)
);

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credit_hours INT,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Ans.1)
select first_name, last_name
from students;

-- Ans.2)
SELECT course_name, credit_hours
FROM courses;

-- Ans.3)
SELECT first_name, last_name, email
FROM instructors;

-- Ans.4)
select c.course_name, e.grade
from courses c
join enrollments e on c.course_id=e.course_id;

-- Ans.5)
select first_name, last_name, city
from students;

-- Ans.6)
select c.course_name, i.first_name, i.last_name
from courses c
join instructors i on i.instructor_id=c.instructor_id;

-- Ans.7)
SELECT first_name, last_name, age
FROM students;

-- Ans.8)
select c.course_name, e.enrollment_date
from courses c
join enrollments e on c.course_id=e.course_id;

-- Ans.9)
SELECT first_name, last_name, email
FROM instructors;

-- Ans.10)
SELECT course_name, credit_hours
FROM courses;

-- Ans.11)
select i.first_name, i.last_name, i.email
from instructors i
join courses c on c.instructor_id=i.instructor_id
where c.course_name="Mathematics";

-- Ans.12)
select c.course_name, e.grade
from courses c
join enrollments e on c.course_id=e.course_id
where e.grade="A";

-- Ans.13)
select s.first_name, s.last_name, s.state
from students s
where s.student_id=(
	select e.student_id
    from enrollments e
    join courses c on e.course_id=c.course_id
    where c.course_name="Computer Science"
);

-- Ans.14)
select c.course_name, e.enrollment_date
from courses c
join enrollments e on c.course_id=e.course_id
where e.grade="B+";

-- Ans.15)
select i.first_name, i.last_name, i.email
from instructors i
join courses c on c.instructor_id=i.instructor_id
where c.credit_hours>3;
