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

-- Begginer:
-- 1. Create a CTE called HighPaid that selects all employees with a salary over 60,000.[1][2][3][4] In the main query, select only the Name and Department from this CTE.
WITH HighPaid AS (
     SELECT e.Name AS "Employee Name", e.Salary AS "Employee Salary"
     FROM Employees AS e
     Where e.Salary > 5000
)

SELECT * FROM HighPaid;




-- 2. Write a CTE that calculates the total Amount of sales for each EmployeeID. Join this CTE with the Employees table to display the employee's name and their total sales.
WITH TotalAmountOfSales AS (
     SELECT s.EmployeeID AS "EmployeeID", SUM(s.Amount) AS "EmployeeTotalSales"
     FROM MonthlySales AS s
     GROUP BY EmployeeID

)

SELECT e.Name AS "Employee Name", ts.EmployeeTotalSales AS "Total Sales"
FROM Employees AS e
JOIN 
TotalAmountOfSales AS ts
ON e.EmployeeID = ts.EmployeeID




--3. Create a CTE to find the average salary for each department. In the final output, show the department name and its average salary, ordered from highest to lowest.
WITH DepatAvg AS (
        SELECT e.Department AS "DepartmentName", AVG(e.Salary) AS "DepartmentAvgSalary"
        FROM Employees AS e
        GROUP BY e.Department
)

SELECT * FROM DepatAvg
ORDER BY DepartmentAvgSalary DESC



-- Intermediate:
-- 1. Filter the results to show only the employees whose individual salary is higher than their department's average.
WITH DepatAvg AS (
        SELECT e.Department AS "DepartmentName", AVG(e.Salary) AS "DepartmentAvgSalary"
        FROM Employees AS e
        GROUP BY e.Department
)

SELECT e.Name AS "EmplyeeName", e.Salary AS "EmployeeSalary", e.Department AS "EmployeeDepartment", da.DepartmentAvgSalary AS "DepartmentAvgSalary"
FROM Employees AS e
JOIN
DepatAvg AS da
ON e.Department = da.DepartmentName
WHERE e.Salary > da.DepartmentAvgSalary




-- 2.0 Create a CTE called EmpSales that calculates the total sales amount for each employee.
-- 2.1 Create a second CTE (you can use a comma) called CompanyAvg that calculates the average of those totals (the average sales per
-- 2.2 In the main query, select the employees who sold more than the company average
WITH EmpSales AS (
        SELECT s.EmployeeID AS "EmployeeID", SUM(s.Amount) AS "TotalSales"
        FROM MonthlySales AS s
        GROUP BY s.EmployeeID
        
), 
CompanyAvg AS (
        SELECT AVG(TotalSales) AS "TotalsAvg"
        FROM EmpSales
)

SELECT e.Name AS "EmployeeName", es.TotalSales AS "TotalSales"
FROM Employees AS e
JOIN
EmpSales as es
ON e.EmployeeID = es.EmployeeID
WHERE es.TotalSales  > (SELECT AVG(TotalsAvg) FROM CompanyAvg)
