-- 1. Factors influencing employee performance ratings
SELECT e.EmployeeID, e.JobRole, e.Education, p.ManagerRating, p.SelfRating
FROM Employee e
JOIN PerformanceRating p ON e.EmployeeID = p.EmployeeID; 

-- 2. Job satisfaction by department
SELECT d.Dempartment_Name, AVG(p.JobSatisfaction) AS AvgJobSatisfaction
FROM Employee e
JOIN Department d ON e.Department = d.Department_ID
JOIN PerformanceRating p ON e.EmployeeID = p.EmployeeID
GROUP BY d.Dempartment_Name;

--3.Correlation between work-life balance and performance
SELECT WorkLifeBalance, AVG(ManagerRating) AS AvgManagerRating
FROM PerformanceRating
GROUP BY WorkLifeBalance;

-- 4. Job satisfaction and training opportunities
SELECT TrainingOpportunitiesWithinYear, AVG(JobSatisfaction) AS AvgJobSatisfaction
FROM PerformanceRating
GROUP BY TrainingOpportunitiesWithinYear;

-- 5. Relationship between years at the company and job satisfaction
SELECT y.YearsAtCompany, AVG(p.JobSatisfaction) AS AvgJobSatisfaction
FROM EmpoYearsInfo y
JOIN PerformanceRating p ON y.EmployeeID = p.EmployeeID
GROUP BY y.YearsAtCompany;

-- 6. Primary factors influencing attrition
SELECT e.Gender, e.Age, e.JobRole, e.OverTime, e.Salary, e.Attrition
FROM Employee e
WHERE e.Attrition = 'Yes';

-- 7. Attrition rates across job roles 
SELECT JobRole, COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount,
       (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS AttritionRate
FROM Employee 
GROUP BY JobRole;

-- 8. Relationship between job satisfaction and attrition
SELECT JobSatisfaction, COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN e.Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM PerformanceRating p
JOIN Employee e ON p.EmployeeID = e.EmployeeID
GROUP BY JobSatisfaction;

-- 9. Impact of overtime on attrition
SELECT OverTime, COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM Employee
GROUP BY OverTime;

-- 10 Career progression across departments
SELECT d.Dempartment_Name, AVG(y.YearsSinceLastPromotion) AS AvgYearsForPromotion
FROM Employee e
JOIN Department d ON e.Department = d.Department_ID
JOIN EmpoYearsInfo y ON e.EmployeeID = y.EmployeeID
GROUP BY d.Dempartment_Name;

-- 11 Employees not promated more than 3 years in company
SELECT e.EmployeeID, e.JobRole, y.YearsAtCompany, y.YearsInMostRecentRole
FROM Employee e
JOIN EmpoYearsInfo y ON e.EmployeeID = y.EmployeeID
WHERE y.YearsInMostRecentRole = y.YearsAtCompany and YearsInMostRecentRole > 3

-- 12 Impact of current manager on promotion likelihood
SELECT y.YearsWithCurrManager, AVG(y.YearsSinceLastPromotion) AS AvgPromotionTime
FROM EmpoYearsInfo y
GROUP BY y.YearsWithCurrManager;

-- 13 Performance rating and promotions
SELECT p.ManagerRating, AVG(y.YearsSinceLastPromotion) AS AvgPromotionTime
FROM PerformanceRating p
JOIN EmpoYearsInfo y ON p.EmployeeID = y.EmployeeID
GROUP BY p.ManagerRating;

-- 14 Salary variation by education level
SELECT e.Education, AVG(e.Salary) AS AvgSalary
FROM Employee e
GROUP BY e.Education 
order by Education 

-- 15 Stock options and employee retention
SELECT StockOptionLevel, COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS RetainedEmployees,
	   SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END) AS AttritionEmployees
FROM Employee 
GROUP BY StockOptionLevel; 

-- 16 Travel frequency and salary
SELECT BusinessTravel, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY BusinessTravel;

-- 17 Salary comparison by state
SELECT State, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY State;

-- 18 Relationship between commuting distance and satisfaction
SELECT e.DistanceStatus, AVG(p.JobSatisfaction) AS AvgJobSatisfaction
FROM Emplo_Distance e
JOIN PerformanceRating p ON e.EmployeeID = p.EmployeeID
GROUP BY e.DistanceStatus;

-- 19 Impact of distance on attrition
SELECT e.DistanceStatus, COUNT(*) AS TotalEmployees,
       SUM(CASE WHEN emp.Attrition = 'Yes' THEN 1 ELSE 0 END) AS AttritionCount
FROM Emplo_Distance e
JOIN Employee emp ON e.EmployeeID = emp.EmployeeID
GROUP BY e.DistanceStatus;

-- 20 Departments with distant employees
SELECT d.Dempartment_Name, COUNT(*) AS TotalFarDistantEmployees
FROM Emplo_Distance e
JOIN Employee emp ON e.EmployeeID = emp.EmployeeID
JOIN Department d ON emp.Department = d.Department_ID
WHERE e.DistanceStatus = 'Far'
GROUP BY d.Dempartment_Name;
