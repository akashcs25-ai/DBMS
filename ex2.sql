 USE university_db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> 
mysql> CREATE TABLE students (
    ->     student_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(100) NOT NULL,
    ->     email VARCHAR(100) NOT NULL UNIQUE
    -> );
ERROR 1050 (42S01): Table 'students' already exists
mysql> 
mysql> CREATE TABLE courses (
    ->     course_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     course_name VARCHAR(100) NOT NULL,
    ->     credits INT NOT NULL,
    ->     CHECK (credits > 0 AND credits <= 6)
    -> );
ERROR 1050 (42S01): Table 'courses' already exists
mysql> 
mysql> CREATE TABLE enrollments (
    ->     enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     student_id INT NOT NULL,
    ->     course_id INT NOT NULL,
    ->     enrollment_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    -> 
    ->     FOREIGN KEY (student_id) REFERENCES students(student_id)
    ->         ON DELETE CASCADE
    ->         ON UPDATE CASCADE,
    -> 
    ->     FOREIGN KEY (course_id) REFERENCES courses(course_id)
    ->         ON DELETE CASCADE
    ->         ON UPDATE CASCADE,
    -> 
    ->     UNIQUE (student_id, course_id)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> 
mysql> INSERT INTO students (name, email)
    -> VALUES
    -> ('Alice Johnson', 'alice@example.com'),
    -> ('Bob Smith', 'bob@example.com');
ERROR 1062 (23000): Duplicate entry 'alice@example.com' for key 'students.email'
mysql> 
mysql> SELECT * FROM students;
+------------+---------------+--------------------+
| student_id | name          | email              |
+------------+---------------+--------------------+
|          1 | patchi        | patchi@example.com |
|          7 | Alice Johnson | alice@example.com  |
|          8 | Bob Smith     | bob@example.com    |
+------------+---------------+--------------------+
3 rows in set (0.00 sec)

mysql> 
mysql> INSERT INTO courses (course_name, credits)
    -> VALUES
    -> ('Database Systems', 3),
    -> ('Computer Networks', 4);
ERROR 3819 (HY000): Check constraint 'courses_chk_1' is violated.
mysql> 
mysql> SELECT * FROM courses;
Empty set (0.00 sec)

mysql> 
mysql> INSERT INTO enrollments (student_id, course_id)
    -> VALUES
    -> (1, 1),
    -> (2, 1),
    -> (1, 2);
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`university_db`.`enrollments`, CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE)
mysql> 
mysql> SELECT * FROM enrollments;
Empty set (0.00 sec)

mysql> 
mysql> DELETE FROM students
    -> WHERE student_id = 2;
Query OK, 0 rows affected (0.00 sec)

mysql> 
mysql> DELETE FROM courses
    -> WHERE course_id = 2;
Query OK, 0 rows affected (0.00 sec)

mysql> 
mysql> SELECT * FROM students;
+------------+---------------+--------------------+
| student_id | name          | email              |
+------------+---------------+--------------------+
|          1 | patchi        | patchi@example.com |
|          7 | Alice Johnson | alice@example.com  |
|          8 | Bob Smith     | bob@example.com    |
+------------+---------------+--------------------+
3 rows in set (0.00 sec)

mysql> 
mysql> SELECT * FROM courses;
Empty set (0.00 sec)

mysql> 
mysql> DROP TABLE IF EXISTS enrollments;
Query OK, 0 rows affected (0.02 sec)

mysql> 
mysql> DROP TABLE IF EXISTS students;
ERROR 3730 (HY000): Cannot drop table 'students' referenced by a foreign key constraint 'enrollment_ibfk_1' on table 'enrollment'.
mysql> 
mysql> DROP TABLE IF EXISTS courses;
ERROR 3730 (HY000): Cannot drop table 'courses' referenced by a foreign key constraint 'enrollment_ibfk_2' on table 'enrollment'.
mysql> 
mysql> DROP DATABASE university_db;


