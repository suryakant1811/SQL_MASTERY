CREATE DATABASE demo;
USE demo;

CREATE TABLE t1(
    id INT PRIMARY KEY,
    name VARCHAR(200)
);

INSERT INTO t1 VALUES (01, 'sakku'), (02, 'akku'), (03, 'kushi')

DROP DATABASE demo;

-- *******************************************************************************************************************************

CREATE DATABASE company_db;

USE company_db;

CREATE TABLE Worker (
  worker_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  salary INT,
  joining_date DATETIME,
  department VARCHAR(50)
--    PRIMARY KEY(worker_id) can write this which is a good approch insted writing it next to the id 
);


CREATE TABLE Bonus (
  worker_ref_id INT,
  bonus_amt INT,
  bonus_date DATETIME,
  FOREIGN KEY (worker_ref_id) REFERENCES Worker(worker_id)
);


CREATE TABLE Title (
  worker_ref_id INT,
  worker_title VARCHAR(50),
  affected_from DATETIME,
  FOREIGN KEY (worker_ref_id) REFERENCES Worker(worker_id)
);

-- can add  a "check" constarain in a attribute to give a certain condiftion as we have created slary add a constrain as CHECK (salary > 0) if this conditon fail while inserting the  values then it will not added
-- we have a "default" contarain as we can add a attribute as role and add this constain DEFAULT 'STUDENT' if you dont give any value to the attribute it will ba taken from here
-- "Primary key" is used for identcation and filterning and deleteing things, inserting things manipulating things, should be unique but cannot be null;
-- "Unique key" should be unique but can be null
-- "NOT NULL" this attribute tell that this field should not be null


INSERT INTO Worker VALUES
(1, 'Amit', 'Sharma', 50000, '2021-02-20 09:00:00', 'HR'),
(2, 'Rahul', 'Verma', 60000, '2020-06-15 10:00:00', 'IT'),
(3, 'Neha', 'Singh', 55000, '2019-03-10 11:00:00', 'Finance'),
(4, 'Priya', 'Mehta', 70000, '2018-07-25 09:30:00', 'IT'),
(5, 'Karan', 'Malhotra', 45000, '2022-01-12 08:45:00', 'HR'),
(6, 'Ankit', 'Gupta', 80000, '2017-05-20 10:15:00', 'Management'),
(7, 'Sneha', 'Kapoor', 75000, '2016-09-18 09:00:00', 'Finance'),
(8, 'Rohit', 'Agarwal', 62000, '2021-11-11 11:30:00', 'IT'),
(9, 'Pooja', 'Bansal', 58000, '2020-04-05 10:20:00', 'HR'),
(10, 'Vikas', 'Chopra', 90000, '2015-12-01 09:00:00', 'Management');


INSERT INTO Bonus VALUES
(1, 5000, '2022-03-01'),
(2, 3000, '2022-03-05'),
(3, 4000, '2022-03-07'),
(4, 3500, '2022-03-10'),
(5, 2000, '2022-03-12'),
(6, 7000, '2022-03-15'),
(7, 6500, '2022-03-18'),
(8, 3000, '2022-03-20'),
(9, 2500, '2022-03-22'),
(10, 8000, '2022-03-25');


INSERT INTO Title VALUES
(1, 'Manager', '2021-02-20'),
(2, 'Developer', '2020-06-15'),
(3, 'Accountant', '2019-03-10'),
(4, 'Senior Developer', '2018-07-25'),
(5, 'HR Executive', '2022-01-12'),
(6, 'CEO', '2017-05-20'),
(7, 'Senior Accountant', '2016-09-18'),
(8, 'Developer', '2021-11-11'),
(9, 'HR Manager', '2020-04-05'),
(10, 'Director', '2015-12-01');


-- lcase ucase for upper and lower cases tranform select lcase("fGdeTEf") 

-- for below two command use offset given at alst to optimese proper solving

-- find second max salary 
SELECT MAX(salary) FROM Worker WHERE salary < (SELECT MAX(salary) FROM Worker);

-- find second max salary and gives its depatment name salary

SELECT department, salary, first_name FROM Worker WHERE salary = (
    SELECT MAX(Salary) FROM Worker where salary < (SELECT MAX(salary) FROM Worker)
);

SELECT * FROM Worker WHERE salary BETWEEN 70000 AND 100000;  -- both values are also included

SELECT * FROM Worker WHERE department IN ( "HR", "IT", "CS" );  -- CS in not define in the table still works 

SELECT * FROM Worker WHERE department NOT IN ( "HR", "IT", "CS" );   

SELECT * FROM Worker WHERE department NOT IN ( "HR", "IT", "CS" ) AND salary > 70000;

SELECT * FROM Worker WHERE department NOT IN ( "HR", "IT", "CS" ) OR salary > 100000;

-- *********************************************************************************************************** 

-- PATTERN MATCHING (LIKE REGEXP)

-- "%s" matab last me s ho usek pahle jo bhi ho no problem
-- "s%" matab start me s ho usek baad jo bhi ho no problem
-- "%s%" matab beach me s ho usek pahle baadme jo bhi ho no problem
-- "___" matalb 3 word hone chaiye sirf
-- "_s%" matlab second letter s hone chaiy baad me kuch bhi ho

-- REGEXP  ^ start with $ ends with ^[xyz] start with x/y/z any od  the given value '^[a-z]' start with range from a to z  '^A|^R'; start with A or R 

SELECT * FROM Worker WHERE first_name LIKE "S%";               

SELECT * FROM Worker WHERE first_name LIKE "____";      -- name having four letter only 

SELECT * FROM Worker WHERE department LIKE "M%" ;

SELECT * FROM Worker WHERE first_name NOT LIKE "A%";   -- name not starting with A


-- ORDER BY [ASC (default) | DESC]

SELECT * FROM Worker where salary > 70000 ORDER BY salary ASC;   --not  writing ASC no probelm as it is default 

SELECT * FROM Worker where salary > 70000 ORDER BY first_name DESC;  

SELECT first_name, department, salary  FROM Worker ORDER BY department DESC, salary ASC ;

SELECT first_name, department, salary  FROM Worker ORDER BY department DESC, salary ASC LIMIT 3 ;  --limit used to get how many output in screen

SELECT first_name, department, salary  FROM Worker ORDER BY department DESC, salary ASC LIMIT 3 OFFSET 1;  --OFFSET to skip how much

SELECT * FROM Worker ORDER BY salary DESC LIMIT 1 OFFSET 1; -- solution to get the second higest 

-- DISTINCT (to get unique value from colums/anything)

SELECT department FROM Worker; --gives all 10 list of department

SELECT DISTINCT  department FROM Worker;  -- gives 4 differnet department that are overall 10 times shown differently

SELECT DISTINCT salary, department FROM Worker;

-- **************************************************************************************************************************************************

-- GROUP BY (always used with a aggregator if aggreagtor is not used it will work as DISTINCt and select next and Gropp by shouldbe also same check below )

SELECT department, COUNT(*) FROM Worker GROUP BY department;    -- department will be the group and we use aggreagtion of count(*) meaning each department has how many total entryies

SELECT department, SUM(salary) FROM Worker GROUP BY department;  -- department will be the group and we use aggreagtion of SUM(salary) meaning each department has total how much salary


-- EXECUTION ORDER IN SQL: FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY


--HAVING (workes after GROUP By to add any filter in the GROUP By )

SELECT department, sum(salary)  FROM Worker GROUP BY department;  -- shows sum of total salaries for each department and gives 4 departmenr with total salary next to it now you wanted to add some condition you uses this as in below command 

SELECT department, sum(salary)  FROM Worker GROUP BY department HAVING SUM(SALARY) > 180000 ;   

-- Worker table → split into departments → Each department → mini table → HAVING → filters those mini tables

-- ************************************************************************************************************************************************************

-- ALTER(to change in existing) (altering in pants existing but we need to do some changes)  --ADD, --MODIFY, --CHANGE, --DROP,  --RENAME 
-- Add column Modify column Delete column Add/remove constraints Rename table/column  

ALTER TABLE Worker ADD COLUMN age INT; -- age will be added with value NULL in each  to insert it in we will use other thing (update) and by giving , we can add mutilple attributes 
ALTER TABLE Worker MODIFY COLUMN age BIGINT  -- column is optional you can add or not not a problem.
ALTER TABLE Worker MODIFY  age BIGINT; -- age datatype changes (MODIFY USED TO CAHNEG THE DATATYPE) Existing data must fit new type cant do int to varchar

ALTER TABLE Worker CHANGE age ages INT;   -- change the cloumn name and its datatype at the same time 

ALTER TABLE Worker DROP ages;  -- remove the column delet parmananetly 

ALTER TABLE Worker RENAME TO Employees; -- change table name
ALTER TABLE Worker RENAME first_name TO f_name;  --change column name 

ALTER TABLE Worker ADD PRIMARY KEY (worker_id); --add primary key
ALTER TABLE Worker DROP PRIMARY KEY;

ALTER TABLE Worker ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE Worker DROP unique_email;


ALTER TABLE Bonus ADD CONSTRAINT fk_worker
FOREIGN KEY (worker_ref_id) REFERENCES Worker(worker_id);

ALTER TABLE Bonus DROP FOREIGN KEY fk_worker;

-- ************************************************************************************************************************************************************

-- DML == command used to modify the data of table 


-- insert command already done -- UPDATE to update existing thing -- DELETE to delete column -- REPLACE
INSERT INTO Worker VALUE (1, "anil")
UPDATE Worker SET salary = salary + 5000 
DELETE FROM Worker WHERE worker_id = 1;
REPLACE INTO Worker VALUE (1, "anil")  -- 1 is primary key if primary key is not present it will add if present then value gets updated 

-- ************************************************************************************************************************************************************

-- JOINS

SELECT * FROM Worker AS w  INNER JOIN Bonus AS b ON w.worker_id = b.worker_ref_id;

-- if ALIAS (AS) is used then only that should be used in intrire query
SELECT w.worker_id, w.first_name, w.last_name, b.bonus_amt FROM Worker AS w JOIN Bonus AS b ON w.worker_id = b.worker_ref_id;   

-- left join   all the content from left side table and matching thing from the right side table (comman)
select w.worker_id,  w.first_name, w.last_name, w.department, t.worker_title,  t.affected_from  from Worker as w join  Title as t on w.worker_id = t.worker_ref_id; 
select w.worker_id, w.first_name, w.last_name, b.bonus_amt from Worker as w left join Bonus as b on w.worker_id = b.worker_ref_id where bonus_amt IS NULL;

--added three table and created a new colums from the existing colums 
select w.worker_id, w.first_name, w.last_name, w.department, b.bonus_amt, (w.salary + b.bonus_amt) as total_salary  ,t.worker_title from Worker as w left join Bonus as b on w.worker_id = b.worker_ref_id left join Title as t on w.w
orker_id = t.worker_ref_id;












