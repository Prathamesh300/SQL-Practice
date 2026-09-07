use employeemanagement;
-- Level 1: Basic Queries -
-- 1. Display all employee details
select * from Employees;

-- 2.Display employee names and salaries only
select EmployeeName, Salary from Employees;

-- 3.Find employees with a salary greater than 50,000
select * from Employees where salary > 50000;

-- 4.Find employees whose age is less than 30
select * from Employees where Age < 30;

-- 5.Find employees from Pune
select * from Employees where City = "Pune";

-- 6.Find employees from Mumbai or Pune
select * from Employees where City = "Mumbai" or City = "Pune";

-- 7.Find employees hired after 2022-01-01
select * from Employees where HireDate > 2022-01-01;

-- 8.Display employees sorted by salary in descending order
select * from Employees order by Salary desc;

-- 9.Display the top 10 highest-paid employees
select * from Employees order by Salary desc limit 10;

-- 10.Find employees whose names start with 'A'
select * from Employees where EmployeeName like 'A%';

-- 11.Find employees whose names ends with 'n'
select * from Employees where EmployeeName like '%n';

-- 12.Find employees whose age is between 25 and 35
select * from Emloyees where Age between 25 and 35;

-- 13.Find Employees whose salary is between 40,000 and 80,000
select * from Employees where Salary between 40000 and 80000;

-- 14.Count the total number of employees
select count(*) from Employees;

-- 15.Find the average salary of all employees;
select avg(Salary) from Employees;

-- Level 2: Aggregate Functions & GroupBy -

-- 1.Count employees in each department.
select * from departments;
select departmentID,count(*) from Employees group by departmentID;

-- 2.Find the average salary for each department
select departmentID, avg(salary) as Average_salary from Employees group by departmentID;

-- 3.Find the maximum salary in each department
select departmentID, max(salary) as Maximum_salary from Employees group by departmentID;

-- 4.Find the minimum salary in each department
select departmentID, min(salary) as Minimum_salary from Employees group by departmentID;

-- 5.Find the total salary paid by each department
select departmentID, sum(salary) as total_salary from Employees group by departmentID;

-- 6.Display departments having more than 40 employees
select departmentID,count(*) from Employees group by departmentID having count(*) > 40;

-- 7.Find cities with more than 20 employees.
select City,count(*) as Employees_in_each_city from Employees group by City having count(*) > 20;

-- 8.Find the average age by department.
select DepartmentID,avg(Age) as Average_Age from Employees group by DepartmentID;

-- 9.Find the highest salary in each city.
select City,max(salary) as Highest_Salary_in_each_city from Employees group by City;

-- 10.Count male and female employees
select * from Employees;
select Gender, count(*) from Employees group by gender;

-- 11.Find departments where the average salary is above ₹60,000
select departmentID, avg(Salary) from Employees group by departmentID having avg(salary) > 60000;

-- 12.Count employees hired each year (use Year Function)
select * from Employees;
select year(HireDate) as Year, count(*) as Hired_Employees_Each_Year from Employees group by Year(HireDate);

-- 13.Find the total project budget
select * from Projects;
select sum(Budget) as Total_Project_Budget from Projects;

-- 14.Find the average project budget
select avg(Budget) as Average_Project_Budget from Projects;

-- 15.Find the project with the highest budget
select * from Projects order by Budget desc limit 1;
-- or
select * from Projects where Budget = (select max(budget) from Projects);

-- Level 3: Joins
select * from Employees;
-- Q1.Display employee names with department names
select e.EmployeeName,d.DepartmentName
from Employees e Join Departments d on e.DepartmentID = d.DepartmentID;

select * from Projects;
-- Display employee names with project names.
select e.EmployeeName,P.ProjectName
from Employee_Project ep Join employees e 
on ep.EmployeeID = e.EmployeeID
Join Projects P 
on ep.ProjectID = P.ProjectID;

-- Q3.Display project names with budgets
Select ProjectName, Budget from Projects;

-- Q4.Count employees working on each project.
select P.ProjectName, count(ep.EmployeeID) as Total_Employees
from Projects P 
Join Employee_Project ep
on P.ProjectID = ep.ProjectID
Group by P.ProjectName;

-- Q5.Find employees not assigned to any project
select e.EmployeeID,e.EmployeeName
from Employees e 
Left Join Employee_Project ep
on e.EmployeeID = ep.EmployeeID
where ep.ProjectID is Null;


-- Q6.Find departments with no employees
select d.departmentID, d.DepartmentName
from departments d
left join employees e
on d.departmentID = e.departmentID
where e.EmployeeID is null;

-- Q7.Display employee, department, and city
select * from Employees;
select * from departments;
select e.EmployeeName, d.departmentName, e.city
from employees e join departments d
on e.DepartmentID = d.DepartmentID;

-- Q8.Find all projects assigned to a specific employee -- Suppose take employee = 5
select * from Employees;
select * from departments;
select * from projects;
select * from employee_project;

select e.employeeName, p.ProjectName
from employee_project ep join employees e
on ep.EmployeeID = e.EmployeeID
join projects p
on ep.ProjectID = p.ProjectID
where e.EmployeeID = 5;

-- Q9.Find employees working on more than one project.
select * from Employees;
select * from departments;
select * from projects;
select * from employee_project;

select e.EmployeeName, count(ep.ProjectID) as Total_Projects
from employees e join employee_project ep
on e.EmployeeID = ep.EmployeeID
group by e.EmployeeID, e.EmployeeName
having count(ep.ProjectID) > 1;

-- Q10.Display project count for each employee
select e.EmployeeName , count(ep.ProjectID) as Projects
from Employees e left join employee_project ep
on e.EmployeeID = ep.EmployeeID
group by e.EmployeeID, e.EmployeeName;

-- Q11.Display department name and average salary
select * from departments;
select * from employees;
select d.departmentName, avg(e.salary) as Average_Salary
from departments d join employees e
on d.DepartmentID = e.departmentID
group by d.departmentID , d.departmentName;

-- Q.12.Find employees working in the Sales department.
select * from departments;
select * from employees;
select e.EmployeeName, d.departmentName
from Employees e left join departments d
on e.departmentID = d.departmentID
where d.DepartmentName = 'Sales';

-- Q13.Find employees in IT earning more than ₹70,000.
select e.EmployeeName,d.departmentName, e.Salary
from employees e join departments d
on e.departmentID = d.departmentID
where d.DepartmentName = 'IT' and e.Salary > 70000;

-- Q14.Find project budgets department-wise
select * from projects;
select * from departments;
select * from employee_project;
select * from employees;
select d.departmentName, sum(p.Budget) as Total_Budget
from departments d join Employees e
on d.DepartmentID = e.departmentID
join employee_project ep
on e.EmployeeID = ep.EmployeeID
join Projects p
on ep.ProjectID = p.ProjectID
group by d.DepartmentID, d.departmentName;

-- Q15.Find employees with department and project details
select * from projects;
select * from departments;
select * from employee_project;
select * from employees;
select e.EmployeeName,d.DepartmentName,p.ProjectName
from Employees e join departments d
on e.DepartmentID = d.DepartmentID 
join employee_project ep 
on e.EmployeeID = ep.EmployeeID
join projects p
on p.ProjectID = ep.ProjectID;

-- Q16.Display Each project along with the number of employees working on it
select * from projects;
select * from departments;
select * from employee_project;
select * from employees;
select p.projectName, count(e.EmployeeID) as Total_Employees
from projects p join employee_project ep
on p.ProjectID = ep.ProjectID
join Employees e
on e.EmployeeID = ep.EmployeeID
group by p.ProjectID,p.ProjectName;

-- Q17.Find Employees who earn more than the average salary of their department
select * from projects;
select * from departments;
select * from employee_project;
select * from employees;
select e.EmployeeName,e.salary,d.departmentName
from employees e left join departments d
on e.DepartmentID = d.DepartmentID
where e.salary >
(select avg(e2.salary) from Employees e2 
where e2.DepartmentID = e.DepartmentID);

-- Q18.Find Projects that have no employees assigned
select p.ProjectID,p.ProjectName
from projects p left Join employee_project ep
on p.ProjectID = ep.ProjectID
where ep.ProjectID is null;

-- Q19.Display each department with its employee count and Project count.
select d.DepartmentName,count(distinct e.EmployeeID) as Total_Employees,count(distinct ep.ProjectID) as Total_Projects
from departments d  left Join Employees e
on d.DepartmentID = e.departmentID
left join employee_project ep 
on ep.EmployeeID = e.EmployeeID
Group by d.DepartmentID,d.DepartmentName;

-- Q20.Display employee name,department name,project name,salary,and budget,sorted by salary(highest first)
select e.EmployeeName,d.departmentName,p.ProjectName,e.Salary,p.budget
from employees e join departments d
on e.DepartmentID = d.DepartmentID
join employee_project ep
on e.EmployeeID = ep.EmployeeID
join projects p
on ep.ProjectID = p.ProjectID
order by e.salary desc;

-- Find the department with the highest average salary
select d.departmentName,avg(e.salary) as avg_salary
from departments d join Employees e
on d.DepartmentID = e.DepartmentID
group by d.departmentID,d.departmentName
order by avg_salary desc limit 1;


-- Level 4 : SubQueries

-- Q1.Find Employees who earn more than the average salary
select * from Employees where salary >
(select avg(salary) from Employees);

-- Q2.Find the Employees with the highest salary
select * from Employees where salary = 
(select max(salary) from Employees);

-- Q3.Find the Employees with the second highest salary.
select * from Employees where salary =
(select max(salary) from Employees
where salary < (select max(salary) from Employees));



-- Q5.Find the second-highest salary using a subquery
select * from Employees where Salary = 
(select max(Salary) from Employees where Salary <
(select max(Salary) from Employees));

-- Q6.Find the third-highest salary using a subquery.
select * from Employees where Salary =
(select max(Salary) from Employees where Salary <
(select max(Salary) from Employees where Salary <
(select max(Salary) from Employees)));

-- Q7.Find employees whose salary is greater than the average salary of all employees.
select * from Employees where Salary >
(select avg(Salary) from Employees);

-- Q8.Find the employee(s) who have the highest salary
select * from Employees where Salary =
(select max(Salary) from Employees);

-- Q9.Find employees whose salary is less than the average salary.
select * from Employees where Salary <
(select avg(Salary) from Employees);

-- Q10.Find employees who earn the same salary as the employee with EmployeeID = 10.
select * from Employees where Salary = 
(select Salary from Employees where EmployeeID = 10);

-- Q11.Find employees who work in the same department as EmployeeID = 25
select * from Employees where DepartmentID = 
(select DepartmentID from Employees where EmployeeID = 25);

-- Q12.Employees working in departments having more than 50 Employees.
select * from Employees where departmentID in
(select departmentID from Employees group by departmentID having count(*) > 50);

-- Window Functions
-- Row Numbers
-- Q1.Assign a unique row number to every employee based on salary from highest to lowest.
select EmployeeID,EmployeeName,Salary,row_number() over (order by Salary desc) as RowNumber from Employees;

-- Q2.Assign a row number to employees within each department, ordered by salary from highest to lowest.
select EmployeeID,EmployeeName,DepartmentID,Salary,row_number() over (partition by departmentID order by Salary desc) as RowNumber from Employees;

-- Q3.Find the top 3 highest-paid employees in each department using ROW_NUMBER().
select * from
(select EmployeeName,departmentID,salary,row_number() over (partition by departmentID order by Salary desc) as RowNumber 
from Employees ) as Rnk
where RowNumber <= 3;

-- Q4.Find the most recently hired employee in each department using ROW_NUMBER().
select * from EMployees;
select * from
(select DepartmentID,EmployeeName,HireDate,row_number() over(partition by departmentID order by HireDate desc )  as Hireddate 
from Employees) as Rnk
where Hireddate = 1 ;

-- Q5.Find the oldest employee in each department using ROW_NUMBER().
select * from
(select DepartmentID,EmployeeName,HireDate,row_number() over (partition by departmentID order by HireDate) as Hireddate
from Employees) as Rnk
where Hireddate = 1;

-- RANK() and DENSE_RANK()
-- Q6.Rank all employees based on salary from highest to lowest.
select EmployeeID,EmployeeName,Salary,rank() over(order by Salary desc) from Employees;

-- Q7.Rank employees based on salary within each department
select DepartmentID,EmployeeName,Salary,rank() over (partition by departmentID order by Salary desc) from Employees;

-- Q8.Find the employees with the highest salary in each department using RANK().
select * from
(select DepartmentID,EmployeeName,Salary,rank() over (partition by departmentID order by Salary desc) as RankNumber
from Employees) as Rnk
where RankNumber = 1;

-- Q9.Find the second-highest salary in each department using DENSE_RANK()
select * from
(select DepartmentID,EmployeeName,Salary,dense_rank() over (partition by departmentID order by Salary desc) as RankNumber
from Employees) as Rnk
where RankNumber = 2;

-- Q10.Find the third-highest salary in each department using DENSE_RANK()
select * from
(select DepartmentID,EmployeeName,Salary,dense_rank() over (partition by departmentID order by Salary desc) as RankNumber
from Employees) as Rnk
where RankNumber = 3;

-- Q11.Find all employees who share the same salary rank.
select EmployeeName,Salary,dense_rank() over (order by Salary desc) as SalaryRank from Employees;

-- Aggregate Window Functions

-- Q12.Display each employee's salary along with the average salary of the company.
select * from Employees;
select EmployeeID,EmployeeName,Salary,avg(Salary) over() as CompanyAvgSalary from Employees;

-- Q13.Display each employee's salary along with the average salary of their department.
select EmployeeID,EmployeeName,DepartmentID,Salary,avg(Salary) over(partition by DepartmentID) as DepartmentAvgSalary from Employees;

-- Q14.Display each employee's salary along with the total salary of their department.
select EmployeeID,EmployeeName,DepartmentID,Salary,sum(Salary) over(partition by departmentID) as TotaldeptSalary from Employees;

-- Q15.Calculate what percentage of the department's total salary each employee earns.
select EmployeeID,EmployeeName,departmentID,Salary,ROUND(Salary * 100.0 /
        SUM(Salary) OVER (PARTITION BY DepartmentID),2) AS SalaryPercentage from employees;

-- Q16.Display each employee's salary and the maximum salary in their department.
select EmployeeID,EmployeeName,DepartmentID,Salary,max(Salary) over(partition by DepartmentID) as MaxDeptSalary 
from Employees;

-- Q17.Display each employee's salary and the minimum salary in their department.
select EmployeeID,EmployeeName,DepartmentID,Salary,min(Salary) over(partition by DepartmentID) as MinDeptSalary
from Employees;

-- Q18.Display each employee's salary and the difference between their salary and the department's average salary.
select EmployeeID,EmployeeName,DepartmentID,Salary,avg(Salary) over(partition by DepartmentID) as DeptAvgSalary,
Salary - avg(Salary) over(partition by DepartmentID) as AvgDifference from Employees;























