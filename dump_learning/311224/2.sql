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
group by DepartmentName