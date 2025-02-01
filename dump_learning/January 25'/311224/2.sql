-- SQL: Zaawansowane funkcje i JOIN
-- Ćwiczenie z funkcjami:

-- Wyświetl różnicę między maksymalną a minimalną wartością Amount z tabeli Sales.
-- Policz, ile transakcji miało wartość większą niż średnia (AVG(Amount)).
-- Ćwiczenie z JOIN: Załóżmy, że masz dwie tabele:

-- Employees: EmployeeID, Name, DepartmentID.

-- Departments: DepartmentID, DepartmentName.

-- Wyświetl imiona pracowników razem z nazwą ich działu.

-- Policz, ilu pracowników pracuje w każdym dziale.

SELECT MAX(Amount) - MIN(Amount) as Diff_Values from Sales;
SELECT Count(Amount) from Sales 
HAVING Amount > (SELECT AVG(AMOUNT) from Sales);


SELECT Name, DepartmentName
from Employees e
JOIN Departaments d
ON e.DepartmentID = d.DepartmentID;


SELECT Count(Name), DepartmentName
from Employees e
JOIN Departaments d
ON e.DepartmentID = d.DepartmentID
group by DepartmentName;


-- SQL: Podzapytania (Subqueries)
-- Ćwiczenie z tabelą Sales:

-- Znajdź wszystkie transakcje (SaleID), których kwota jest większa niż średnia kwota (AVG(Amount)).
-- Ćwiczenie z tabelami Employees i Departments:

-- Wyświetl pracowników, którzy pracują w dziale o największej liczbie pracowników.

SELECT SaleID, Amount 
from Employees
WHERE Amount > (SELECT AVG(Amount) from Employees);

WITH DepartmentCounts AS (
    SELECT d.DepartmentID, d.DepartmentName, COUNT(e.Name) AS EmployeeCount
    FROM Employees e
    JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentID, d.DepartmentName
)
SELECT e.Name, d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentID = (
    SELECT DepartmentID
    FROM DepartmentCounts
    WHERE EmployeeCount = (SELECT MAX(EmployeeCount) FROM DepartmentCounts)
);