-- SQL: Grupowanie i analiza
-- 1. Grupowanie i sortowanie
-- Załóżmy, że masz tabelę Sales:

-- SaleID (unikalne ID transakcji),
-- Region (region sprzedaży),
-- Amount (kwota transakcji),
-- Date (data transakcji).
-- Zadania:

-- Policz liczbę transakcji (COUNT) oraz sumę (SUM) dla każdego regionu.
-- Znajdź region, który miał największą liczbę transakcji.
-- 2. Praca z podzapytaniami
-- Załóżmy, że masz tabelę Employees:

-- EmployeeID,
-- Name,
-- Salary,
-- DepartmentID.
-- Zadania:

-- Wyświetl nazwiska pracowników, którzy zarabiają więcej niż średnia pensja w ich dziale.
-- Znajdź nazwę działu, w którym pracownik o najwyższej pensji pracuje.

with cte as
(SELECT  MAX(Salary) as max_salary,  DepartmentID
FROM Employees
group by DepartmentID)
select e.Name, e.DepartmentID, e.Salary
FROM cte c
JOIN Employees e
ON c.max_salary = e.salary;

SELECT Name, Salary, DepartmentID
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees);





with CTE as 
(SELECT AVG(Salary) as avg_salary, DepartmentID
FROM Employees
Group by DepartmentID)
SELECT e.Name, c.avg_salary, e.Salary, e.DepartmentID
from CTE c
JOIN Employees e
ON c.DepartmentID = e.DepartmentID
WHERE e.Salary > c.avg_salary;

SELECT e.Name, e.Salary, e.DepartmentID
FROM Employees e
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM Employees
    WHERE DepartmentID = e.DepartmentID
);
SELECT Name, Salary, DepartmentID
FROM (
    SELECT Name, Salary, DepartmentID, AVG(Salary) OVER (PARTITION BY DepartmentID) AS AvgSalary
    FROM Employees
) AS SubQuery
WHERE Salary > AvgSalary;



SELECT Count(SaleID) as liczba_tr, SUM(Amount) as suma_region, Region
FROM Sales
GROUP BY Region;

SELECT Count(SaleID) as liczba_tr , Region
FROM Sales
GROUP BY Region
order by liczba_tr
-- #LIMIT 1;

WITH RegionCounts AS (
    SELECT Region, COUNT(SaleID) AS liczba_tr
    FROM Sales
    GROUP BY Region
)
SELECT Region, liczba_tr
FROM RegionCounts
WHERE liczba_tr = (SELECT MAX(liczba_tr) FROM RegionCounts);
