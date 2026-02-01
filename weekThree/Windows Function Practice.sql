-- This Database is created to practice the Windows Function.

-- Here I will reflect my own understanding about all things related Windows Function.

-- What is Windows Function: first of all we have to know its not the effecting our existing tables which we already defined its a quering comands to bring what is available (Exist)
-- and do the calculation on it.

-- Not same as "Group By" becuse the group by we used it for summarization and in high level like sum of males and females or avg salary about them. While the Windows Function is 
-- used to get orcalculate the specific and for each row for example --> makes with their names and sum of their salary but when we use group by we use base on category in high level.

-- So lets practice this by createing the tables and inserting data into them:

-- Tables Creation:
-- Employee table:
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary INT
)


-- Monthly salary:
CREATE TABLE MonthlySales (
    SaleID  PRIMARY KEY,
    SaleDate DATE,
    Category VARCHAR(50),
    Amount INT,
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
)


-- Data Inserting:
-- Employees details data insertion:
INSERT INTO Employees VALUES
(1, 'Alice', 'Sales', 5000),
(2, 'Bob', 'Sales', 6000),
(3, 'Charlie', 'Sales', 6000),
(4, 'David', 'IT', 4500),
(5, 'Eve', 'IT', 8000),
(6, 'Frank', 'IT', 4500),
(7, 'Grace', 'HR', 5000),
(8, 'Heidi', 'HR', 5500);

SELECT * FROM Employees


-- Monthly salary details data insertion:
INSERT INTO MonthlySales VALUES
(1, '2023-01-01', 'Electronics', 1000, 1),
(2, '2023-01-15', 'Electronics', 1200, 2),
(3, '2023-02-01', 'Electronics', 800, 3),
(4, '2023-02-15', 'Electronics', 2000, 4),
(5, '2023-01-01', 'Clothing', 500, 1),
(6, '2023-01-20', 'Clothing', 600, 3),
(7, '2023-02-05', 'Clothing', 400, 1),
(8, '2023-02-25', 'Clothing', 700, 5);

SELECT * FROM MonthlySales



-- Let's practice!!!!"

-- 1. Row Numbers: Assign a unique row number to every employee, ordered by their salary (highest to lowest):
SELECT e.Name AS "Employee Name", e.Salary AS "Employee Salary",
ROW_NUMBER() OVER(ORDER BY Salary DESC) AS "ROW_NUMBER"
FROM Employees AS e

-- 2. Ranking: Rank employees by salary within each department. Use RANK() and notice what happens when Bob and Charlie have the same salary ($6000). Compare this with DENSE_RANK():
SELECT e.Name AS "Employee Name", e.Salary AS "Employee Salary", e.Department AS "Employee Department",
RANK() OVER (ORDER BY Salary DESC) AS "RANK"
FROM Employees AS e

-- As we can see when we use RANK() we realized that if the salary is the same we put same number BUT the next number is not 6 but its 7 it goes with the real number it passes
-- becase it sees the row so if its in the 7th row so the value is 7 it not see the pervious value.

SELECT e.Name AS "Employee Name", e.Salary AS "Employee Salary", e.Department AS "Employee Department",
DENSE_RANK() OVER (ORDER BY Salary DESC) AS "DENSE RANK"
FROM Employees AS e

-- See, here we used DENSE_RANK() and the value it not based on the row location it based on the prevoius value it increased by 1.
