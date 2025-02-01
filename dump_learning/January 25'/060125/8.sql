-- SQL: Funkcje okna i zaawansowane operacje
-- 1. Funkcje okna
-- Załóżmy, że masz tabelę Employees:

-- EmployeeID, Name, Salary, DepartmentID.
-- Zadania:

-- Dodaj kolumnę Rank, która przypisuje rangę (od najwyższej do najniższej pensji) w obrębie każdego działu (DepartmentID).
-- Policz średnią pensję w każdym dziale, a następnie dodaj kolumnę SalaryDifference, która pokazuje różnicę między pensją pracownika a średnią pensją w jego dziale.
-- 2. Zagnieżdżone podzapytania
-- Załóżmy, że masz tabelę Sales:

-- SaleID, Region, Amount, Date.
-- Zadania:

-- Znajdź wszystkie transakcje, których wartość jest większa niż średnia wartość transakcji w ich regionie.
-- Wyświetl region, który ma najwyższą średnią wartość transakcji.


-- Dodaj kolumnę Rank, która przypisuje rangę (od najwyższej do najniższej pensji) w obrębie każdego działu (DepartmentID).
SELECT
    RANK() OVER (PARTITION BY DepartmentID  ORDER BY Salary DESC) as Rank
from Employees;

-- Policz średnią pensję w każdym dziale, a następnie dodaj kolumnę SalaryDifference, która pokazuje różnicę między pensją pracownika a średnią pensją w jego dziale.

SELECT 
    Name,
    DepartmentID,
    Salary,
    AVG(Salary) OVER (PARTITION BY DepartmentID) AS AvgDepartmentSalary,
    Salary - AVG(Salary) OVER (PARTITION BY DepartmentID) AS SalaryDifference
FROM Employees;





-- Znajdź wszystkie transakcje, których wartość jest większa niż średnia wartość transakcji w ich regionie

WITH CTE AS (
    SELECT AVG(Amount) AS avg_sales, Region
    FROM Sales
    GROUP BY Region
)
SELECT s.SaleID, s.Region, s.Amount
FROM Sales s
JOIN CTE c
ON s.Region = c.Region
WHERE s.Amount > c.avg_sales;

-- Wyświetl region, który ma najwyższą średnią wartość transakcji.


SELECT DISTINCT
    Region,
    AVG(Amount) OVER (PARTITION BY Region) AS AvgAmount
FROM Sales
ORDER BY AvgAmount DESC
--LIMIT 1;

WITH AvgAmountByRegion AS (
    SELECT 
        Region,
        AVG(Amount) AS AvgAmount
    FROM Sales
    GROUP BY Region
)
SELECT Region, AvgAmount
FROM AvgAmountByRegion
ORDER BY AvgAmount DESC
--LIMIT 1;
