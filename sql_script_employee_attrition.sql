USE project1;
select * from hr_data;

-- Retrieve number of employees who have left, have not left and the total number of employees
select count(*) from hr_data where attrition = 'Yes'; 

select count(*) from hr_data where attrition = 'No'; 

select count(*) from hr_data; -- total of 1470 employees in the company

-- calculate attrition rate of employees
SELECT (EmployeesLeft / TotalEmployees) * 100 AS AttritionRate
FROM (
    SELECT COUNT(Attrition) AS EmployeesLeft
    FROM hr_data
    WHERE Attrition = 'Yes'
) AS LeftEmployees,
(
    SELECT COUNT(*) AS TotalEmployees
    FROM hr_data
) AS Total;

-- Calculate attrition rate of employees who have not left
SELECT (EmployeesStayed / TotalEmployees) * 100 AS RetentionRate
FROM (
    SELECT COUNT(Attrition) AS EmployeesStayed
    FROM hr_data
    WHERE Attrition = 'No'
) AS StayedEmployees,
(
    SELECT COUNT(*) AS TotalEmployees
    FROM hr_data
) AS Total;

-- retrieve number of employees in the different departments
select department, COUNT(department) as dept_count
from hr_data
group by department
order by 2 desc;

-- Identify the departments or teams with the highest attrition rates.
SELECT Department, (DepLeft / TotalEmployees) * 100 AS AttritionRate
FROM (
    SELECT department, COUNT(Department) AS DepLeft
    FROM hr_data
    WHERE Attrition = 'Yes'
    group by department
    order by 2 desc
) AS LeftEmployees,
(
    SELECT COUNT(*) AS TotalEmployees
    FROM hr_data
    where Attrition='Yes'
) AS Total; 

-- Retrieve job role in department research & development who left the company
select jobrole, count(jobrole)
from hr_data
where attrition = 'Yes' and department = 'Research & Development'
group by jobrole
order by 2 DESC;

-- Job roles with highest attrition count and attrition rate
select jobrole, count(jobrole) AS AttritionCount, (COUNT(*)/(SELECT COUNT(*) from hr_data where Attrition = 'Yes'))*100 AS AttritionPercentage
from hr_data
where Attrition = 'Yes'
group by jobrole
order by 2 desc;

-- average job satisfaction of employees in their job roles
Select jobrole, avg(jobsatisfaction) 
from hr_data
where attrition='Yes' and jobrole IN ('Laboratory Technician', 'Sales Executive', 'Research Scientist', 'Sales Representative')
group by 1
order by 2 desc; 

-- see maximum job satisfaction
select max(jobsatisfaction)
from hr_data; -- maximum is 4

-- -- -- -- -- -- -- --  Analyze the distribution of attrition by age, gender, and marital status -- -- -- -- -- -- 

-- see max and min age
select MIN(age) from hr_data; -- 18 years old
select max(age) from hr_data; -- 60 years old

-- see percentage/attrition rate of age
select age, count(age) AS AttritionCount, (COUNT(*)/(SELECT COUNT(*) from hr_data where Attrition = 'Yes'))*100 AS AttritionPercentage
from hr_data
where Attrition = 'Yes'
group by age
having age >=18
order by 2 Desc;

-- group ages into bins/age ranges and determine which age group has the highest attrition count
select count(age) as AgeCount,
case 
		when age between 18 and 24 then '18-24'
		when age between 25 and 34 then '25-34'
		when age between 35 and 44 then '35-44'
		when age between 45 and 54 then '45-54'
		when age between 55 and 60 then '55-60'
	end age_range
from hr_data
where  attrition ='yes' 
group by age_range
order by 1 desc; 

-- see gender count and  attrition rate of employees 
select gender, count(gender) AS AttritionCount, (COUNT(*) / (SELECT COUNT(*) FROM hr_data WHERE Attrition = 'Yes')) * 100 AS AttritionPercentage
from hr_data
where attrition ='Yes'
group by gender
order by 2 desc;

-- retrieve marital status count of employees who have left
select maritalstatus, count(maritalstatus)
from hr_data
where attrition = 'Yes' 
group by 1
order by 2 desc;

-- -- -- -- -- -- -- --  Analyze the distribution of attrition by salary, salary hike -- -- -- -- -- -- 
select jobrole, avg(yearlyincome), avg(percentsalaryhike)
from hr_data
where attrition='Yes'
group by 1
order by 2; 

-- -- -- -- --  Analyze the distribution of attrition by job level, years at company, years in current role, years since last promotion   -- -- -- -- -- -- 
-- Find out the average tenure of an employee before they left
select avg(yearsatcompany)
from hr_data
where attrition = 'Yes'; -- average tenure is 5.1308

select jobrole, avg(joblevel) AS avgJobLevel, avg(YearsAtCompany) AS AverageTenure, avg(yearsincurrentrole) AS AvgYearsInCurrentRole, avg(yearssincelastpromotion) AS AvgYearsSinceLastPromo
from hr_data
where attrition = 'Yes' and age between 25 and 34
group by 1
having avg(yearsatcompany) <=4
order by 2; 

-- -- -- -- -- -- -- -- -- Find out environment satisfaction, work-life balance and performance rating
-- job roles with highest environment satisfaction
select jobrole, avg(environmentsatisfaction)
from hr_data
where attrition = 'Yes' and age between 25 and 34
group by 1
order by 2; 

-- look at work life balance
select jobrole, avg(worklifebalance)
from hr_data
where attrition = 'Yes' and age between 25 and 34
group by jobrole
having avg(yearsatcompany) <= 4
order by 2;

-- look at performance rating
select jobrole, avg(performancerating)
from hr_data
where attrition = 'Yes'
group by 1
order by 2 desc;

-- what is the maximum performance rating?
select max(performancerating)
from hr_data;










