
-- Table Creation

CREATE TABLE employees (     
        employee_id INT PRIMARY KEY,
        name VARCHAR(50),
        department_id INT,
        salary DECIMAL(10,2),
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
        );  

INSERT INTO employees VALUES (101, 'John Smith', 1, 60000), (102, 'Sarah Johnson', 2, 75000), (103, 'Mike Davis', 2, 70000), (104, 'Lisa Brown', 1, 55000), (105, 'Tom Wilson', 3, 65000), (106, 'Emma Taylor', NULL, 50000);

SELECT * FROM employees



CREATE TABLE departments (     
        department_id INT PRIMARY KEY,
        name VARCHAR(50),
        location VARCHAR(50)
        );  


INSERT INTO departments VALUES (1, 'Sales', 'New York'), (2, 'IT', 'Chicago'), (3, 'HR', 'Boston'), (4, 'Marketing', 'Seattle');

SELECT * FROM departments




CREATE TABLE projects (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        department_id INT,
        budget DECIMAL(10,2), 
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
        );
        
INSERT INTO projects VALUES (201, 'Website Redesign', 2, 100000), (202, 'Sales Campaign', 1, 50000), (203, 'HR System', 3, 75000), (204, 'Mobile App', NULL, 120000);

SELECT * FROM projects



-- Inner Join Task 1.1
select e.name as "Employee Name", d.name as "Department Name"
from employees as e
inner join 
departments as d
on e.department_id = d.department_id

select e.name as "Employee Name", d.location as "Department Location"
from employees as e
inner join
departments as d
on e.department_id = d.department_id


select p.name as "Project Name", d.name as "Department  Name"
from projects as p
inner join
departments as d
on p.department_id = d.department_id


select e.name as "Employee Name", d.name as "Department Name"
from employees as e
inner join
departments as d
on e.department_id = d.department_id
where d.name = 'Sales'


select e.name , d.name as "Department Name"
from employees as e
inner join
departments as d
on e.department_id = d.department_id
where e.salary > 60000



-- Inner Join Task 1.2
select p.name as "Project Name", p.budget as "Project Budgect", d.location as "Department Location"
from projects as p
inner join 
departments as d
on p.department_id = d.department_id





-- Outer Join (Left) Task 2.1
select e.name as "Employee Name", d.name as "Department Name"
from employees as e
left join
departments as d
on e.department_id = d.department_id


select d.name as "Department Name", p.name as "Project Name"
from departments as d
left join
projects as p
on d.department_id = p.department_id


select e.name as "Employee name", d.name as "Department Name"
from employees as e
left join 
departments as d
on e.department_id = d.department_id
where d.name is null


select d. name as "Department Name", count (e.name) as "Number of Employee"
from departments as d
left join
employees as e
on e.department_id = d.department_id
group by d.name



-- Subqueries Task 3.1
select e.name as "Employee Name"
from employees as e
where e.salary > (select avg(salary) from employees)


select e.name as "Employee Name"
from employees as e
where e.salary < (select avg(salary) from employees)


select e.name as "Employee Name"
from employees as e
where e.salary = (select max(salary) from employees)


select p.name as "Project Name"
from projects as p
where p.budget > (select avg(budget) from projects)





-- Subqueries with IN Task 3.2
select e.name as "Employee Name Who Works in Chicago Department"
from employees as e
where e.department_id in (select d.department_id 
                          from departments as d 
                          where d.location = 'Chicago'
                          )


select e.name as "Employees who have Projects"
from employees as e
where e.department_id in (select p.department_id 
                          from projects as p
                          )


select p.name "Project Name where Departments Located in Boston"
from projects as p
where p.department_id in (select d.department_id
                          from departments as d
                          where d.location = 'Boston'
                          )

select d.name as "Departments Which has no Projects"
from departments as d
where d.department_id not in (select p.department_id
                              from projects as p
                              where p.department_id is not null
                              )




-- Choose Your Approach  Task 4.1
select e.name as "Employee Name", e.salary as "Employee Salary", d.name as "Department Name"
from employees as e
left join
departments as d
on e.department_id = d.department_id


select e.name as "Emloyee Name", d.location as "Department Location"
from employees as e
inner join 
departments as d
on e.department_id = d.department_id
where e.salary > 65000


select p.name as "Projects Name", d.name as "Department Name"
from projects as p
left join 
departments as d
on p.department_id = d.department_id
where p.budget > 80000


select e.name as "Emloyee Name", d.name as "Department Name"
from employees as e
inner join 
departments as d
on e.department_id = d.department_id
where e.salary > (select avg(salary) from employees)
and d.name = 'IT'


select d.name as "Department Name"
from departments as d
inner join 
employees as e
on d.department_id = e.department_id
where e.salary >= 70000






-- Real-World Scenarios Task 4.2
select e.name as "Employee Name", d.name as "Department Name", d.location as "Department Location"
from employees as e
left join
departments as d
on e.department_id = d.department_id


select d.name as "Department Name", count(e.name) as "Total Emloyees", sum(e.salary) as "Total Salary"
from departments as d
left join 
employees as e
on d.department_id = e.department_id
group by d.name


select d.name AS "Department Name", avg(e.salary) as "Average Salary"
from departments as d
inner join employees as e
on d.department_id = e.department_id
group by d.name
order by avg(e.salary) desc
limit 1;


select p.name as "Project Name"
from projects as p
where p.department_id in (select e.department_id
                          from employees as e
                          group by e.department_id
                          having count(e.employee_id) > 1
                          )


select e.name as "Employee Name"
from employees as e
where e.department_id = (select department_id
                         from employees
                         where name = 'John Smith'
                         )


select * from employees
select * from departments
select * from projects 