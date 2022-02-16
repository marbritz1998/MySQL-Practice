-- creating a database to use for practice problems
-- problems can be found at https://www.edureka.co/blog/interview-questions/sql-query-interview-questions

CREATE DATABASE edureka;

USE edureka;

CREATE TABLE EmployeeInfo (
	EmpID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	EmpFname CHAR(25),
    EmpLname CHAR(25),
    Department CHAR(25),
    Project CHAR(25),
    Address CHAR(25),
    DOB DATETIME,
    Gender CHAR(25)
);

INSERT INTO EmployeeInfo
	(EmpID, EmpFname, EmpLname, Department, Project, Address, DOB, Gender) VALUES
		(1, 'Sanjay', 'Mehra', 'HR', 'P1', 'Hyderabad (HYD)', '1976-01-12', 'M'),
        (2, 'Ananya', 'Mishra', 'Admin','P2', 'Delhi (DEL)', '1968-02-05', 'F'),
        (3, 'Rohan', 'Diwan', 'Account', 'P3', 'Mumbai (BOM)', '1980-01-01', 'M'),
        (4, 'Sonia', 'Kulkarni', 'HR', 'P1', 'Hyderabad (HYD)', '1992-02-05', 'F'),
        (5, 'Ankit', 'Kapoor', 'Admin', 'P2', 'Delhi (DEL)', '1994-03-07', 'M');
        
CREATE TABLE EmployeePosition (
	EmpID INT,
    EmpPosition CHAR(25),
    DateOfJoining DATE,
    Salary INT,
    FOREIGN KEY (EmpID) REFERENCES EmployeeInfo(EmpID)
);


INSERT INTO EmployeePosition
	(EmpID, EmpPosition, DateofJoining, Salary) VALUES
    (1, 'Manager', '2022-01-05', 500000),
    (2, 'Executive', '2022-02-05', 75000),
    (3, 'Manager', '2022-01-05', 90000),
    (2, 'Lead', '2022-02-05', 85000),
    (1, 'Executive', '2022-01-05', 3000000);



        