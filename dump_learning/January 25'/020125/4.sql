-- SQL: Grupowanie i zaawansowane JOIN
-- Grupowanie z agregacją:

-- Dla tabeli Sales wyświetl:
-- Suma Amount dla każdego Region.
-- Średnia Amount oraz liczba transakcji w każdym Region.
-- Zaawansowany JOIN:

-- Tabele:
-- Employees: EmployeeID, Name, DepartmentID, Salary.
-- Departments: DepartmentID, DepartmentName.
-- Zadania:
-- Wyświetl nazwiska pracowników oraz nazwę ich działu.
-- Znajdź dział, w którym pracownicy zarabiają najwięcej łącznie (SUM(Salary)).
-- Podzapytania w JOIN:

-- Wyświetl nazwiska pracowników, których wynagrodzenie jest wyższe niż średnie wynagrodzenie w ich dziale.


-- SaleID	Region	Amount
-- 1	North	500
-- 2	South	300
-- 3	North	700
-- 4	West	400
-- 5	South	1000

SELECT SUM(Amount) as Suma, AVG(Amount) as Srednia, Count(Amount) as Ilosc, Region
from Sales
group by Region;


SELECT Name, DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID;


WITH CTE AS (
    SELECT Name, DepartmentName, Salary
    FROM Employees e
    JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
)
SELECT DepartmentName, SUM(Salary) AS TotalSalary
FROM CTE
GROUP BY DepartmentName
ORDER BY TotalSalary DESC;


WITH CTE AS (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
)
SELECT e.Name, e.Salary, d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
JOIN CTE
ON e.DepartmentID = CTE.DepartmentID
WHERE e.Salary > CTE.AvgSalary;
