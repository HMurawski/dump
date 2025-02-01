-- 1. Agregacja i filtrowanie
-- Załóżmy, że masz tabelę Sales:

-- SaleID (unikalne ID transakcji),
-- Region (region sprzedaży),
-- Amount (kwota transakcji),
-- Date (data transakcji).
-- Zadania:

-- Znajdź łączną wartość sprzedaży dla transakcji, które miały miejsce w 2024 roku.
-- Policz, ile transakcji odbyło się w każdym regionie i posortuj wyniki malejąco według liczby transakcji.
-- Znajdź średnią kwotę transakcji w regionie, który miał najwięcej transakcji.
-- 2. Praca z funkcją okna
-- Załóżmy, że masz tabelę Employees:

-- EmployeeID,
-- Name,
-- Salary,
-- DepartmentID.
-- Zadania:

-- Wyświetl wynagrodzenie każdego pracownika oraz średnią pensję w jego dziale.
-- Dodaj kolumnę z rankingiem wynagrodzeń w każdym dziale (najwyższa pensja = 1).


SELECT SUM(Amount)
from Sales
where Year(Date) = 2024;

SELECT Count(SaleID), Region
from Sales
GROUP BY Region
ORDER by Count(SaleID) DESC;



SELECT Count(SaleID), Region, AVG(Amount)
from Sales
GROUP BY Region
ORDER by Count(SaleID) DESC
-- #LIMIT 1;

with CTE as 
(Select DepartmentID, AVG(Salary) as Dep_Salary
from Employees
group by DepartmentID)
SELECT e.Name, e.Salary, c.Dep_Salary
FROM Employees e
JOIN Cte c 
ON e.DepartmentID = c.DepartmentID;

WITH CTE AS (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
)
SELECT 
    e.Name,
    e.Salary,
    d.DepartmentName,
    RANK() OVER (PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) AS SalaryRank
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
JOIN CTE c
ON e.DepartmentID = c.DepartmentID;
