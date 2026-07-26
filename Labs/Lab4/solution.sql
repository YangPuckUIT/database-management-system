-- xài bảng, giá trị, khóa ngoại của bài LAB 3

CREATE DATABASE MOOC
USE MOOC

-- tạo bảng (bước 1)

CREATE TABLE building (
    Building_id INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL
);

CREATE TABLE faculty (
    Faculty_id INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Head_id INT NOT NULL,
    Office_location VARCHAR(50),
    Phone VARCHAR(15)
);

CREATE TABLE lecturer (
    Lecturer_id INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Faculty_id INT NOT NULL,
    Office_location VARCHAR(50),
    Phone VARCHAR(15),
    DOB DATE NOT NULL,
    Join_date DATE NOT NULL
);


CREATE TABLE student (
    Student_number INT NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Class TINYINT NOT NULL,
    Faculty_id INT NOT NULL,
    DOB DATE NOT NULL
);


CREATE TABLE course (
    Course_number VARCHAR(20) NOT NULL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Credit_hours TINYINT NOT NULL
);


CREATE TABLE section (
    Section_identifier INT NOT NULL PRIMARY KEY,
    Course_number VARCHAR(20) NOT NULL,
    Semester VARCHAR(20) NOT NULL,
    Year INT NOT NULL,
    Lecturer_id INT NOT NULL,
    Building_id INT NOT NULL,
    Room_number VARCHAR(10) NOT NULL,
    Time_slot VARCHAR(50) NOT NULL,
    Capacity INT NOT NULL
);

CREATE TABLE grade_report (
    Student_number INT NOT NULL,
    Section_identifier INT NOT NULL,
    Grade VARCHAR(2) NOT NULL,
    Grade_point DECIMAL(3,2) NOT NULL,
    PRIMARY KEY (Student_number, Section_identifier)
);

CREATE TABLE enrollment (
    Student_number INT NOT NULL,
    Section_identifier INT NOT NULL,
    Enrollment_date DATE NOT NULL,
    PRIMARY KEY (Student_number, Section_identifier)
);


CREATE TABLE prerequisite (
    Course_number VARCHAR(20) NOT NULL,
    Prerequisite_course_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (Course_number, Prerequisite_course_number)
);

-- thêm giá trị (bước 2)

INSERT INTO building (Building_id, Name, Address) VALUES
(1, 'Science Hall', '123 University Ave, City, ST 12345'),
(2, 'Lecture Center', '456 Campus Rd, City, ST 12345'),
(3, 'Engineering Tower', '789 Tech Dr, City, ST 12345'),
(4, 'Library Annex', '101 Library Ln, City, ST 12345'),
(5, 'Arts Building', '202 Creative Way, City, ST 12345'),
(6, 'Business School', '303 Commerce St, City, ST 12345'),
(7, 'Student Union', '404 Union Blvd, City, ST 12345'),
(8, 'Health Sciences', '505 Medical Rd, City, ST 12345'),
(9, 'Physics Hall', '606 Science Pkwy, City, ST 12345'),
(10, 'Chemistry Lab', '707 Chem Ave, City, ST 12345'),
(11, 'Social Sciences Hall', '808 Society St, City, ST 12345'),
(12, 'Language Center', '909 Lingua Rd, City, ST 12345');

INSERT INTO course (Course_number, Name, Credit_hours) VALUES
('CS101', 'Introduction to Programming', 3),
('CS201', 'Data Structures', 3),
('MATH101', 'Calculus I', 4),
('ENG101', 'Mechanics', 3),
('PHY101', 'Introduction to Physics', 4),
('CHEM101', 'General Chemistry', 4),
('BUS101', 'Principles of Management', 3),
('ART101', 'Art History', 3),
('BIO101', 'Biology Fundamentals', 4),
('HIST101', 'World History', 3),
('ECON101', 'Microeconomics', 3);

INSERT INTO faculty (Faculty_id, Name, Head_id, Office_location, Phone) VALUES
(1, 'Computer Science', 1, 'Science Hall 301', '555-0101'),
(2, 'Mathematics', 3, 'Science Hall 401', '555-0102'),
(3, 'Engineering', 4, 'Engineering Tower 501', '555-0103'),
(4, 'Physics', 5, 'Physics Hall 201', '555-0104'),
(5, 'Chemistry', 6, 'Chemistry Lab 301', '555-0105'),
(6, 'Business', 7, 'Business School 401', '555-0106'),
(7, 'Arts', 8, 'Arts Building 101', '555-0107'),
(8, 'Biology', 9, 'Health Sciences 601', '555-0108'),
(9, 'Economics', 10, 'Business School 402', '555-0109'),
(10, 'History', 11, 'Library Annex 202', '555-0110');

INSERT INTO lecturer (Lecturer_id, Name, Faculty_id, Office_location, Phone, DOB, Join_date) VALUES
(1, 'Dr. Alice Smith', 1, 'Science Hall 302', '555-0201', '1975-03-15', '2010-08-01'),
(2, 'Dr. Bob Johnson', 1, 'Science Hall 303', '555-0202', '1980-06-22', '2015-09-01'),
(3, 'Dr. Carol White', 2, 'Science Hall 402', '555-0203', '1978-11-10', '2012-01-15'),
(4, 'Dr. David Lee', 3, 'Engineering Tower 502', '555-0204', '1972-07-18', '2008-08-15'),
(5, 'Dr. Emma Brown', 4, 'Physics Hall 202', '555-0205', '1985-02-10', '2018-01-10'),
(6, 'Dr. Frank Green', 5, 'Chemistry Lab 302', '555-0206', '1979-09-05', '2013-09-01'),
(7, 'Dr. Grace Kim', 6, 'Business School 403', '555-0207', '1982-12-15', '2016-07-01'),
(8, 'Dr. Henry Patel', 7, 'Arts Building 102', '555-0208', '1976-03-22', '2010-08-01'),
(9, 'Dr. Irene Wong', 8, 'Health Sciences 602', '555-0209', '1980-11-30', '2014-01-15'),
(10, 'Dr. James Carter', 9, 'Business School 404', '555-0210', '1974-06-25', '2009-09-01'),
(11, 'Dr. Karen Adams', 10, 'Library Annex 203', '555-0211', '1973-04-12', '2011-08-01'),
(12, 'Dr. Laura Evans', 2, 'Science Hall 403', '555-0212', '1981-05-20', '2017-09-01'),
(13, 'Dr. Michael Brown', 1, 'Science Hall 304', '555-0213', '1977-08-10', '2019-01-15'),
(14, 'Dr. Susan Clark', 2, 'Science Hall 404', '555-0214', '1983-04-25', '2020-08-01'),
(15, 'Dr. Thomas Wilson', 3, 'Engineering Tower 503', '555-0215', '1974-12-05', '2016-09-01'),
(16, 'Dr. Rachel Lee', 4, 'Physics Hall 203', '555-0216', '1986-07-18', '2021-01-10'),
(17, 'Dr. Peter Davis', 5, 'Chemistry Lab 303', '555-0217', '1980-03-30', '2018-07-01');

INSERT INTO student (Student_number, Name, Class, Faculty_id, DOB) VALUES
(1001, 'John Doe', 2, 1, '2003-04-12'),
(1002, 'Jane Roe', 3, 1, '2002-09-25'),
(1003, 'Mike Brown', 1, 2, '2004-01-30'),
(1004, 'Sarah Davis', 4, 3, '2001-05-20'),
(1005, 'Tom Wilson', 2, 4, '2003-08-14'),
(1006, 'Lisa Taylor', 3, 5, '2002-02-28'),
(1007, 'Mark Evans', 1, 6, '2004-10-10'),
(1008, 'Emily Clark', 2, 7, '2003-07-03'),
(1009, 'Ryan Harris', 4, 8, '2001-12-15'),
(1010, 'Anna Lee', 3, 9, '2002-06-08'),
(1011, 'Chris Martinez', 2, 10, '2003-03-17'),
(1012, 'Sophie Turner', 1, 1, '2004-11-22');

INSERT INTO prerequisite (Course_number, Prerequisite_course_number) VALUES
('CS201', 'CS101'),
('ENG101', 'MATH101'),
('PHY101', 'MATH101'),
('CHEM101', 'MATH101'),
('BUS101', 'ECON101'),
('ART101', 'HIST101'),
('BIO101', 'CHEM101'),
('ECON101', 'MATH101'),
('CS101', 'MATH101'),
('HIST101', 'ENG101'),
('CS201', 'MATH101'),
('PHY101', 'CHEM101');

INSERT INTO section (Section_identifier, Course_number, Semester, Year, Lecturer_id, Building_id, Room_number, Time_slot, Capacity) VALUES
(1, 'CS101', 'Spring', 2025, 1, 1, '101', 'Mon/Wed 10:00-11:30', 50),
(2, 'MATH101', 'Spring', 2025, 3, 2, '201', 'Tue/Thu 13:00-14:30', 40),
(3, 'CS201', 'Spring', 2025, 2, 1, '102', 'Mon/Wed 13:00-14:30', 40),
(4, 'ENG101', 'Spring', 2025, 4, 3, '301', 'Tue/Thu 09:00-10:30', 50),
(5, 'PHY101', 'Fall', 2025, 5, 9, '101', 'Mon/Wed 11:00-12:30', 45),
(6, 'CHEM101', 'Fall', 2025, 6, 10, '201', 'Tue/Thu 14:00-15:30', 40),
(7, 'BUS101', 'Spring', 2025, 7, 6, '401', 'Mon/Wed 15:00-16:30', 50),
(8, 'ART101', 'Spring', 2025, 8, 5, '103', 'Fri 10:00-12:00', 30),
(9, 'BIO101', 'Fall', 2025, 9, 8, '601', 'Tue/Thu 11:00-12:30', 35),
(10, 'ECON101', 'Spring', 2025, 10, 6, '402', 'Mon/Wed 09:00-10:30', 50),
(11, 'HIST101', 'Fall', 2025, 11, 4, '301', 'Mon/Wed 14:00-15:30', 40),
(12, 'CS101', 'Fall', 2025, 13, 1, '103', 'Tue/Thu 10:00-11:30', 50);

INSERT INTO enrollment (Student_number, Section_identifier, Enrollment_date) VALUES
(1001, 1, '2025-01-10'), 
(1002, 1, '2025-01-10'), 
(1003, 2, '2025-01-11'), 
(1004, 4, '2025-01-12'), 
(1005, 5, '2025-08-10'), 
(1006, 6, '2025-08-11'), 
(1007, 7, '2025-01-13'), 
(1008, 8, '2025-01-14'), 
(1009, 9, '2025-08-12'), 
(1010, 10, '2025-01-15'), 
(1011, 11, '2025-08-13'), 
(1012, 12, '2025-08-14'); 

INSERT INTO grade_report (Student_number, Section_identifier, Grade, Grade_point) VALUES
(1001, 1, 'A', 4.00), 
(1002, 1, 'B+', 3.33), 
(1003, 2, 'A-', 3.67), 
(1004, 4, 'B', 3.00), 
(1005, 5, 'A', 4.00), 
(1006, 6, 'C+', 2.33), 
(1007, 7, 'A-', 3.67), 
(1008, 8, 'B+', 3.33), 
(1009, 9, 'A', 4.00), 
(1010, 10, 'B-', 2.67), 
(1011, 11, 'B', 3.00), 
(1012, 12, 'A-', 3.67);

-- thêm khóa ngoại (bước 3)

ALTER TABLE faculty
ADD FOREIGN KEY (Head_id) REFERENCES lecturer(Lecturer_id);

ALTER TABLE lecturer
ADD FOREIGN KEY (Faculty_id) REFERENCES faculty(Faculty_id);

ALTER TABLE student
ADD FOREIGN KEY (Faculty_id) REFERENCES faculty(Faculty_id);

ALTER TABLE section
ADD FOREIGN KEY (Course_number) REFERENCES course(Course_number),
    FOREIGN KEY (Lecturer_id) REFERENCES lecturer(Lecturer_id),
    FOREIGN KEY (Building_id) REFERENCES building(Building_id);

ALTER TABLE grade_report
ADD FOREIGN KEY (Student_number) REFERENCES student(Student_number),
    FOREIGN KEY (Section_identifier) REFERENCES section(Section_identifier);

ALTER TABLE enrollment
ADD FOREIGN KEY (Student_number) REFERENCES student(Student_number),
    FOREIGN KEY (Section_identifier) REFERENCES section(Section_identifier);

ALTER TABLE prerequisite
ADD FOREIGN KEY (Course_number) REFERENCES course(Course_number),
    FOREIGN KEY (Prerequisite_course_number) REFERENCES course(Course_number);

                              --exercise--
--16. Calculate the average grade point for each course section.
SELECT section.Section_identifier, section.Course_number,
       AVG(grade_report.Grade_point) AS avg_grade_point
FROM section
LEFT JOIN grade_report 
    ON section.Section_identifier = grade_report.Section_identifier
GROUP BY section.Section_identifier, section.Course_number
ORDER BY section.Section_identifier;

--17. Determine the maximum capacity of sections in each building.
SELECT section.Building_id, MAX(section.Capacity) AS max_capacity
FROM section
GROUP BY section.Building_id
ORDER BY section.Building_id;

--18. Count the number of sections taught by each lecturer in 2024.
SELECT lecturer.Lecturer_id, lecturer.Name, COUNT(section.Section_identifier) AS num_sections_2024
FROM lecturer
LEFT JOIN section ON lecturer.Lecturer_id = section.Lecturer_id
    AND section.Year = 2024
GROUP BY lecturer.Lecturer_id, lecturer.Name
ORDER BY lecturer.Lecturer_id;

--19. Determine the sections with the maximum capacity of each building.
SELECT s.Building_id, s.Section_identifier, s.Course_number, s.Capacity
FROM section s
WHERE s.Capacity = (
    SELECT MAX(s2.Capacity) FROM section s2 WHERE s2.Building_id = s.Building_id
)
ORDER BY s.Building_id, s.Section_identifier;

--20. Find the minimum and maximum grade points for each course.
SELECT section.Course_number,
       MIN(grade_report.Grade_point) AS min_grade_point,
       MAX(grade_report.Grade_point) AS max_grade_point
FROM section
LEFT JOIN grade_report ON section.Section_identifier = grade_report.Section_identifier
GROUP BY section.Course_number
ORDER BY section.Course_number;

--21. Find the number of sections offered per course in each semester and year.
SELECT section.Course_number, section.Semester, section.Year, COUNT(section.Section_identifier) AS num_sections
FROM section
GROUP BY section.Course_number, section.Semester, section.Year
ORDER BY section.Course_number, section.Year, section.Semester;

--22. Calculate the average grade point for each lecturer, excluding sections with fewer than 5 graded students.
SELECT lecturer.Lecturer_id, lecturer.Name,
       AVG(g.Grade_point) AS lecturer_avg_grade
FROM lecturer
JOIN section ON lecturer.Lecturer_id = section.Lecturer_id
JOIN grade_report g ON section.Section_identifier = g.Section_identifier
WHERE section.Section_identifier IN (
    SELECT gr.Section_identifier
    FROM grade_report gr
    GROUP BY gr.Section_identifier
    HAVING COUNT(gr.Student_number) >= 5
)
GROUP BY lecturer.Lecturer_id, lecturer.Name
ORDER BY lecturer.Lecturer_id;

--23. Identify lecturers who teach more than one section in the same semester and year, and count their sections.
SELECT section.Lecturer_id, lecturer.Name, section.Semester, section.Year, COUNT(section.Section_identifier) AS num_sections
FROM section
JOIN lecturer ON section.Lecturer_id = lecturer.Lecturer_id
GROUP BY section.Lecturer_id, lecturer.Name, section.Semester, section.Year
HAVING COUNT(section.Section_identifier) > 1
ORDER BY section.Lecturer_id;

--24. Find courses with the highest average grade point in each faculty
-- step 1: compute average grade per (faculty, course) via sections taught by lecturers of that faculty
SELECT f.Faculty_id, f.Name AS Faculty_name,
       s.Course_number, AVG(g.Grade_point) AS avg_gp
FROM faculty f
JOIN lecturer l ON f.Faculty_id = l.Faculty_id
JOIN section s ON l.Lecturer_id = s.Lecturer_id
JOIN grade_report g ON s.Section_identifier = g.Section_identifier
GROUP BY f.Faculty_id, f.Name, s.Course_number;

-- step 2: pick course(s) with the max avg_gp per faculty
-- (one SQL way without WITH; here we present conceptual two-step; can also use correlated subquery)
SELECT f.Faculty_id, f.Name AS Faculty_name,
       s.Course_number, AVG(g.Grade_point) AS avg_gp
FROM faculty f
JOIN lecturer l ON f.Faculty_id = l.Faculty_id
JOIN section s ON l.Lecturer_id = s.Lecturer_id
JOIN grade_report g ON s.Section_identifier = g.Section_identifier
GROUP BY f.Faculty_id, f.Name, s.Course_number
HAVING AVG(g.Grade_point) = (
    SELECT MAX(avg_sub)
    FROM (
        SELECT AVG(g2.Grade_point) AS avg_sub
        FROM lecturer l2
        JOIN section s2 ON l2.Lecturer_id = s2.Lecturer_id
        JOIN grade_report g2 ON s2.Section_identifier = g2.Section_identifier
        WHERE l2.Faculty_id = f.Faculty_id
        GROUP BY s2.Course_number
    ) sub
)
ORDER BY f.Faculty_id;

--25. Find the average number of students enrolled per section for each course.
SELECT s.Course_number,
       (SUM(enr_counts.enr_count) / COUNT(DISTINCT s.Section_identifier)) AS avg_students_per_section
FROM section s
LEFT JOIN (
    SELECT enrollment.Section_identifier, COUNT(enrollment.Student_number) AS enr_count
    FROM enrollment
    GROUP BY enrollment.Section_identifier
) AS enr_counts ON s.Section_identifier = enr_counts.Section_identifier
GROUP BY s.Course_number
ORDER BY s.Course_number;

--26. Find lecturers who have taught in multiple buildings and have the highest total student enrollment across all their sections.
-- total enrollment per lecturer
SELECT lecturer.Lecturer_id, lecturer.Name, COUNT(enrollment.Student_number) AS total_enrollment,
       COUNT(DISTINCT section.Building_id) AS num_buildings
FROM lecturer
JOIN section ON lecturer.Lecturer_id = section.Lecturer_id
LEFT JOIN enrollment ON section.Section_identifier = enrollment.Section_identifier
GROUP BY lecturer.Lecturer_id, lecturer.Name
HAVING COUNT(DISTINCT section.Building_id) > 1
ORDER BY total_enrollment DESC;

--27. Find lecturers whose sections have consistently high enrollment (all sections above the average enrollment for their faculty).
SELECT l.Lecturer_id, l.Name
FROM lecturer l
WHERE NOT EXISTS (
    SELECT 1
    FROM section s
    LEFT JOIN (
        SELECT Section_identifier,
               COUNT(Student_number) AS enr_count
        FROM enrollment
        GROUP BY Section_identifier
    ) enr ON s.Section_identifier = enr.Section_identifier
    WHERE s.Lecturer_id = l.Lecturer_id
      AND ISNULL(enr.enr_count, 0) <= (
            SELECT AVG(cnt)
            FROM (
                SELECT s2.Section_identifier,
                       COUNT(e2.Student_number) AS cnt
                FROM lecturer l2
                JOIN section s2 ON l2.Lecturer_id = s2.Lecturer_id
                LEFT JOIN enrollment e2 ON s2.Section_identifier = e2.Section_identifier
                WHERE l2.Faculty_id = l.Faculty_id
                GROUP BY s2.Section_identifier
            ) T
      )
)
ORDER BY l.Lecturer_id;


--28. Find faculties with the largest number of students enrolled in the Spring sections of 2025 but have the smallest number of students who earned an A grade.
-- Tổng số sinh viên ghi danh theo khoa trong Spring 2025
SELECT f.Faculty_id, f.Name
FROM faculty f
JOIN lecturer l ON f.Faculty_id = l.Faculty_id
JOIN section s ON l.Lecturer_id = s.Lecturer_id
JOIN enrollment e ON s.Section_identifier = e.Section_identifier
WHERE s.Semester = 'Spring'
  AND s.Year = 2025
GROUP BY f.Faculty_id, f.Name
HAVING 
    -- Điều kiện 1: số sinh viên ghi danh = max của tất cả các khoa
    COUNT(e.Student_number) = (
        SELECT TOP 1 COUNT(e2.Student_number) AS total_enroll
        FROM faculty f2
        JOIN lecturer l2 ON f2.Faculty_id = l2.Faculty_id
        JOIN section s2 ON l2.Lecturer_id = s2.Lecturer_id
        JOIN enrollment e2 ON s2.Section_identifier = e2.Section_identifier
        WHERE s2.Semester = 'Spring'
          AND s2.Year = 2025
        GROUP BY f2.Faculty_id
        ORDER BY total_enroll DESC
    )
    AND
    -- Điều kiện 2: số sinh viên nhận A = nhỏ nhất các khoa
    (
        SELECT COUNT(*)
        FROM lecturer l3
        JOIN section s3 ON l3.Lecturer_id = s3.Lecturer_id
        JOIN grade_report g3 ON s3.Section_identifier = g3.Section_identifier
        WHERE l3.Faculty_id = f.Faculty_id
          AND s3.Semester = 'Spring'
          AND s3.Year = 2025
          AND g3.Grade_point = 4.00
    ) = (
        SELECT TOP 1 COUNT(*) AS total_A
        FROM faculty f4
        JOIN lecturer l4 ON f4.Faculty_id = l4.Faculty_id
        JOIN section s4 ON l4.Lecturer_id = s4.Lecturer_id
        JOIN grade_report g4 ON s4.Section_identifier = g4.Section_identifier
        WHERE s4.Semester = 'Spring'
          AND s4.Year = 2025
          AND g4.Grade_point = 4.00
        GROUP BY f4.Faculty_id
        ORDER BY total_A ASC
    );