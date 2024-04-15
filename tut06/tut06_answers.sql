-- General Instructions
-- 1.	The .sql files are run automatically, so please ensure that there are no syntax errors in the file. If we are unable to run your file, you get an automatic reduction to 0 marks.
-- Comment in MYSQL 


-- create database tutorial6;
-- use tutorial6;

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

-- Ans.1)
select s.first_name, s.last_name, c.course_name
from students s
join enrollments e on s.student_id=e.student_id
join courses c on c.course_id=e.course_id;

-- Ans.2)
select c.course_name, e.grade
from courses c
join enrollments e on c.course_id=e.course_id;

-- Ans.3)
select s.first_name as student_first_name, s.last_name as student_last_name, c.course_name, i.first_name as instructor_first_name, i.last_name as instructor_last_name
from students s
join enrollments e on e.student_id=s.student_id
join courses c on c.course_id=e.course_id
join instructors i on c.instructor_id=i.instructor_id;

-- Ans.4)
select s.first_name, s.last_name, s.age, s.city
from students s
join enrollments e on s.student_id=e.student_id
join courses c on c.course_id=e.course_id
where c.course_name="Mathematics";

-- Ans.5)
select c.course_name, i.first_name as instructor_first_name, i.last_name as instructor_last_name
from courses c
join instructors i on i.instructor_id=c.instructor_id;

-- Ans.6)
select s.first_name, s.last_name, e.grade, c.course_name
from students s
join enrollments e on s.student_id=e.student_id
join courses c on c.course_id=e.course_id;

-- Ans.7)
select s.first_name, s.last_name, s.age
from students s
join (
    select student_id
    from enrollments
    group by student_id
    having COUNT(course_id) > 1
) e on s.student_id = e.student_id;

-- Ans.8)
select c.course_name, count(s.student_id)
from courses c
join enrollments e on e.course_id=c.course_id
join students s on s.student_id=e.student_id
group by c.course_name;

-- Ans.9)
select s.first_name, s.last_name, s.age
from students s
left join enrollments e on s.student_id = e.student_id
where e.student_id is null;

-- Ans.10)
select c.course_name, avg(e.grade)
from courses c
join enrollments e on e.course_id=c.course_id
join students s on s.student_id=e.student_id
group by c.course_name;

-- Ans.11)
select s.first_name, s.last_name, c.course_name
from students s
join enrollments e on s.student_id=e.student_id
join courses c on c.course_id=e.course_id
where e.grade in ("A", "A+", "B+", "A-");

-- Ans.12)
select c.course_name, i.first_name, i.last_name
from courses c
join instructors i on i.instructor_id=c.instructor_id
where i.last_name like ('S%');

-- Ans.13)
select s.first_name, s.last_name, s.age
from students s
join enrollments e on e.student_id=s.student_id
join courses c on c.course_id=e.course_id
join instructors i on i.instructor_id=c.instructor_id
where i.first_name="Dr. Akhil";

-- Ans.14)
select c.course_name, MAX(e.grade) as max_grade
from courses c
join enrollments e on c.course_id = e.course_id
group by c.course_name;

-- Ans.15)
select s.first_name, s.last_name, s.age, c.course_name
from students s
join enrollments e on e.student_id=s.student_id
join courses c on c.course_id=e.course_id
order by c.course_name;
